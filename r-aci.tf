resource "azurerm_container_group" "aci" {
  name = coalesce(var.custom_name, local.aci_name)

  location            = var.location
  resource_group_name = var.resource_group_name

  ip_address_type = var.aci_ip_address_type
  dns_name_label  = coalesce(var.custom_name, local.aci_name)
  os_type         = var.aci_os_type

  restart_policy = var.aci_restart_policy

  dynamic "image_registry_credential" {
    for_each = var.aci_registry_credential == null ? toset([]) : toset([""])

    content {
      username = var.aci_registry_credential.username
      password = var.aci_registry_credential.password
      server   = var.aci_registry_credential.server
    }
  }

  dynamic "container" {
    for_each = var.aci_containers_config

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
