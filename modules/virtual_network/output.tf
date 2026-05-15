##
/*
output "subnet" {
  description = "Map of subnet data objects."
  value = zipmap(                                   #zipmap(keys, values)
    [for subnet in module.subnet : subnet.name],
    [for subnet in module.subnet : subnet.subnet]
  )
}
*/
