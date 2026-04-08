locals {
  naming_rules = yamldecode(var.naming_rules) #convert YAML to Terraform operable-object
}
