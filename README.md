variable "grid_timeout_connect" {
  type        = string
  description = "HAProxy backend connect timeout (grid_timeout_connect tag)"
  default     = "5s"
}

variable "grid_timeout_server" {
  type        = string
  description = "HAProxy backend server timeout (grid_timeout_server tag)"
  default     = "30s"
}


 tags = compact([
    "tcp",
    "grid_port:${var.service_settings.haproxy_ports}",
    var.service_settings.tcp ? "grid_mode:tcp" : "",
    coalesce(var.service_settings.haproxy_fqdns, "nofqdns"),
    var.service_settings.haproxy_host_header_override,

    # 👇 Add these new timeout tags
    "grid_timeout_connect:${var.grid_timeout_connect}",
    "grid_timeout_server:${var.grid_timeout_server}"
  ])


    service_checks = [{
    interval        = "30s"
    timeout         = "15s"
    tcp             = var.sqlmi_db1_tcp
    status          = "passing"
    tls_skip_verify = true
  }]

  # 👇 Optional overrides (defaults are 5s / 30s)
  grid_timeout_connect = "5s"
  grid_timeout_server  = "30s"
}


