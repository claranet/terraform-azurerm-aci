locals {
  name_prefix                  = var.name_prefix != "" ? replace(var.name_prefix, "/[a-z0-9]$/", "$0-") : ""
  default_name                 = "${local.name_prefix}${var.stack}-${var.client_name}-${var.location_short}-${var.environment}-aci"
  default_network_profile_name = "${local.name_prefix}${var.stack}-${var.client_name}-${var.location_short}-${var.environment}-acinpn"
  default_nic_name             = "${local.name_prefix}${var.stack}-${var.client_name}-${var.location_short}-${var.environment}-acinn"
  default_ipcfg_name           = "${local.name_prefix}${var.stack}-${var.client_name}-${var.location_short}-${var.environment}-aciipcfg"


  default_tags = {
    env   = var.environment
    stack = var.stack
  }
}
