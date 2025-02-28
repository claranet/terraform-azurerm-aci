data "azurecaf_name" "aci" {
  name          = var.stack
  resource_type = "azurerm_resource_group" # unsupported for now
  prefixes      = compact([local.name_prefix, "aci"])
  suffixes = compact([
    var.client_name, var.location_short, var.environment, local.name_suffix
  ])
  use_slug    = false
  clean_input = true
  separator   = "-"
}
