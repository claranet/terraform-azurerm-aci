resource "azurerm_network_profile" "network_profile" {
  for_each = toset(var.vnet_integration_enabled ? ["enabled"] : [])

  name                = local.network_profile_name
  location            = var.location
  resource_group_name = var.resource_group_name

  container_network_interface {
    name = local.nic_name

    ip_configuration {
      name      = local.ipcfg_name
      subnet_id = var.subnet_id
    }
  }
}
