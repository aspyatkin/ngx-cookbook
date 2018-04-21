name 'ngx'
maintainer 'Alexander Pyatkin'
maintainer_email 'aspyatkin@gmail.com'
license 'MIT'
version '0.0.1'
description 'Install and configure Nginx'

recipe 'ngx::default', 'Install and configure Nginx'

source_url 'https://github.com/aspyatkin/ngx-cookbook' if respond_to?(:source_url)

supports 'ubuntu'
