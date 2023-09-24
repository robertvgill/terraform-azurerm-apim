resource "azurerm_private_dns_zone" "apimdz" {
  count               = var.apim_resource_create && var.apim_private_endpoint_enabled && var.apim_does_private_dns_zone_exist == false ? 1 : 0

  name                = var.apim_private_dns_zone_name
  resource_group_name = var.rg_resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "dzvlink" {
  count                 = var.apim_resource_create && var.apim_private_endpoint_enabled && var.apim_does_private_dns_zone_exist == false ? 1 : 0

  name                  = lower("${var.nw_virtual_network_name}-link")
  resource_group_name   = var.rg_resource_group_name
  virtual_network_id    = data.azurerm_virtual_network.vnet[0].id
  private_dns_zone_name = var.apim_does_private_dns_zone_exist ? data.azurerm_private_dns_zone.apimdz[0].name : azurerm_private_dns_zone.apimdz[0].name
}