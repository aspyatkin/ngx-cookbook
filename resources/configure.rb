resource_name :nginx_configure

property :flags, Array, default: []
property :env_vars, Hash, default: {}

default_action :append

action :append do
  ::ChefCookbook::NgxHelper.init_run_state(node)
  node.run_state['nginx']['configure_flags'].push(*new_resource.flags)
end

action :prepend do
  ::ChefCookbook::NgxHelper.init_run_state(node)
  node.run_state['nginx']['configure_flags'].unshift(*new_resource.flags)
end

action :merge_env do
  ::ChefCookbook::NgxHelper.init_run_state(node)
  node.run_state['nginx']['configure_env_vars'].merge!(new_resource.env_vars)
end
