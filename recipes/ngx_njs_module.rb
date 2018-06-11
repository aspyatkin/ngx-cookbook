id = 'ngx'

ngx_njs_name = "njs-#{node[id]['njs']['version']}"
ngx_njs_tarball = "#{ngx_njs_name}.tar.gz"
ngx_njs_tarball_path = ::File.join(
  ::Chef::Config['file_cache_path'],
  ngx_njs_tarball
)
ngx_njs_src_url = "#{node[id]['njs']['url']}/#{node[id]['njs']['version']}.tar.gz"
ngx_njs_src_dir = ::File.join(::Chef::Config['file_cache_path'], ngx_njs_name)

remote_file ngx_njs_tarball_path do
  source ngx_njs_src_url
  checksum node[id]['njs']['checksum']
  mode 0644
end

directory ngx_njs_src_dir do
  action :create
end

execute 'Unpack nginx-njs tarball' do
  command "tar --no-same-owner -zxf #{ngx_njs_tarball} -C #{ngx_njs_src_dir} "\
          '--strip-components 1'
  cwd ::Chef::Config['file_cache_path']
  creates ::File.join(ngx_njs_src_dir, 'config')
  action :run
end

node.run_state['nginx_configure_flags'] = \
  node.run_state['nginx_configure_flags'] | ["--add-module=#{ngx_njs_src_dir}/nginx"]
