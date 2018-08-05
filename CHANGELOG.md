# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [1.0.3] - 2018-08-05
### Added
- Add `main_ext` log format (suitable for Nginx Amplify agent)

## [1.0.2] - 2018-06-15
### Added
- Support compiling nginx with [ngx_http_lua_module](https://github.com/openresty/lua-nginx-module).

## [1.0.1] - 2018-06-14
### Added
- Add a CHANGELOG file.
- Add `ngx:test` recipe so as to verify `nginx -V` output during Kitchen tests.
- Support compiling nginx with [ngx_devel_kit](https://github.com/simplresty/ngx_devel_kit) module.

## [1.0.0] - 2018-06-11

First appearance in public.

### Added
- Upload the cookbook to [Chef Supermarket](https://supermarket.chef.io/cookbooks/ngx).

### Deprecated
- The project supersedes [modern_nginx](https://github.com/aspyatkin/modern_nginx).
