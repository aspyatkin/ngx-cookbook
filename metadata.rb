name 'ngx'
maintainer 'Alexander Pyatkin'
maintainer_email 'aspyatkin@gmail.com'
license 'MIT'
version '1.2.1'
description 'Install and configure Nginx'

recipe 'ngx::default', 'Install and configure Nginx'

source_url 'https://github.com/aspyatkin/ngx-cookbook' if respond_to?(:source_url)

supports 'ubuntu'

depends 'nginx', '~> 9.0.0'
depends 'dhparam', '~> 1.0.1'
depends 'libmaxminddb', '~> 1.0.1'
depends 'logrotate', '~> 2.2.0'

chef_version '>= 12'
supports 'debian', '>= 8.0'
supports 'ubuntu', '>= 16.04'
