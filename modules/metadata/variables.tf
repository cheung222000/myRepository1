variable "naming_rules" {
  description = "naming conventions yaml file" 
  type        = string
}

variable "business_unit" {
  description = "rba.businessUnit (https://github.com/Azure-Terraform/example-naming-template#custombusinessunit)"
  type        = string
}

variable "environment" {
  description = "rba.environment (https://github.com/Azure-Terraform/example-naming-template#customenvironment)"
  type        = string
}

variable "market" {
  description = "rba.market (https://github.com/Azure-Terraform/example-naming-template#custommarket)"
  type        = string
}
/*
variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}
*/
variable "subscription_type" {
  description = "rba.subscriptionType (https://github.com/Azure-Terraform/example-naming-template#customsubscriptiontype)"
  type        = string
}

variable "product_group" {
  description = "rba.productGroup (https://github.com/Azure-Terraform/example-naming-template#customproductgroup) or [a-z0-9]{2,12}"
  type        = string
  default     = ""

  validation {
    condition     = length(regexall("[a-z0-9]{2,12}", var.product_group)) == 1
    error_message = "ERROR: product_group must [a-z0-9]{2,12}."
  }
}

variable "product_name" {
  description = "rba.productName (https://github.com/Azure-Terraform/example-naming-template#customproductname)"
  type        = string
  default     = ""

  validation {
    condition     = length(regexall("[a-z0-9]{3,16}", var.product_name)) == 1                #Match lowercase letters and numbers only, with a length from 3 to 16 characters.
    error_message = "ERROR: product_name must be [a-z0-9]{3,16}."
  }
}

variable "project" {
  description = "Jira Project"
  type        = string
}

variable "resource_group_type" {
  description = "rba.resourceGroupType (https://github.com/Azure-Terraform/example-naming-template#customresourcegrouptype)"
  type        = string
}

