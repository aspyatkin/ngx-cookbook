# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [2.2.0] - 2020-07-05
### Changed
- Update Nginx version to 1.19.0.

### Removed
- Remove `with_ipv6` property from `nginx_install` resource.

## [2.1.2] - 2019-10-28
### Changed
- Update Nginx version to 1.17.5.

## [2.1.1] - 2019-04-11
### Added
- Introduced a new `nginx_install` resource property: `pid`, which allows to control PID file location.

## [2.1.0] - 2019-04-10
### Added
- Introduced a new `nginx_install` resource property: `directives`, which allows to write directives into the main Nginx configuration file.
- Introduced a new `nginx_install` resource property: `manage_user`, which allows to skip creating a separate user for Nginx web server and to use a provided one instead.

### Changed
- Write some resource properties to `node.run_state['nginx']` so that they can be reused in other resources (e.g. `log_dir`).

## [2.0.0] - 2019-04-04
### Changed
Major redesign. From now on this cookbook does not wrap [nginx](https://github.com/sous-chefs/nginx) cookbook and provides a set of LWRPs instead.

## [1.2.1] - 2019-02-04
### Changed
- Ensure GeoLite2 databases are always up-to-date.

## [1.2.0] - 2019-01-27
### Added
- Add `ngx_http_gzip_static_module` module.
- Add `ngx_brotli` module.

### Changed
- Update nginx mainline version to 1.15.8 and stable version to 1.14.2.
- Update GeoLite2 database file checksums.
- Update OpenSSL and njs versions.
- Change `main_ext` log_format name to `combined_ext`.

### Removed
- Remove nginx-ct module.

## [1.1.1] - 2018-09-09
### Changed
- Update nginx mainline version to 1.15.3.
- Update GeoLite2 database file checksums.

## [1.1.0] - 2018-08-17
### Changed
- Update nginx mainline version to 1.15.2.
- Update njs version to 0.2.3.
- Update OpenSSL version to 1.1.0i.
- Update `ngx_http_geoip2_module` version to 3.0.
- `with_ct` option is now `false` by default.
- `with_headers_more` option is now `false` by default.

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
