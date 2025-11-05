Supported Grid Service Tags
grid_ and haproxy_ Tags
Service tags prefixed with grid_ or haproxy_ are used throughout the templates to control how services are exposed and routed in HAProxy.
The templates support both new grid_ tags and legacy haproxy_ tags, with a preference for grid_ going forward.

Legacy haproxy_ tags

Teams should migrate all haproxy_ tags to grid_ tags going forward.
The grid_ tags are preferred for new features, consistency, and future compatibility.

Tag Formatting

Tags must be enclosed in double quotations or they WILL cause instability.
Ex: "grid_fqdns: claims-api.optum.com"

Supported Consul-registered Service Tags
Mode and Protocol
http, https, tcp, OR grid_mode: / haproxy_mode:
Example: "http" Sets the backend mode to http
Example: "grid_mode: http" Sets the service backend mode to http
Example: "https" Sets the backend mode to https
Example: "grid_mode: https" Sets the service backend mode to https
Supported values: http, https, tcp
http|https enables HTTP features (ACLs, health checks, etc.), tcp for raw TCP forwarding.
http will set the backend for the Consul-registered service to use plain HTTP when connecting to service instances.
https will set the backend for the Consul-registered service to use SSL/TLS when connecting to service instances.
Default: http
Frontend Listener Ports
grid_port: / haproxy_port:
Example: "grid_port: 1234"
Example: "grid_port: 1234, 5678"
Supported values: Integer port number(s), comma-separated if more than one.
Unsupported values: Any port that is part of the filter_ports
Exposes a frontend listener on the specified port, load-balancing traffic to all instances of the Consul-registered service in your local partition.
Applies to: frontend for the Consul-registered service.
Unique grid_port Values

Using the same grid_port value for different Consul-registered services in your local Consul Partition WILL cause instability.

grid_port_ssl: / haproxy_port_ssl:
Example: "grid_port_ssl: true"
Supported values: true
Deprecated values: false -- Service Grid requires SSL so this cannot be set to false
Enables SSL/TLS for the frontend listener if true.
Applies to: frontend
Default: true
grid_maxconn: / haproxy_maxconn:
Example: "grid_maxconn: 1000"
Supported values: Integer (e.g., 2500)
Sets the maximum number of concurrent connections for the frontend.
Applies to: frontend listener from grid_port
Default: 5000
grid_timeout_client: / haproxy_timeout_client:
Example: "grid_timeout_client: 30s"
Supported values: Interval duration ending in us|ms|s|m|h|d
Set the maximum inactivity time on the client side.
Applies to: frontend listener from grid_port
Default: 30s
Consul-registered Service Backends
grid_maxconn: / haproxy_maxconn:
Example: "grid_maxconn: 1000"
Supported values: Integer (e.g., 2500)
Sets the maximum number of concurrent connections for the frontend.
Applies to: frontend listener from grid_port
Default: 5000
grid_balance_mode: / haproxy_balance_mode:
Example: "grid_balance_mode: roundrobin"
Supported values: roundrobin, leastconn
Sets the load balancing algorithm.
Applies to: backend for the Consul-registered service.
Default: leastconn
grid_resolver: / haproxy_resolver:
Example: "grid_resolver: infoblox"
Supported values: String resolver name defined in 03_hpgw_resolvers.cfg
Specifies the DNS resolver to use for backend server resolution.
Applies to: backend for the Consul-registered service.
Default: consul
grid_http2: / haproxy_http2:
Example: "grid_http2: true"
Supported values: true, false
Enables or disables HTTP/2 support.
Applies to: backend for the Consul-registered service.
Default: false
grid_host_header_override: / haproxy_host_header_override:
Example: "grid_host_header_override: claims-api.optum.com"
Supported values: String host header (e.g., claims-api.optum.com)
Overrides the Host header sent to backend servers.
Also sets the X-Forwarded-Host header to the original Host header from the client request.
Applies to: backend for the Consul-registered service.
grid_sni_header_override:
Example: "grid_sni_header_override: claims-api.optum.com"
Supported values:
String sni header (e.g., claims-api.optum.com)
override to use the value of grid_host_header_override
Overrides the sni header sent to backend servers.
Applies to: backend for the Consul-registered service.
grid_timeout_connect: / haproxy_timeout_connect:
Example: "grid_timeout_connect: 5s"
Supported values: Interval duration ending in us|ms|s|m|h|d
Set the maximum time to wait for a connection attempt to a server to succeed.
Applies to: backend for the Consul-registered service.
Default: 5s
grid_timeout_server: / haproxy_timeout_server:
Example: "grid_timeout_server: 30s"
Supported values: Interval duration ending in us|ms|s|m|h|d
Set the maximum inactivity time on the server side.
Applies to: backend for the Consul-registered service.
Default: 30s
grid_https_hsts: / haproxy_https_hsts:
Example: "grid_https_hsts: 2592000"
Supported values: Integer (e.g., 2592000)
Sets the Strict-Transport-Security header with the specified max-age in seconds
Applies to: backend for the Consul-registered service.
Default: 2592000 (30 days)
grid_sticky: / haproxy_sticky:
Example: "grid_sticky: JSESSIONID"
Supported values: Cookie name (e.g., JSESSIONID) or src
Enables sticky sessions using the specified cookie OR by source IP.
Applies to: backend for the Consul-registered service.
Default: none (sticky sessions disabled)
Sticky Sessions Require Existing Cookie

The cookie MUST ALREADY EXIST in the HTTP Request for this functionality to work.

grid_sticky_size: / haproxy_sticky_size:
Example: "grid_sticky: 100m"
Supported values: Cookie size ending in k|m|g
Sets the size of the stick-table for sticky sessions.
Applies to: backend for the Consul-registered service.
Default: 100m
grid_sticky_expire: / haproxy_sticky_expire:
Example: "grid_sticky_expire: 1h"
Supported values: Interval duration ending in us|ms|s|m|h|d
Sets the expiration time for sticky sessions.
Applies to: backend for the Consul-registered service.
Default: 100m
Consul-registered Service Backends Health Checks
grid_check: / haproxy_check:
Example: "grid_check: true"
Supported values: true, false
Enables or disables health checks for the backend.
Applies to: backend for the Consul-registered service.
Default: true
grid_check_inter:
Example: "grid_check_inter: 10s"
Supported values: Interval duration ending in us|ms|s|m|h|d
Sets the interval between health checks.
Applies to: backend for the Consul-registered service.
grid_check_sni_header:
Example: "grid_check_sni_header: claims-api.optum.com"
Example: "grid_check_sni_header: override"
Supported values:
String sni header. (e.g., claims-api.optum.com)
override to use the value of grid_sni_header_override
Sets the sni header for health checks.
Applies to: backend for the Consul-registered service.
grid_check_mode:
Example: "grid_check_mode: http"
Supported values: http, tcp, ldap, mysql, pgsql, redis, smtp
Sets the health check type (HTTP, TCP, etc.).
Applies to: backend for the Consul-registered service.
grid_check_meth:
Example: "grid_check_meth: GET"
Supported values: HTTP methods GET, HEAD, OPTIONS, POST, PUT, DELETE, TRACE, CONNECT, PATCH
Sets the HTTP method used for health checks.
Applies to: backend for the Consul-registered service.
Default: GET
Dependent On: grid_check_mode: http
grid_check_ver:
Example: "grid_check_ver: HTTP/1.1"
Supported values: HTTP version HTTP/1.0, HTTP/1.1, HTTP/2
Sets the HTTP version for health checks.
Applies to: backend for the Consul-registered service.
Dependent On: grid_check_mode: http
grid_check_uri:
Example: "grid_check_uri: /health"
Supported values: URI path (e.g., /health)
Sets the URI endpoint for HTTP health checks.
Sets the tcp-check send value for TCP health checks.
Applies to: backend for the Consul-registered service.
Dependent On: grid_check_mode: http OR grid_check_mode: tcp
grid_check_host_header:
Example: "grid_check_host_header: claims-api.optum.com"
Example: "grid_check_host_header: override"
Supported values:
String host header. (e.g., claims-api.optum.com)
override to use the value of grid_host_header_override
Sets the Host header for HTTP health checks.
Dependent On: grid_check_mode: http
Applies to: backend for the Consul-registered service.
grid_check_expect:
Example: "grid_check_expect: string HEALTHY"
Supported values: Expected response string (e.g., HEALTHY)
Sets the expected response for health check validation.
Applies to: backend for the Consul-registered service.
Dependent On: grid_check_mode: http OR grid_check_mode: tcp
See also: HAProxy Health Check Options
grid_check_usr:
Example: "grid_check_usr: sqlhealth"
Supported values: String to use as username.
Sets the username to use for mysql or pgsql health check.
Applies to: backend for the Consul-registered service.
Dependent On: grid_check_mode: mysql OR grid_check_mode: pgsql
Default Routing and Filtering
grid_exclude: / haproxy_exclude:
Example: "grid_exclude: true"
Supported values: true, false
If true, excludes the Consul-registered service from all grid routing rules.
Applies to: All frontends, backends, and routing rules.
Default: false
grid_skip_default_https: / haproxy_skip_default_https:
Example: "grid_skip_default_https: true"
Supported values: true, false
If true, excludes the Consul-registered service from the default HTTPS/443 and MTLS/9443 frontends.
Applies to: Default HTTPS/443 and MTLS/9443 frontends only.
Default: false
grid_pmatch / haproxy_pmatch:
Example: "grid_pmatch: path_beg"
Supported values: path, path_beg
Configures matching mode for path-based routing rules for the Consul-registered service.
path matches if the path is exactly the specified value.
path_beg matches if the path begins with the specified value.
Applies to: The default frontend HTTPs/MTLS listeners.
Path Matching Default Behavior

If not explicitly set, grid_uris will use path_beg matching and grid_paths will attempt to use path FIRST, and THEN path_beg

grid_uris: / haproxy_uris:
Example: "grid_uris: billing-api.uhc.com/api/v1, billing-api.optum.com/api/v2"
Supported values: Comma-separated FQDNs with paths
Adds FQDN and path-based routing rules for the Consul-registered service.
Applies to: The default frontend HTTPs/MTLS listeners.
grid_fqdns: / haproxy_fqdns:
Example: "grid_fqdns: foo.example.com, bar.example.com"
Supported values: Comma-separated FQDNs
Adds FQDN-based routing rules for the Consul-registered service.
Applies to: The default frontend HTTPs/MTLS listeners.
grid_hostnames: / haproxy_hostnames:
Example: "grid_hostnames: billing-api, billing-app"
Supported values: Comma-separated hostnames
Adds hostname-based routing rules for the Consul-registered service.
Applies to: The default frontend HTTPs/MTLS listeners.
grid_paths: / haproxy_paths:
Example: "grid_paths: /api, /status"
Supported values: Comma-separated paths
Adds path-based routing rules for the Consul-registered service.
Applies to: The default frontend HTTPs/MTLS listeners.
grid_header_eqls: / haproxy_header_eqls:
Example: "grid_header_eqls: X-Env=production, X-Version=v1_api"
Supported values: Comma-separated Header: Value pairs
Adds exact match header-based routing rules for the Consul-registered service.
Applies to: The default frontend HTTPs/MTLS listeners.
grid_header_subs: / haproxy_header_subs:
Example: "grid_header_subs: X-Env=prod, X-Version=v1"
Supported values: Comma-separated Header: Substring pairs
Adds substring match header-based routing rules for the Consul-registered service.
Applies to: The default frontend HTTPs/MTLS listeners.
grid_header_exists: / haproxy_header_exists:
Example: "grid_header_exists: X-Env, X-Version"
Supported values: Comma-separated header names
Adds existence match header-based routing rules for the Consul-registered service.
Applies to: The default frontend HTTPs/MTLS listeners.
