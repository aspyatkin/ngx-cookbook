id = 'ngx'

default[id]['install'] = 'stable'

default[id]['stable']['version'] = '1.14.0'
default[id]['stable']['checksum'] = \
  '5d15becbf69aba1fe33f8d416d97edd95ea8919ea9ac519eff9bafebb6022cb5'

default[id]['mainline']['version'] = '1.15.0'
default[id]['mainline']['checksum'] = \
  'b0b58c9a3fd73aa8b89edf5cfadc6641a352e0e6d3071db1eb3215d72b7fb516'

default[id]['with_openssl'] = true
default[id]['with_http2'] = true
default[id]['with_ipv6'] = true
default[id]['with_ct'] = true
default[id]['with_headers_more'] = true
default[id]['with_status'] = false
default[id]['with_realip'] = false
default[id]['with_geoip2'] = false
default[id]['with_secure_link'] = false
default[id]['with_njs'] = false
default[id]['with_debug'] = false
default[id]['with_devel_kit'] = false
default[id]['with_lua'] = false
