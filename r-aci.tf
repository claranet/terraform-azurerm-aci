resource "azurerm_container_group" "aci" {
  name = coalesce(var.custom_name, local.default_name)

  location            = var.location
  resource_group_name = var.resource_group_name

  ip_address_type    = var.vnet_integration_enabled ? "Private" : "Public"
  network_profile_id = var.vnet_integration_enabled ? azurerm_network_profile.network_profile[0].id : null
  dns_name_label     = var.vnet_integration_enabled ? null : coalesce(var.dns_name_label, local.default_name)

  os_type = var.os_type

  restart_policy = var.restart_policy

  dynamic "image_registry_credential" {
    for_each = var.registry_credential != null ? ["fake"] : null

    content {
      username = var.registry_credential.username
      password = var.registry_credential.password
      server   = var.registry_credential.server
    }
  }

  dynamic "container" {
    for_each = var.containers_config

    content {
      name = container.key

      image  = container.value.image
      cpu    = container.value.cpu
      memory = container.value.memory

      dynamic "ports" {
        for_each = container.value.ports

        content {
          port     = ports.value.port
          protocol = ports.value.protocol
        }
      }
    }
  }

  tags = merge(local.default_tags, var.extra_tags)
}

