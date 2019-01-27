id = 'ngx'

ngx_brotli_name = "ngx_brotli-#{node[id]['brotli']['version']}"
ngx_brotli_src_dir = ::File.join(::Chef::Config['file_cache_path'], ngx_brotli_name)

directory ngx_brotli_src_dir do
  action :create
end

git ngx_brotli_src_dir do
  repository node[id]['brotli']['url']
  revision node[id]['brotli']['version']
  enable_checkout false
  enable_submodules true
  action :sync
end

node.run_state['nginx_configure_flags'] = \
  node.run_state['nginx_configure_flags'] | ["--add-module=#{ngx_brotli_src_dir}"]
