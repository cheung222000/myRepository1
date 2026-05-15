locals {
  #subnets = zipmap(keys(var.subnets), [for subnet in values(var.subnets) : merge(var.subnet_defaults, subnet)])
}
