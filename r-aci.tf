resource "azurerm_container_group" "aci" {
  name = local.aci_name

  location            = var.location
  resource_group_name = var.resource_group_name

  ip_address_type    = var.vnet_integration_enabled ? "Private" : "Public"
  network_profile_id = var.vnet_integration_enabled ? azurerm_network_profile.network_profile["enabled"].id : null
  dns_name_label     = var.vnet_integration_enabled ? null : coalesce(var.dns_name_label, local.aci_name)

  os_type = var.os_type

  restart_policy = var.restart_policy

  dynamic "image_registry_credential" {
    for_each = var.registry_credential != null ? [1] : []

    content {
      username = var.registry_credential.username
      password = var.registry_credential.password
      server   = var.registry_credential.server
    }
  }

  dynamic "container" {
    for_each = var.containers_config

    content {
      name = container.value.name

      image  = container.value.image
      cpu    = container.value.cpu
      memory = container.value.memory

      environment_variables        = container.value.environment_variables
      secure_environment_variables = container.value.secure_environment_variables
      commands                     = container.value.commands

      dynamic "ports" {
        for_each = container.value.ports

        content {
          port     = ports.value.port
          protocol = ports.value.protocol
        }
      }

      dynamic "volume" {
        for_each = container.value.volume

        content {
          name                 = volume.value.name
          mount_path           = volume.value.mount_path
          read_only            = try(volume.value.read_only, null)
          empty_dir            = try(volume.value.empty_dir, null)
          storage_account_name = try(volume.value.storage_account_name, null)
          storage_account_key  = try(volume.value.storage_account_key, null)
          share_name           = try(volume.value.share_name, null)
          secret               = try(volume.value.secret, null)
        }
      }
    }
  }

  tags = merge(local.default_tags, var.extra_tags)
}
