resource "azurerm_container_group" "main" {
  name = local.name

  location            = var.location
  resource_group_name = var.resource_group_name

  ip_address_type = var.vnet_integration_enabled ? "Private" : "Public"
  subnet_ids      = var.vnet_integration_enabled ? var.subnet_ids : null

  dns_name_label              = var.vnet_integration_enabled ? null : coalesce(var.dns_name_label, local.name)
  dns_name_label_reuse_policy = var.vnet_integration_enabled ? null : var.dns_name_label_reuse_policy

  os_type = var.os_type

  restart_policy = var.restart_policy

  dynamic "image_registry_credential" {
    for_each = var.registry_credential[*]

    content {
      username                  = var.registry_credential.username
      password                  = var.registry_credential.password
      server                    = var.registry_credential.server
      user_assigned_identity_id = var.registry_credential.user_assigned_identity_id
    }
  }

  dynamic "dns_config" {
    for_each = var.dns_config[*]
    content {
      nameservers    = dns_config.value.nameservers
      search_domains = dns_config.value.search_domains
      options        = dns_config.value.options

    }
  }

  dynamic "init_container" {
    for_each = var.init_containers
    content {
      name = init_container.value.name

      image                        = init_container.value.image
      environment_variables        = init_container.value.environment_variables
      secure_environment_variables = init_container.value.secure_environment_variables
      commands                     = init_container.value.commands

      dynamic "volume" {
        for_each = init_container.value.volume
        content {
          name                 = volume.value.name
          mount_path           = volume.value.mount_path
          read_only            = volume.value.read_only
          empty_dir            = volume.value.empty_dir
          storage_account_name = volume.value.storage_account_name
          storage_account_key  = volume.value.storage_account_key
          share_name           = volume.value.share_name
          secret               = volume.value.secret
        }
      }

      dynamic "security" {
        for_each = init_container.value.security[*]
        content {
          privilege_enabled = security.value.privilege_enabled
        }
      }
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
          read_only            = volume.value.read_only
          empty_dir            = volume.value.empty_dir
          storage_account_name = volume.value.storage_account_name
          storage_account_key  = volume.value.storage_account_key
          share_name           = volume.value.share_name
          secret               = volume.value.secret
        }
      }

      dynamic "readiness_probe" {
        for_each = !var.vnet_integration_enabled ? container.value.readiness_probe[*] : []
        content {
          exec = readiness_probe.value.exec
          dynamic "http_get" {
            for_each = readiness_probe.value.http_get[*]
            content {
              path         = http_get.value.path
              port         = http_get.value.port
              scheme       = http_get.value.scheme
              http_headers = http_get.value.http_headers
            }
          }
          initial_delay_seconds = readiness_probe.value.initial_delay_seconds
          period_seconds        = readiness_probe.value.period_seconds
          failure_threshold     = readiness_probe.value.failure_threshold
          success_threshold     = readiness_probe.value.success_threshold
          timeout_seconds       = readiness_probe.value.timeout_seconds
        }
      }

      dynamic "liveness_probe" {
        for_each = !var.vnet_integration_enabled ? container.value.liveness_probe[*] : []
        content {
          exec = liveness_probe.value.exec
          dynamic "http_get" {
            for_each = liveness_probe.value.http_get[*]
            content {
              path         = http_get.value.path
              port         = http_get.value.port
              scheme       = http_get.value.scheme
              http_headers = http_get.value.http_headers
            }
          }
          initial_delay_seconds = liveness_probe.value.initial_delay_seconds
          period_seconds        = liveness_probe.value.period_seconds
          failure_threshold     = liveness_probe.value.failure_threshold
          success_threshold     = liveness_probe.value.success_threshold
          timeout_seconds       = liveness_probe.value.timeout_seconds
        }
      }
    }
  }

  dynamic "identity" {
    for_each = var.identity[*]
    content {
      type         = var.identity.type
      identity_ids = var.identity.identity_ids
    }
  }

  tags = merge(local.default_tags, var.extra_tags)
}

moved {
  from = azurerm_container_group.aci
  to   = azurerm_container_group.main
}
