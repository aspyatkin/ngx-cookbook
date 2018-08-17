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
  '5f9565ab2ce331a1903789e0619946f23482b02fcafd8257c2f808626394b00f'

default[id]['geoip2']['databases']['city']['name'] = 'GeoLite2-City.mmdb'
default[id]['geoip2']['databases']['city']['url'] = \
  'http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.tar.gz'
default[id]['geoip2']['databases']['city']['checksum'] = \
  'e367bf5084b5598e48c2eb655220945889daa8e7eff6c531e2b661bc32456701'
