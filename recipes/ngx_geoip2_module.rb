id = 'ngx'

include_recipe 'libmaxminddb::default'

ngx_geoip2_name = "ngx_geoip2-#{node[id]['geoip2']['version']}"
ngx_geoip2_tarball = "#{ngx_geoip2_name}.tar.gz"
ngx_geoip2_tarball_path = ::File.join(
  ::Chef::Config['file_cache_path'],
  ngx_geoip2_tarball
)
ngx_geoip2_src_url = "#{node[id]['geoip2']['url']}/#{node[id]['geoip2']['version']}.tar.gz"
ngx_geoip2_src_dir = ::File.join(::Chef::Config['file_cache_path'], ngx_geoip2_name)

remote_file ngx_geoip2_tarball_path do
  source ngx_geoip2_src_url
  checksum node[id]['geoip2']['checksum']
  mode 0644
end

directory ngx_geoip2_src_dir do
  action :create
end

execute 'Unpack nginx-geoip2 tarball' do
  command "tar --no-same-owner -zxf #{ngx_geoip2_tarball} -C #{ngx_geoip2_src_dir} "\
          '--strip-components 1'
  cwd ::Chef::Config['file_cache_path']
  creates ::File.join(ngx_geoip2_src_dir, 'config')
  action :run
end

country_database_tarball = 'GeoLite2-Country.tar.gz'
country_database_tarball_path = ::File.join(
  ::Chef::Config['file_cache_path'],
  country_database_tarball
)
remote_file country_database_tarball_path do
  source node[id]['geoip2']['databases']['country']['url']
  checksum node[id]['geoip2']['databases']['country']['checksum']
  mode 0644
end

city_database_tarball = 'GeoLite2-City.tar.gz'
city_database_tarball_path = ::File.join(
  ::Chef::Config['file_cache_path'],
  city_database_tarball
)
remote_file city_database_tarball_path do
  source node[id]['geoip2']['databases']['city']['url']
  checksum node[id]['geoip2']['databases']['city']['checksum']
  mode 0644
end

directory node[id]['geoip2']['databases']['dir'] do
  mode 0755
  recursive true
  action :create
end

execute 'Unpack GeoLite2-Country database' do
  command "tar -zxvf #{country_database_tarball_path} --no-same-owner --wildcards --no-anchored --strip-components 1 '#{node[id]['geoip2']['databases']['country']['name']}'"
  cwd node[id]['geoip2']['databases']['dir']
  creates ::File.join(
    node[id]['geoip2']['databases']['dir'],
    node[id]['geoip2']['databases']['country']['name']
  )
  action :run
end

execute 'Unpack GeoLite2-City database' do
  command "tar -zxvf #{city_database_tarball_path} --no-same-owner --wildcards --no-anchored --strip-components 1 '#{node[id]['geoip2']['databases']['city']['name']}'"
  cwd node[id]['geoip2']['databases']['dir']
  creates ::File.join(
    node[id]['geoip2']['databases']['dir'],
    node[id]['geoip2']['databases']['city']['name']
  )
  action :run
end

node.run_state['nginx_configure_flags'] = \
  node.run_state['nginx_configure_flags'] | ["--add-module=#{ngx_geoip2_src_dir}"]
