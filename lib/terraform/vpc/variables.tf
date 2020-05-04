variable name              {}
variable zone_name         {}
variable resource_group_id {}

variable classic_access {
  default = false
}

variable transit_gateway {
  default = false
}

variable dns_service {
  default = false
}

variable dns_domain_name {
  default = null
}

variable bastion {
  default = false
}

variable bastion_key {
  default = null
}
