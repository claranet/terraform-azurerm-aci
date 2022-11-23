locals {
  # Naming locals/constants
  name_prefix = lower(var.name_prefix)
  name_suffix = lower(var.name_suffix)

  aci_name             = coalesce(var.custom_name, data.azurecaf_name.aci.result)
  network_profile_name = coalesce(var.network_profile_custom_name, data.azurecaf_name.network_profile.result)
  nic_name             = coalesce(var.nic_custom_name, data.azurecaf_name.nic.result)
  ipcfg_name           = coalesce(var.ipcfg_custom_name, data.azurecaf_name.ipcfg.result)
}
