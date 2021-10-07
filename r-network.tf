resource "azurerm_network_profile" "network_profile" {
  count = var.vnet_integration_enabled ? 1 : 0

  name                = coalesce(var.network_profile_custom_name, local.default_network_profile_name)
  location            = var.location
  resource_group_name = var.resource_group_name

  container_network_interface {
    name = coalesce(var.nic_custom_name, local.default_nic_name)

    ip_configuration {
      name      = coalesce(var.ipcfg_custom_name, local.default_ipcfg_name)
      subnet_id = var.subnet_id
    }
  }
}
