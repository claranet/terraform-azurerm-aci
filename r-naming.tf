data "azurecaf_name" "aci" {
  name          = var.stack
  resource_type = "azurerm_resource_group" # unsupported for now
  prefixes      = compact([local.name_prefix, var.use_caf_naming ? "aci" : ""])
  suffixes      = compact([var.client_name, var.location_short, var.environment, local.name_suffix, var.use_caf_naming ? "" : "aci"])
  use_slug      = false # var.use_caf_naming
  clean_input   = true
  separator     = "-"
}
