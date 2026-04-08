locals {
  naming_rules = yamldecode(var.naming_rules) #把外部傳進來的 YAML（字串）轉成 Terraform 可操作的 object，存在 local.naming_rules。
}
