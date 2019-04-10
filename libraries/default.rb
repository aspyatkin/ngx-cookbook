module ChefCookbook
  module NgxHelper
    def self.init_run_state(node)
      unless node.run_state.key?('nginx')
        node.run_state['nginx'] = {
          'configure_flags' => [],
          'configure_env_vars' => {},
          'user' => nil,
          'group' => nil,
          'log_dir' => nil
        }
      end
    end

    def self.link_dir
      '/opt/nginx'
    end

    def self.executable
      ::File.join(link_dir, 'sbin', 'nginx')
    end

    def self.conf_dir
      '/etc/nginx'
    end

    def self.include_path(name)
      ::File.join(conf_dir, 'includes', name)
    end
  end
end
