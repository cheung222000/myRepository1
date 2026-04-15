locals {
  name_suffix_safe  = lower(var.name_suffix == "" ? "" : "-${var.name_suffix}")

}
