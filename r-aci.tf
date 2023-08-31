resource "azurerm_container_group" "aci" {
  name = local.aci_name

  location            = var.location
  resource_group_name = var.resource_group_name

  ip_address_type = var.vnet_integration_enabled ? "Private" : "Public"
  subnet_ids      = var.vnet_integration_enabled ? var.subnet_ids : null

  dns_name_label              = var.vnet_integration_enabled ? null : coalesce(var.dns_name_label, local.aci_name)
  dns_name_label_reuse_policy = var.vnet_integration_enabled ? null : var.dns_name_label_reuse_policy

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
          read_only            = volume.value.read_only
          empty_dir            = volume.value.empty_dir
          storage_account_name = volume.value.storage_account_name
          storage_account_key  = volume.value.storage_account_key
          share_name           = volume.value.share_name
          secret               = volume.value.secret
        }
      }

      dynamic "readiness_probe" {
        for_each = !var.vnet_integration_enabled ? try(container.value.readiness_probe[*], []) : []
        content {
          exec = lookup(readiness_probe.value, "exec", null)
          dynamic "http_get" {
            for_each = try(readiness_probe.value.http_get[*], [])
            content {
              path         = http_get.value.path
              port         = http_get.value.port
              scheme       = http_get.value.scheme
              http_headers = http_get.value.http_headers
            }
          }
          initial_delay_seconds = lookup(readiness_probe.value, "initial_delay_seconds", 0)
          period_seconds        = lookup(readiness_probe.value, "period_seconds", 10)
          failure_threshold     = lookup(readiness_probe.value, "failure_threshold", 3)
          success_threshold     = lookup(readiness_probe.value, "success_threshold", 1)
          timeout_seconds       = lookup(readiness_probe.value, "timeout_seconds", 1)
        }
      }

      dynamic "liveness_probe" {
        for_each = !var.vnet_integration_enabled ? try(container.value.liveness_probe[*], []) : []
        content {
          exec = lookup(liveness_probe.value, "exec", null)
          dynamic "http_get" {
            for_each = try(liveness_probe.value.http_get[*], [])
            content {
              path         = http_get.value.path
              port         = http_get.value.port
              scheme       = http_get.value.scheme
              http_headers = http_get.value.http_headers
            }
          }
          initial_delay_seconds = lookup(liveness_probe.value, "initial_delay_seconds", 0)
          period_seconds        = lookup(liveness_probe.value, "period_seconds", 10)
          failure_threshold     = lookup(liveness_probe.value, "failure_threshold", 3)
          success_threshold     = lookup(liveness_probe.value, "success_threshold", 1)
          timeout_seconds       = lookup(liveness_probe.value, "timeout_seconds", 1)
        }
      }

    }
  }

  tags = merge(local.default_tags, var.extra_tags)
}
