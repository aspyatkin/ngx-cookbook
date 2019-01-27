id = 'ngx'

default[id]['install'] = 'stable'

default[id]['stable']['version'] = '1.14.2'
default[id]['stable']['checksum'] = \
  '002d9f6154e331886a2dd4e6065863c9c1cf8291ae97a1255308572c02be9797'

default[id]['mainline']['version'] = '1.15.8'
default[id]['mainline']['checksum'] = \
  'a8bdafbca87eb99813ae4fcac1ad0875bf725ce19eb265d28268c309b2b40787'

default[id]['with_openssl'] = true
default[id]['with_http2'] = true
default[id]['with_ipv6'] = true
default[id]['with_headers_more'] = false
default[id]['with_status'] = false
default[id]['with_realip'] = false
default[id]['with_geoip2'] = false
default[id]['with_secure_link'] = false
default[id]['with_njs'] = false
default[id]['with_gzip_static'] = false
default[id]['with_brotli'] = false
default[id]['with_debug'] = false
default[id]['with_devel_kit'] = false
default[id]['with_lua'] = false
