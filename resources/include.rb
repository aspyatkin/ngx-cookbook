resource_name :nginx_include

property :name, String, name_property: true

property :cookbook, String, default: 'ngx'
property :template, [String, Array], required: true
property :variables, Hash, default: {}

default_action :create

action :create do
  service 'nginx' do
    action :nothing
  end

  template ::File.join(::ChefCookbook::NgxHelper.conf_dir, 'includes', new_resource.name) do
    cookbook new_resource.cookbook
    source new_resource.template
    mode 0o644
    variables new_resource.variables
    action :create
  end
end
