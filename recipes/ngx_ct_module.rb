id = 'ngx'

ngx_ct_name = "ngx_ct-#{node[id]['ct']['version']}"
ngx_ct_tarball = "#{ngx_ct_name}.tar.gz"
ngx_ct_tarball_path = ::File.join(
  ::Chef::Config['file_cache_path'],
  ngx_ct_tarball
)
ngx_ct_src_url = "#{node[id]['ct']['url']}/v#{node[id]['ct']['version']}.tar.gz"
ngx_ct_src_dir = ::File.join(::Chef::Config['file_cache_path'], ngx_ct_name)

remote_file ngx_ct_tarball_path do
  source ngx_ct_src_url
  checksum node[id]['ct']['checksum']
  mode 0644
end

directory ngx_ct_src_dir do
  action :create
end

execute 'Unpack nginx-ct tarball' do
  command "tar --no-same-owner -zxf #{ngx_ct_tarball} -C #{ngx_ct_src_dir} "\
          '--strip-components 1'
  cwd ::Chef::Config['file_cache_path']
  creates ::File.join(ngx_ct_src_dir, 'config')
  action :run
end

node.run_state['nginx_configure_flags'] = \
  node.run_state['nginx_configure_flags'] | ["--add-module=#{ngx_ct_src_dir}"]
