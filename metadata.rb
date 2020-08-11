name 'ngx'
maintainer 'Alexander Pyatkin'
maintainer_email 'aspyatkin@gmail.com'
license 'MIT'
version '2.2.1'
description 'Install and configure nginx web server'

scm_url = 'https://github.com/aspyatkin/ngx-cookbook'
source_url scm_url if respond_to?(:source_url)
issues_url "#{scm_url}/issues" if respond_to?(:issues_url)

supports 'ubuntu'

chef_version '>= 12'
supports 'debian', '>= 8.0'
supports 'ubuntu', '>= 16.04'

depends 'ohai', '~> 5.2.5'
