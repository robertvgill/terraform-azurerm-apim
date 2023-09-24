resource "azurerm_api_management" "apim" {
  count               = var.apim_resource_create ? 1 : 0

  depends_on = [
    azurerm_private_dns_zone.apimdz,
  ]

  location            = var.rg_location
  resource_group_name = var.rg_resource_group_name

  name                = format("%s", var.apim_resource_name)
  publisher_name      = var.apim_resource_config.publisher_name
  publisher_email     = var.apim_resource_config.publisher_email
  sku_name            = var.apim_resource_config.sku_name
  zones               = var.apim_resource_config.zones
  tags                = merge({ "ResourceName" = var.apim_resource_name }, var.tags, )

  identity {
    type         = "SystemAssigned"
  }

  notification_sender_email = var.apim_notification_sender_email

  protocols {
    enable_http2 = var.apim_enable_http2
  }

  sign_in {
    enabled = var.apim_enable_sign_in
  }

  sign_up {
    enabled = var.apim_enable_sign_up
    dynamic "terms_of_service" {
      for_each = var.apim_terms_of_service_configuration
      content {
        consent_required = lookup(terms_of_service.value, "consent_required")
        enabled          = lookup(terms_of_service.value, "enabled")
        text             = lookup(terms_of_service.value, "text")
      }
    }
  }

  virtual_network_type = var.apim_virtual_network_type

  dynamic "virtual_network_configuration" {
    for_each = var.apim_enable_vnet ? [1] : []
    content {
      subnet_id = data.azurerm_subnet.snet[0].id
    }
  }

  lifecycle {
    ignore_changes = [
      virtual_network_configuration,
    ] 
  }
}
