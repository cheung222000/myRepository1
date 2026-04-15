locals {
  name_suffix_safe  = lower(var.name_suffix == "" ? "" : "-${var.name_suffix}") //if empty then empty, not then lower case and add a -

}
