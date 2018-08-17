id = 'ngx'

default[id]['install'] = 'stable'

default[id]['stable']['version'] = '1.14.0'
default[id]['stable']['checksum'] = \
  '5d15becbf69aba1fe33f8d416d97edd95ea8919ea9ac519eff9bafebb6022cb5'

default[id]['mainline']['version'] = '1.15.2'
default[id]['mainline']['checksum'] = \
  'eeba09aecfbe8277ac33a5a2486ec2d6731739f3c1c701b42a0c3784af67ad90'

default[id]['with_openssl'] = true
default[id]['with_http2'] = true
default[id]['with_ipv6'] = true
default[id]['with_ct'] = false
default[id]['with_headers_more'] = false
default[id]['with_status'] = false
default[id]['with_realip'] = false
default[id]['with_geoip2'] = false
default[id]['with_secure_link'] = false
default[id]['with_njs'] = false
default[id]['with_debug'] = false
default[id]['with_devel_kit'] = false
default[id]['with_lua'] = false
