resource_name :nginx_vhost

property :vhost_name, String, name_property: true
property :variables, Hash, default: {}
property :cookbook, String
property :template, [String, Array]

action :enable do
  service 'nginx' do
    action :nothing
  end

  path = ::File.join(::ChefCookbook::NgxHelper.conf_dir, 'sites-available', "#{new_resource.vhost_name}")
  if new_resource.template
    declare_resource(:template, path) do
      source new_resource.template
      cookbook new_resource.cookbook
      variables(new_resource.variables)
      action :create
      notifies :reload, 'service[nginx]', :delayed
    end
  end

  path_enabled = ::File.join(::ChefCookbook::NgxHelper.conf_dir, 'sites-enabled', "#{new_resource.vhost_name}")

  bash "enable nginx #{new_resource.vhost_name} vhost" do
    code <<-EOH
      SYSCONFDIR='#{::ChefCookbook::NgxHelper.conf_dir}'
      SITENAME='#{new_resource.vhost_name}'
      if [ -e $SYSCONFDIR/sites-enabled/$SITENAME ]; then
        echo "This site is already enabled!"
        exit 0
      fi
      if ! [ -e $SYSCONFDIR/sites-available/$SITENAME ]; then
        echo "This site does not exist!"
        exit 1
      fi
      ln -sf $SYSCONFDIR/sites-available/$SITENAME $SYSCONFDIR/sites-enabled/$SITENAME
      echo "Site $SITENAME installed; reload nginx to enable."
    EOH
    action :run
    not_if { ::File.symlink?(path_enabled) }
    notifies :reload, 'service[nginx]', :delayed
  end
end
