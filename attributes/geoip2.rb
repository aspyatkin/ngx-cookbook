id = 'ngx'

default[id]['geoip2']['version'] = '2.0'
default[id]['geoip2']['url'] = 'https://github.com/leev/ngx_http_geoip2_module/archive'
default[id]['geoip2']['checksum'] = \
  'ebb4652c4f9a2e1ee31fddefc4c93ff78e651a4b2727d3453d026bccbd708d99'

default[id]['geoip2']['databases']['dir'] = '/etc/chef-nginx/geolite2'

default[id]['geoip2']['databases']['country']['name'] = 'GeoLite2-Country.mmdb'
default[id]['geoip2']['databases']['country']['url'] = \
  'http://geolite.maxmind.com/download/geoip/database/GeoLite2-Country.tar.gz'
default[id]['geoip2']['databases']['country']['checksum'] = \
  '6977a408a4f3eca76523b5bf39780fd2c8529f263ce8cc94c1da208dc9be678b'

default[id]['geoip2']['databases']['city']['name'] = 'GeoLite2-City.mmdb'
default[id]['geoip2']['databases']['city']['url'] = \
  'http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.tar.gz'
default[id]['geoip2']['databases']['city']['checksum'] = \
  '0f3c1d1115e764481962766323e838a634c16eff08e6c9229b87973ac380bb48'
