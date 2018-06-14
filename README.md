# ngx cookbook
[![Chef cookbook](https://img.shields.io/cookbook/v/ngx.svg?style=flat-square)]()
[![license](https://img.shields.io/github/license/aspyatkin/ngx-cookbook.svg?style=flat-square)]()  
A cookbook to provide resources to install, configure and run [nginx](http://nginx.org) web server. Wraps [nginx cookbook](https://github.com/chef-cookbooks/nginx).

## Recipes

### ngx::default

Install nginx from source, either `stable` or `mainline` version (this is specified in `node['ngx']['install']` attribute, which defaults to `stable`).

Additionally, the following attributes may be utilised so as to compile nginx with extra modules/options:
- `node['ngx']['with_openssl']` - [ngx_http_ssl_module](https://nginx.ru/en/docs/http/ngx_http_ssl_module.html) with openssl built from source, default `true`
- `node['ngx']['with_http2']` - [ngx_http_v2_module](https://nginx.ru/en/docs/http/ngx_http_v2_module.html), default `true`
- `node['ngx']['with_ipv6']` - IPv6 support, default `true`
- `node['ngx']['with_ct']` - [nginx-ct module](https://github.com/grahamedgecombe/nginx-ct), default `true`
- `node['ngx']['with_headers_more']` - [ngx_headers_more module](https://github.com/openresty/headers-more-nginx-module), default `true`
- `node['ngx']['with_status']` - [ngx_http_stub_status_module](ngx_http_stub_status_module), default `false`
- `node['ngx']['with_realip']` - [ngx_http_realip_module](https://nginx.ru/en/docs/http/ngx_http_realip_module.html), default `false`
- `node['ngx']['with_geoip2']` - [ngx_http_geoip2_module](https://github.com/leev/ngx_http_geoip2_module), default `false`
- `node['ngx']['with_secure_link']` - [ngx_http_secure_link_module](https://nginx.org/en/docs/http/ngx_http_secure_link_module.html), default `false`
- `node['ngx']['with_njs']` - [ngx_http_js_module](http://nginx.org/en/docs/http/ngx_http_js_module.html), default `false`
- `node['ngx']['with_debug']` - [debugging support](https://nginx.ru/en/docs/debugging_log.html), default `false`
- `node['ngx']['with_devel_kit']` - [ngx_devel_kit](https://github.com/simplresty/ngx_devel_kit), default `false`

## Testing
Run `script/bootstrap` to install necessary Ruby Gems.

Run `script/test` to perform [KitchenCI](http://kitchen.ci/) tests.

## License
MIT @ [Alexander Pyatkin](https://github.com/aspyatkin)
