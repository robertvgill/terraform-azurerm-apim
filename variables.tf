## resource group
variable "rg_resource_group_name" {
  description = "The name of the resource group in which to create the storage account."
  type        = string
  default     = null
}

variable "rg_location" {
  description = "Specifies the supported Azure location where the resource should be created."
  type        = string
  default     = null
}

## virtual network
variable "apim_enable_vnet" {
  description = "Is Azure Key Vault enabled for certificate use?."
  type        = bool
}

variable "nw_vnet_subnet_apim" {
  description = "The name of the Virtual Network for APIM."
  type        = string
}

variable "nw_virtual_network_name" {
  description = "The name of the Virtual Network."
  type        = string
  default     = null
}

## api management
variable "apim_resource_create" {
  description = "Controls if API Management should be created."
  type        = bool
}

variable "apim_resource_name" {
  description = "The resource name of the API Management."
  type        = string
}

variable "apim_resource_config" {
  description = "API Management configuration."
  type = object({
    publisher_name  = string
    publisher_email = string
    sku_name        = string
    zones           = list(string)
  })
  default = null
}

variable "apim_enable_http2" {
  type        = bool
  description = "Should HTTP/2 be supported by the API Management Service?."
  default     = false
}

variable "apim_notification_sender_email" {
  type        = string
  description = "Email address from which the notification will be sent."
  default     = null
}

variable "apim_enable_sign_in" {
  type        = bool
  description = "Should anonymous users be redirected to the sign in page?"
  default     = false
}

variable "apim_enable_sign_up" {
  type        = bool
  description = "Can users sign up on the development portal?"
  default     = false
}

variable "apim_terms_of_service_configuration" {
  type        = list(map(string))
  description = "Map of terms of service configuration"

  default = [{
    consent_required = false
    enabled          = false
    text             = ""
  }]
}

variable "apim_virtual_network_type" {
  type        = string
  description = "The type of virtual network you want to use, valid values include: None, External, Internal."
}

variable "apim_private_endpoint_enabled" {
  type        = bool
  default     = false
}

variable "apim_does_private_dns_zone_exist" {
  type        = bool
  default     = false
}

variable "apim_private_dns_zone_name" {
  description = "The name of the the Private DNS Zone which should be delegated to AKS Cluster"
  default     = null
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
}