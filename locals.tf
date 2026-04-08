                                          /*
                                          uksouth:                                #Input from yaml to tf file
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
                                            "uksouth" = ***                        #add "region" = "uksouth" below
                                              "dataservices-nonprod" = ***         #add "name" = "dataservices-nonprod" below
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

                                            /*
                                                "client_ranges" = [
                                                  "10.73.64.0/18",
                                                ]
                                                "firewall_sku" = "Premium"
                                                "hub_range" = "10.241.38.0/24"
                                                "name" = "dataservices-nonprod"      #combine and add to be this hub name
                                                "region" = "uksouth"                 #combine and add to be this hub name
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
                                            */

hubs      = { for hub in local.formatted_hubs : "${hub.name}-${hub.region}" => hub }

                                            /*
                                            "dataservices-nonprod-uksouth" = ***
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
                                            */

hub_names = tolist([for key, value in local.hubs : key])

                                            /*
                                            hub_data_debug = tolist([
                                              "dataservices-nonprod-uksouth",
                                            ])
                                            */

vpn_connections = { for key, value in local.hubs : key => value if lookup(value, "vpn", null) != null }

                                            #if "vpn" found, keep it.
                                            /*
                                              "dataservices-nonprod-uksouth" = ***    #become value ("name" = "dataservices-nonprod")
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
                                                    "145.43.244.136",                  #become value ("primary_ip" = "145.43.244.136")
                                                    "145.43.244.168",                  #become value ("primary_ip" = "145.43.244.168")
                                                  ]
                                                  "ranges" = [
                                                    "10.55.208.0/21",
                                                  ]
                                                  "sku" = "VpnGw2AZ"
                                            */

  vpn_gateway_ranges = toset(flatten([
    for key, value in local.vpn_connections : [
      for ip in try(value.vpn.gateway_traffic, {}) : merge({ "primary_ip" : ip, "hub" : key }, value)
    ]
  ]))

                                            /*
                                            hub_data_debug = toset([
                                              ***
                                                "client_ranges" = [
                                                  "10.73.64.0/18",
                                                ]
                                                "firewall_sku" = "Premium"
                                                "hub" = "dataservices-nonprod-uksouth"     #combine to be the new hub key
                                                "hub_range" = "10.241.38.0/24"
                                                "name" = "dataservices-nonprod"
                                                "primary_ip" = "145.43.244.136"            #combine to be the new hub key
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
                                              ***,
                                              ***
                                                "client_ranges" = [
                                                  "10.73.64.0/18",
                                                ]
                                                "firewall_sku" = "Premium"
                                                "hub" = "dataservices-nonprod-uksouth"      #combine to be the new hub key
                                                "hub_range" = "10.241.38.0/24"
                                                "name" = "dataservices-nonprod"
                                                "primary_ip" = "145.43.244.168"             #combine to be the new hub key
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
                                              ***,
                                            ])
                                            */

vpn_gateway_ranges_map = tomap({ for r in local.vpn_gateway_ranges : "${r.primary_ip}-${r.hub}" => r })

                                            /*
                                            hub_data_debug = tomap(***
                                              "145.43.244.136-dataservices-nonprod-uksouth" = ***
                                                "client_ranges" = [
                                                  "10.73.64.0/18",
                                                ]
                                                "firewall_sku" = "Premium"
                                                "hub" = "dataservices-nonprod-uksouth"
                                                "hub_range" = "10.241.38.0/24"
                                                "name" = "dataservices-nonprod"
                                                "primary_ip" = "145.43.244.136"
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
                                              ***
                                              "145.43.244.168-dataservices-nonprod-uksouth" = ***
                                                "client_ranges" = [
                                                  "10.73.64.0/18",
                                                ]
                                                "firewall_sku" = "Premium"
                                                "hub" = "dataservices-nonprod-uksouth"
                                                "hub_range" = "10.241.38.0/24"
                                                "name" = "dataservices-nonprod"
                                                "primary_ip" = "145.43.244.168"
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
                                              ***
                                            ***)
                                            */

}

output "hub_data_debug" {
  value = local.vpn_gateway_ranges_map.value.hub.name
}
/*
output "hub_data_debug2" {
  value = jsonencode(local.vpn_gateway_ranges_map)
}
output "hub_data_debug3" {
  value = local.hub_data["uksouth"]
}
*/
