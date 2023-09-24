resource "azurerm_private_endpoint" "apimpep" {
  count               = var.apim_resource_create && var.apim_private_endpoint_enabled ? 1 : 0

  depends_on = [
    azurerm_private_dns_zone.apimdz,
  ]

  resource_group_name = var.rg_resource_group_name
  location            = var.rg_location

  name                = format("%s-private-endpoint", var.apim_resource_name)
  subnet_id           = data.azurerm_subnet.snet[0].id

  private_service_connection {
    name                           = format("%s-private-endpoint", var.apim_resource_name)
    is_manual_connection           = false
    private_connection_resource_id = azurerm_api_management.apim[0].id
    subresource_names              = ["Gateway"]
  }

  private_dns_zone_group {
    name                 = azurerm_api_management.apim[0].name
    private_dns_zone_ids = [var.apim_does_private_dns_zone_exist ? data.azurerm_private_dns_zone.apimdz[0].id : azurerm_private_dns_zone.apimdz[0].id]
  }

  tags     = merge({ "ResourceName" = format("%s-private-endpoint", var.apim_resource_name) }, var.tags, )
}