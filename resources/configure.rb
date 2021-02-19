resource_name :nginx_configure
provides :nginx_configure

property :flags, [String, Array], default: []
property :env_vars, Hash, default: {}

default_action :append

action :append do
  ::ChefCookbook::NgxHelper.init_run_state(node)
  flags = new_resource.flags.is_a?(String) ? [new_resource.flags] : new_resource.flags
  node.run_state['nginx']['configure_flags'].push(*flags)
end

action :prepend do
  ::ChefCookbook::NgxHelper.init_run_state(node)
  flags = new_resource.flags.is_a?(String) ? [new_resource.flags] : new_resource.flags
  node.run_state['nginx']['configure_flags'].unshift(*flags)
end

action :merge_env do
  ::ChefCookbook::NgxHelper.init_run_state(node)
  node.run_state['nginx']['configure_env_vars'].merge!(new_resource.env_vars)
end
