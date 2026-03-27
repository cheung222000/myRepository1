                                          /*
                                          uksouth:
                                            dataservices-nonprod:
                                              hub_range: 10.241.38.0/24
                                              client_ranges:
                                                - 10.73.64.0/18
                                              firewall_sku: Premium
                                              vpn:
                                                sku: VpnGw2AZ
                                                asn: 64562
                                                gateway_traffic:
                                                  - 145.43.244.136
                                                  - 145.43.244.168
                                                ranges:
                                                  - 10.55.208.0/21
                                                bgp_addresses:
                                                  - 169.254.21.15
                                                  - 169.254.22.15
                                                  - 169.254.21.14
                                                  - 169.254.22.14
                                          */
locals {
  hub_data = yamldecode(file("./data/hubs.yaml"))

                                          /*
                                          hub_data_debug = ***
                                            "uksouth" = ***
                                              "dataservices-nonprod" = ***
                                                "client_ranges" = [
                                                  "10.73.64.0/18",
                                                ]
                                                "firewall_sku" = "Premium"
                                                "hub_range" = "10.241.38.0/24"
                                                "vpn" = ***
                                                  "asn" = 64562
                                                  "bgp_addresses" = [
                                                    "169.254.21.15",
                                                    "169.254.22.15",
                                                    "169.254.21.14",
                                                    "169.254.22.14",
                                                  ]
                                                  "gateway_traffic" = [
                                                    "145.43.244.136",
                                                    "145.43.244.168",
                                                  ]
                                                  "ranges" = [
                                                    "10.55.208.0/21",
                                                  ]
                                                  "sku" = "VpnGw2AZ"
                                                ***
                                              ***
                                            ***
                                          ***
                                          */

  formatted_hubs = flatten([
      for region, hubs in local.hub_data : [
        for name, data in hubs : merge({
          name   = name,
          region = region
          },
          data
        )
      ]
    ])
}
                                            /*
                                                "client_ranges" = [
                                                  "10.73.64.0/18",
                                                ]
                                                "firewall_sku" = "Premium"
                                                "hub_range" = "10.241.38.0/24"
                                                "name" = "dataservices-nonprod"
                                                "region" = "uksouth"
                                                "vpn" = ***
                                                  "asn" = 64562
                                                  "bgp_addresses" = [
                                                    "169.254.21.15",
                                                    "169.254.22.15",
                                                    "169.254.21.14",
                                                    "169.254.22.14",
                                                  ]
                                                  "gateway_traffic" = [
                                                    "145.43.244.136",
                                                    "145.43.244.168",
                                                  ]
                                                  "ranges" = [
                                                    "10.55.208.0/21",
                                                  ]
                                                  "sku" = "VpnGw2AZ"
                                                ***
                                            */


output "hub_data_debug" {
  value = local.formatted_hubs
}
output "hub_data_debug2" {
  value = jsonencode(local.formatted_hubs)
}
output "hub_data_debug3" {
  value = local.hub_data["uksouth"]
}
