execute 'test nginx install' do
  command "#{node['nginx']['source']['sbin_path']} -V"
  live_stream true
  action :run
end
