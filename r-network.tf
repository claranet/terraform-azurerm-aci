resource "azurerm_network_profile" "aci_network_profile" {
  count = var.aci_enable_vnet_integration ? 1 : 0

  name                = coalesce(var.aci_network_profile_custom_name, local.default_aci_network_profile_name)
  location            = var.location
  resource_group_name = var.resource_group_name

  container_network_interface {
    name = coalesce(var.aci_nic_custom_name, local.default_aci_nic_name)

    ip_configuration {
      name      = coalesce(var.aci_ipcfg_custom_name, local.default_aci_ipcfg_name)
      subnet_id = var.aci_subnet_id
    }
  }
}
