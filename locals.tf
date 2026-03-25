locals {
  hub_data = yamldecode(file("./data/hubs.yaml"))
}
output "hub_data_debug" {
  value = local.hub_data
}
