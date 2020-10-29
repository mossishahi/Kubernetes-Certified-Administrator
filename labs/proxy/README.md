# Squid Proxy
## Design Diagram

       ________                     ________
      |==|=====|                   |==|=====|
      |  |     |                   |  |     |
      |  |     |                   |  |     |                 .-,(  ),-.
      |  |     |                   |  |     |              .-(          )-.
      |  |     |   ------------->  |  |     |   --------->(    internet    )
      |  |====°|                   |  |====°|              '-(          ).-'
      |__|_____|                   |__|_____|                  '-.( ).-'

    Internal Squid               External Squid


## Install Internal Squid
    > Replaced all <text> in command and config

Install squid version 4.x
```
echo "deb http://squid413.diladele.com/ubuntu/ <code_name> main" > /etc/apt/sources.list.d/squid4.list
apt-get update
apt-get install -y squid apache2-utils
```

Create new squid config, /etc/squid/squid.conf and restart squid 
```
http_port 0.0.0.0:3128
max_filedesc 4096
dns_v4_first on

cache_peer <external_squid_ipaddress> parent 443 0 proxy-only no-digest tls sslflags=DONT_VERIFY_PEER round-robin default
coredump_dir /var/spool/squid
netdb_filename none

acl local src 127.0.0.1
auth_param basic program /usr/lib/squid/basic_ncsa_auth /etc/squid/htpasswd
auth_param basic children 5
auth_param basic realm Enter proxy password
auth_param basic credentialsttl 1 hour
acl KnownUsers proxy_auth REQUIRED

http_access allow KnownUsers
http_access deny all

forwarded_for off
#request_header_access Allow allow all
request_header_access Authorization allow all
request_header_access WWW-Authenticate allow all
request_header_access Proxy-Authorization allow all
request_header_access Proxy-Authenticate allow all
request_header_access Cache-Control allow all
request_header_access Content-Encoding allow all
request_header_access Content-Length allow all
request_header_access Content-Type allow all
request_header_access Date allow all
request_header_access Expires allow all
request_header_access Host allow all
request_header_access If-Modified-Since allow all
request_header_access Last-Modified allow all
request_header_access Location allow all
request_header_access Pragma allow all
request_header_access Accept allow all
request_header_access Accept-Charset allow all
request_header_access Accept-Encoding allow all
request_header_access Accept-Language allow all
request_header_access Content-Language allow all
request_header_access Mime-Version allow all
request_header_access Retry-After allow all
request_header_access Title allow all
request_header_access Connection allow all
request_header_access Proxy-Connection allow all
request_header_access User-Agent allow all
request_header_access Cookie allow all
request_header_access All deny all
cache deny all
never_direct allow all
```

Create basic_auth password file for connecting proxy
```
htpasswd -c /etc/squid/htpasswd <username>
```

## Install External Squid
Install squid version 4.x
```
echo "deb http://squid413.diladele.com/ubuntu/ <code_name> main" > /etc/apt/sources.list.d/squid4.list
apt-get update
apt-get install -y squid
```

Create selfsign certificate
```
openssl req -x509 -new -nodes -days 3650 -keyout /etc/squid/squid.key  -out /etc/squid/squid.crt
```

Create new squid config, /etc/squid/squid.conf and restart squid service
```
http_port 0.0.0.0:3128
https_port 0.0.0.0:443 tls-cert=/etc/squid/squid.crt tls-key=/etc/squid/squid.key
coredump_dir /var/spool/squid

max_filedesc 4096
dns_v4_first on

acl local src 127.0.0.1
acl internal src <internal_squid_ip>
auth_param basic program /usr/lib/squid/basic_ncsa_auth /etc/squid/htpasswd
auth_param basic children 5
auth_param basic realm Enter proxy password
auth_param basic credentialsttl 1 hour
acl KnownUsers proxy_auth REQUIRED

http_access allow internal
http_access allow KnownUsers
http_access deny all

forwarded_for off
#request_header_access Allow allow all
request_header_access Authorization allow all
request_header_access WWW-Authenticate allow all
request_header_access Proxy-Authorization allow all
request_header_access Proxy-Authenticate allow all
request_header_access Cache-Control allow all
request_header_access Content-Encoding allow all
request_header_access Content-Length allow all
request_header_access Content-Type allow all
request_header_access Date allow all
request_header_access Expires allow all
request_header_access Host allow all
request_header_access If-Modified-Since allow all
request_header_access Last-Modified allow all
request_header_access Location allow all
request_header_access Pragma allow all
request_header_access Accept allow all
request_header_access Accept-Charset allow all
request_header_access Accept-Encoding allow all
request_header_access Accept-Language allow all
request_header_access Content-Language allow all
request_header_access Mime-Version allow all
request_header_access Retry-After allow all
request_header_access Title allow all
request_header_access Connection allow all
request_header_access Proxy-Connection allow all
request_header_access User-Agent allow all
request_header_access Cookie allow all
request_header_access All deny all

cache deny all
```
