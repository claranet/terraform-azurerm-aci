resource "azurecaf_name" "aci" {
  name          = var.stack
  resource_type = "azurerm_resource_group" # unsupported for now
  prefixes      = compact([local.name_prefix, var.use_caf_naming ? "aci" : ""])
  suffixes      = compact([var.client_name, var.location_short, var.environment, local.name_suffix, var.use_caf_naming ? "" : "aci"])
  use_slug      = false # var.use_caf_naming
  clean_input   = true
  separator     = "-"
}

resource "azurecaf_name" "network_profile" {
  name          = var.stack
  resource_type = "azurerm_resource_group" # unsupported for now
  prefixes      = compact([local.name_prefix, var.use_caf_naming ? "acinpn" : ""])
  suffixes      = compact([var.client_name, var.location_short, var.environment, local.name_suffix, var.use_caf_naming ? "" : "acinpn"])
  use_slug      = false # var.use_caf_naming
  clean_input   = true
  separator     = "-"
}

resource "azurecaf_name" "nic" {
  name          = var.stack
  resource_type = "azurerm_network_interface"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, local.name_suffix, var.use_caf_naming ? "" : "acinn"])
  use_slug      = var.use_caf_naming
  clean_input   = true
  separator     = "-"
}

resource "azurecaf_name" "ipcfg" {
  name          = var.stack
  resource_type = "azurerm_resource_group" # unsupported for now
  prefixes      = compact([local.name_prefix, var.use_caf_naming ? "aciipcfg" : ""])
  suffixes      = compact([var.client_name, var.location_short, var.environment, local.name_suffix, var.use_caf_naming ? "" : "aciipcfg"])
  use_slug      = false # var.use_caf_naming
  clean_input   = true
  separator     = "-"
}
