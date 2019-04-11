resource_name :nginx_install

property :name, String, name_property: true

property :manage_user, [TrueClass, FalseClass], default: true
property :user, String, default: 'nginx'
property :uid, Integer, default: 799
property :group, String, default: 'nginx'
property :gid, Integer, default: 799

property :pid, String, default: '/var/run/nginx.pid'
property :log_dir, String, default: '/var/log/nginx'
property :install_dir_template, String, default: '/opt/nginx-%{version}'

property :version, String, default: '1.15.10'
property :url_template, String, default: 'http://nginx.org/download/nginx-%{version}.tar.gz'
property :checksum, String, default: 'b865743abd52bce4745d0f7e7fedde3cafbaaab617b022c105e3e4e456537c3c'

property :with_ipv6, [TrueClass, FalseClass], default: true
property :with_threads, [TrueClass, FalseClass], default: false
property :with_debug, [TrueClass, FalseClass], default: false

property :directives, Hash, default: {}

default_action :run

action :run do
  ::ChefCookbook::NgxHelper.init_run_state(node)

  node.run_state['nginx']['user'] = new_resource.user
  node.run_state['nginx']['group'] = new_resource.group
  node.run_state['nginx']['log_dir'] = new_resource.log_dir
  node.run_state['nginx']['pid'] = new_resource.pid

  ohai_plugin 'nginx' do
    cookbook 'ngx'
    source_file 'ohai-nginx.rb.erb'
    variables(
      executable: ::ChefCookbook::NgxHelper.executable
    )
    resource :template
  end

  if new_resource.manage_user
    group new_resource.group do
      gid new_resource.gid
      action :create
    end

    user new_resource.user do
      uid new_resource.uid
      group new_resource.group
      shell '/bin/bash'
      manage_home false
      action :create
    end
  end

  directory ::ChefCookbook::NgxHelper.conf_dir do
    mode 0o750
    recursive true
    action :create
  end

  directory new_resource.log_dir do
    owner new_resource.user
    group node['root_group']
    mode 0o755
    recursive true
    action :create
  end

  %w[sites-available sites-enabled conf.d includes].each do |leaf|
    directory ::File.join(::ChefCookbook::NgxHelper.conf_dir, leaf) do
      mode 0o755
      action :create
    end
  end

  tarball_path = ::File.join(::Chef::Config['file_cache_path'], "nginx-#{new_resource.version}.tar.gz")
  download_url = format(new_resource.url_template, version: new_resource.version)

  remote_file tarball_path do
    source download_url
    checksum new_resource.checksum
    action :create
  end

  install_dir = format(new_resource.install_dir_template, version: new_resource.version)

  conf_path = ::File.join(::ChefCookbook::NgxHelper.conf_dir, 'nginx.conf')

  service 'nginx' do
    action :nothing
  end

  template conf_path do
    cookbook 'ngx'
    source 'nginx.conf.erb'
    notifies :reload, 'service[nginx]', :delayed
    mode 0o644
    variables(
      user: new_resource.user,
      group: new_resource.group,
      error_log: ::File.join(new_resource.log_dir, 'error.log'),
      error_log_options: nil,
      pid: new_resource.pid,
      conf_dir: ::ChefCookbook::NgxHelper.conf_dir,
      directives: new_resource.directives
    )
    action :create
  end

  sbin_path = ::File.join(install_dir, 'sbin', 'nginx')

  nginx_configure 'default' do
    flags %W[
      --prefix=#{install_dir}
      --conf-path=#{conf_path}
      --sbin-path=#{sbin_path}
      --with-cc-opt=-Wno-error
    ]
    action :prepend
  end

  src_dir = ::File.join(::Chef::Config['file_cache_path'], "nginx-#{new_resource.version}")

  bash 'unarchive nginx source' do
    cwd ::File.dirname(tarball_path)
    code <<-EOH
      tar zxf #{::File.basename(tarball_path)} -C #{::File.dirname(tarball_path)} --no-same-owner
    EOH
    action :run
    not_if { ::File.directory?(src_dir) }
  end

  pkg_names = %w[
    libpcre3
    libpcre3-dev
    zlib1g
    zlib1g-dev
  ]

  pkg_names.each do |pkg_name|
    package pkg_name do
      action :install
    end
  end

  if new_resource.with_ipv6
    nginx_configure 'IPv6 support' do
      flags %w[--with-ipv6]
      action :append
    end
  end

  if new_resource.with_threads
    nginx_configure 'thread_pool support' do
      flags %w[--with-threads]
      action :append
    end
  end

  if new_resource.with_debug
    nginx_configure 'enable debugging log' do
      flags %w[--with-debug]
      action :append
    end
  end

  bash 'compile nginx source' do
    cwd src_dir
    environment(lazy { node.run_state['nginx']['configure_env_vars'] })
    code(lazy { "./configure #{node.run_state['nginx']['configure_flags'].join(' ')} && make && make install" })
    not_if do
      node.automatic_attrs['nginx'] &&
        node.automatic_attrs['nginx']['version'] == new_resource.version &&
        node.automatic_attrs['nginx']['configure_arguments'].sort == node.run_state['nginx']['configure_flags'].sort
    end

    action :run
    notifies :restart, 'service[nginx]'
  end

  link ::ChefCookbook::NgxHelper.link_dir do
    to install_dir
    link_type :symbolic
    action :create
  end

  systemd_unit 'nginx.service' do
    content(
      {
        Unit: {
          Description: 'The nginx HTTP and reverse proxy server',
          After: [
            'network.target',
            'remote-fs.target',
            'nss-lookup.target'
          ]
        },
        Service: {
          ExecStartPre: "#{::ChefCookbook::NgxHelper.executable} -t",
          ExecStart: ::ChefCookbook::NgxHelper.executable,
          ExecReload: '/bin/kill -s HUP $MAINPID',
          ExecStop: '/bin/kill -s QUIT $MAINPID',
          PrivateTmp: 'true'
        },
        Install: {
          WantedBy: 'multi-user.target'
        }
      }
    )
    action %i[create enable]
  end

  service 'nginx' do
    supports status: true, restart: true, reload: true
    action %i[start enable]
  end
end
