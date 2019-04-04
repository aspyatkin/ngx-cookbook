resource_name :nginx_module

property :name, String, name_property: true
property :packages, Array, default: []
property :flags, Array, default: []
property :env_vars, Hash, default: {}

default_action :add

action :add do
  new_resource.packages.each do |pkg_name|
    package pkg_name do
      action :install
    end
  end

  nginx_configure "nginx #{new_resource.name} module" do
    flags new_resource.flags
    env_vars new_resource.env_vars
    action %i[append merge_env]
  end
end
