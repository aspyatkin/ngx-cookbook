# ngx cookbook
[![Chef cookbook](https://img.shields.io/cookbook/v/ngx.svg?style=flat-square)]()
[![license](https://img.shields.io/github/license/aspyatkin/ngx-cookbook.svg?style=flat-square)]()  
Chef cookbook to to install and configure [nginx](http://nginx.org) web server.

## Concept

This cookbook provides a set of [LWRPs](https://chef.readthedocs.io/en/latest/lwrps_custom.html) to install and configure nginx web server, namely `nginx_configure`, `nginx_install`, `nginx_module`, `nginx_conf`, `nginx_include` and `nginx_vhost`. The first three have to do with building nginx from source, the other help with web server configuration. This is a minimal set that should be extended in order to support building nginx with extra modules (both standard and custom ones). One may take a look at [ngx-modules](https://github.com/aspyatkin/ngx-modules-cookbook) repository, which provides examples on how this set can be utilized.

## Usage

```ruby
# instruct Chef to build nginx with http_gzip_static module
nginx_module 'http_gzip_static' do
  flags %w[--with-http_gzip_static_module]
  action :add
end

# install nginx
nginx_install 'default' do
  with_threads true
  directives(
    main: {
      worker_processes: 'auto'
    },
    events: {
      worker_connections: 1024
    },
    http: {
      sendfile: 'on'
    }
  )
  action :run
end

# create http_gzip_static config at /etc/nginx/conf.d
nginx_conf 'http_gzip_static' do
  template 'http_gzip_static.conf.erb'
  action :create
end

# create an include file at /etc/nginx/includes
nginx_include 'favicons' do
  template 'favicons.erb'
  variables server_name: 'www.acme.corp'
  action :create
end

# create a vhost file at /etc/nginx/sites-available
# enable it by creating a symlink at /etc/nginx/sites-enabled
nginx_vhost 'acme.corp' do
  template 'acme.corp.conf.erb'
end
```

**templates/default/http_gzip_static.conf.erb**
```
gzip_static  on;
```

**templates/default/favicons.erb**
```
location = /favicon.ico {
  root /path/to/my/favicons;
}
```

**templates/default/acme.corp.conf.erb**
```
server {
  server_name <%= @server_name %>;
  listen 80;

  include /etc/nginx/includes/favicons;

  location / {
    ...
  }
}
```

## License
MIT @ [Alexander Pyatkin](https://github.com/aspyatkin)
