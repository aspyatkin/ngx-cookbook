name 'ngx'
maintainer 'Alexander Pyatkin'
maintainer_email 'aspyatkin@gmail.com'
license 'MIT'
version '2.0.0'
description 'Install and configure nginx web server'

source_url 'https://github.com/aspyatkin/ngx-cookbook' if respond_to?(:source_url)

supports 'ubuntu'

chef_version '>= 12'
supports 'debian', '>= 8.0'
supports 'ubuntu', '>= 16.04'

depends 'ohai', '~> 5.2.5'
