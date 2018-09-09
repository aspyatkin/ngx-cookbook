id = 'ngx'

default[id]['geoip2']['version'] = '3.0'
default[id]['geoip2']['url'] = 'https://github.com/leev/ngx_http_geoip2_module/archive'
default[id]['geoip2']['checksum'] = \
  '65a191688348a05d8d92b2e7ce9c6eb8cb8322205c34637da582a1205864133d'

default[id]['geoip2']['databases']['dir'] = '/etc/chef-nginx/geolite2'

default[id]['geoip2']['databases']['country']['name'] = 'GeoLite2-Country.mmdb'
default[id]['geoip2']['databases']['country']['url'] = \
  'http://geolite.maxmind.com/download/geoip/database/GeoLite2-Country.tar.gz'
default[id]['geoip2']['databases']['country']['checksum'] = \
  'e5acb422d3a09c3ccbd55b98a0bf926e402dd9cd086d9b70f5d5f7524a8f3676'

default[id]['geoip2']['databases']['city']['name'] = 'GeoLite2-City.mmdb'
default[id]['geoip2']['databases']['city']['url'] = \
  'http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.tar.gz'
default[id]['geoip2']['databases']['city']['checksum'] = \
  'c68df20de81f738f047d2ff235c51bae09fc0e83e856aa4a4729b482dd420c5c'
