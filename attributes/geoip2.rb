id = 'ngx'

default[id]['geoip2']['version'] = '3.2'
default[id]['geoip2']['url'] = 'https://github.com/leev/ngx_http_geoip2_module/archive'
default[id]['geoip2']['checksum'] = \
  '15bd1005228cf2c869a6f09e8c41a6aaa6846e4936c473106786ae8ac860fab7'

default[id]['geoip2']['databases']['dir'] = '/etc/chef-nginx/geolite2'

default[id]['geoip2']['databases']['country']['name'] = 'GeoLite2-Country.mmdb'
default[id]['geoip2']['databases']['country']['url'] = \
  'http://geolite.maxmind.com/download/geoip/database/GeoLite2-Country.tar.gz'
default[id]['geoip2']['databases']['country']['checksum_url'] = \
  'https://geolite.maxmind.com/download/geoip/database/GeoLite2-Country.tar.gz.md5'

default[id]['geoip2']['databases']['city']['name'] = 'GeoLite2-City.mmdb'
default[id]['geoip2']['databases']['city']['url'] = \
  'http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.tar.gz'
default[id]['geoip2']['databases']['city']['checksum_url'] = \
  'https://geolite.maxmind.com/download/geoip/database/GeoLite2-City.tar.gz.md5'
