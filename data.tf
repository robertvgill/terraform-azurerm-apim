data "azurerm_client_config" "current" {
  count               = var.apim_resource_create ? 1 : 0
}
/**
## key vault
data "azurerm_key_vault" "akv" {
  count               = var.apim_resource_create ? 1 : 0

  name                = format("%s", var.apim_key_vault_name)
  resource_group_name = "cix-csvc-rg-alz-sea"
}
**/
## private dns
data "azurerm_private_dns_zone" "apimdz" {
  count               = var.apim_resource_create && var.apim_does_private_dns_zone_exist ? 1 : 0

  name                = format("%s", lower("privatelink.azure-api.net"))
  resource_group_name = var.rg_resource_group_name
}

## virtual network
data "azurerm_virtual_network" "vnet" {
  count               = var.apim_resource_create ? 1 : 0

  name                = format("%s", var.nw_virtual_network_name)
  resource_group_name = var.rg_resource_group_name
}

data "azurerm_subnet" "snet" {
  count                = var.apim_resource_create ? 1 : 0

  name                 = format("%s", var.nw_vnet_subnet_apim)
  virtual_network_name = var.nw_virtual_network_name
  resource_group_name  = var.rg_resource_group_name
}
