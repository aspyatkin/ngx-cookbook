id = 'ngx'

node.default['nginx']['install_method'] = 'source'

node.default['nginx']['version'] = node[id][node[id]['install']]['version']

node.default['nginx']['source']['version'] = node['nginx']['version']
node.default['nginx']['source']['prefix'] = \
  "/opt/nginx-#{node['nginx']['source']['version']}"
node.default['nginx']['source']['conf_path'] = \
  "#{node['nginx']['dir']}/nginx.conf"
node.default['nginx']['source']['sbin_path'] = \
  "#{node['nginx']['source']['prefix']}/sbin/nginx"
node.default['nginx']['source']['default_configure_flags'] = %W(
  --prefix=#{node['nginx']['source']['prefix']}
  --conf-path=#{node['nginx']['dir']}/nginx.conf
  --sbin-path=#{node['nginx']['source']['sbin_path']}
)

node.default['nginx']['configure_flags'] = []
node.default['nginx']['source']['url'] = \
  "http://nginx.org/download/nginx-#{node['nginx']['source']['version']}.tar.gz"
node.default['nginx']['source']['checksum'] = \
  node[id][node[id]['install']]['checksum']

module_list = %w(
  nginx::http_gzip_static_module
)

module_list << 'nginx::http_ssl_module' if node[id]['with_openssl']
module_list << 'nginx::openssl_source' if node[id]['with_openssl']
module_list << 'nginx::http_v2_module' if node[id]['with_http2'] && node[id]['with_openssl']
module_list << 'nginx::ipv6' if node[id]['with_ipv6']
module_list << 'nginx::http_stub_status_module' if node[id]['with_status']
module_list << 'nginx::headers_more_module' if node[id]['with_headers_more']
module_list << "#{id}::ngx_ct_module" if node[id]['with_ct']
module_list << 'nginx::http_realip_module' if node[id]['with_realip']
module_list << "#{id}::ngx_geoip2_module" if node[id]['with_geoip2']
module_list << "#{id}::ngx_secure_link_module" if node[id]['with_secure_link']
module_list << "#{id}::ngx_njs_module" if node[id]['with_njs']
module_list << "#{id}::ngx_debug_module" if node[id]['with_debug']

node.default['nginx']['source']['modules'] = module_list
node.default['nginx']['source']['use_existing_user'] = false

node.default['nginx']['server_tokens'] = 'off'
node.default['nginx']['default_site_enabled'] = false

if node[id]['with_headers_more']
  node.default['nginx']['headers_more']['version'] = \
    node[id]['headers_more']['version']
  node.default['nginx']['headers_more']['source_url'] = \
    node[id]['headers_more']['url'] % {
      version: node[id]['headers_more']['version']
    }
  node.default['nginx']['headers_more']['source_checksum'] = \
    node[id]['headers_more']['checksum']
end

if node[id]['with_openssl']
  node.default['nginx']['openssl_source']['version'] = \
    node[id]['openssl']['version']
  node.default['nginx']['openssl_source']['url'] = \
    'http://www.openssl.org/source/openssl-'\
    "#{node[id]['openssl']['version']}.tar.gz"
end

include_recipe 'nginx::default'

if node[id]['with_openssl']
  openssl_src_filename = ::File.basename(node['nginx']['openssl_source']['url'])
  openssl_src_filepath = ::File.join(
    ::Chef::Config['file_cache_path'],
    openssl_src_filename
  )

  edit_resource(:remote_file, openssl_src_filepath) do
    source node['nginx']['openssl_source']['url']
    owner 'root'
    checksum node[id]['openssl']['checksum']
    group node['root_group']
    mode 0644
    action :create
  end

  ssl_defaults_conf = ::File.join(
    node['nginx']['dir'],
    'conf.d',
    'ssl_defaults.conf'
  )

  dhparam_h = ::ChefCookbook::DHParam.new(node)

  template ssl_defaults_conf do
    source 'ssl.defaults.erb'
    mode 0644
    variables(
      ssl_dhparam: dhparam_h.default_key_file,
      ssl_configuration: node[id]['ssl_configuration']
    )
    notifies :reload, 'service[nginx]', :delayed
    action :create
  end
end

nginx_pid_file = \
  if (node['nginx']['repo_source'].nil? || node['nginx']['repo_source'] == 'distro') &&
     (node['init_package'] == 'systemd' || node['platform_version'].to_f == 14.04)
    '/run/nginx.pid'
  else
    '/var/run/nginx.pid'
  end

logrotate_app 'nginx' do
  path "#{node['nginx']['log_dir']}/*.log"
  frequency 'daily'
  rotate 30
  options %w(
    missingok
    compress
    delaycompress
    notifempty
  )
  postrotate "[ ! -f #{nginx_pid_file} ] || kill -USR1 `cat #{nginx_pid_file}`"
  action :enable
end
