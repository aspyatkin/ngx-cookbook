resource_name :nginx_conf

property :name, String, name_property: true

property :cookbook, String
property :template, [String, Array], required: true
property :variables, Hash, default: {}

default_action :create

action :create do
  service 'nginx' do
    action :nothing
  end

  template ::File.join(::ChefCookbook::NgxHelper.conf_dir, 'conf.d', "#{new_resource.name}.conf") do
    cookbook new_resource.cookbook
    source new_resource.template
    mode 0o644
    variables new_resource.variables
    verify "#{::ChefCookbook::NgxHelper.executable} -t"
    action :create
    notifies :reload, 'service[nginx]'
  end
end
