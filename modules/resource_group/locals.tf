locals {
  name_suffix_safe  = lower(var.name_suffix == "" ? "" : "-${var.name_suffix}") //if empty then empty, not then lower case and add a -
  resource_group_name = "${var.names.resource_group_type}-${var.names.product_name}-${var.names.environment}-${var.names.location}${local.name_suffix_safe}"
}
