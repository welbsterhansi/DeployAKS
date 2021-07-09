## Azure config variables ##
variable location {
  default = "Central US"
}

## Resource group variables ##
variable resource_group_name {
  default = "aksclusteratlantic-rg"
}


## AKS kubernetes cluster variables ##
variable cluster_name {
  default = "clusteratlantic"
}

variable "agent_count" {
  default = 2
}

variable "dns_prefix" {
  default = "aksatlantic"
}

variable "admin_username" {
    default = "atlantic"
}