#### Common variables
variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region to use"
  type        = string
}

variable "location_short" {
  description = "Short string for Azure location"
  type        = string
}

variable "environment" {
  description = "Project environment"
  type        = string
}

variable "stack" {
  description = "Project stack name"
  type        = string
}

variable "client_name" {
  description = "Client name/account used in naming"
  type        = string
}

## ACI Specifics
variable "containers_config" {
  description = "Containers configurations."
  type = list(object({
    name = string

    image  = string
    cpu    = number
    memory = number

    environment_variables        = optional(map(string))
    secure_environment_variables = optional(map(string))
    commands                     = optional(list(string))

    ports = list(object({
      port     = number
      protocol = string
    }))

    volume = optional(list(object({
      name                 = string
      mount_path           = string
      read_only            = optional(bool)
      empty_dir            = optional(bool)
      storage_account_name = optional(string)
      storage_account_key  = optional(string)
      share_name           = optional(string)
      secret               = optional(map(any))
    })), [])

    readiness_probe = optional(object({
      exec = optional(list(string))
      http_get = optional(object({
        path         = optional(string)
        port         = optional(number)
        scheme       = optional(string)
        http_headers = optional(map(string))
      }))
      initial_delay_seconds = optional(number)
      period_seconds        = optional(number)
      failure_threshold     = optional(number)
      success_threshold     = optional(number)
      timeout_seconds       = optional(number)
    }))

    liveness_probe = optional(object({
      exec = optional(list(string))
      http_get = optional(object({
        path         = optional(string)
        port         = optional(number)
        scheme       = optional(string)
        http_headers = optional(map(string))
      }))
      initial_delay_seconds = optional(number)
      period_seconds        = optional(number)
      failure_threshold     = optional(number)
      success_threshold     = optional(number)
      timeout_seconds       = optional(number)
    }))

  }))
}

variable "registry_credential" {
  description = "A registry_credential object as documented below. Changing this forces a new resource to be created."
  type = object({
    username = string
    password = string
    server   = string
  })
  default = null
}

variable "os_type" {
  description = "The OS for the container group. Allowed values are Linux and Windows. Changing this forces a new resource to be created."
  type        = string
  default     = "Linux"
}

variable "restart_policy" {
  description = "Restart policy for the container group. Allowed values are `Always`, `Never`, `OnFailure`. Changing this forces a new resource to be created."
  type        = string
  default     = "Always"
}

variable "vnet_integration_enabled" {
  description = "Allow to enable Vnet integration."
  type        = bool
  default     = false
}

variable "subnet_ids" {
  description = <<EOD
Subnet IDs of the private network profile of the container.
Mandatory when VNet integration is enabled.
EOD
  type        = list(string)
  default     = null
}

variable "dns_name_label" {
  description = "ACI Custom DNS name label used when container is public."
  type        = string
  default     = null
}

variable "dns_name_label_reuse_policy" {
  description = "The value representing the security enum. Noreuse, ResourceGroupReuse, SubscriptionReuse, TenantReuse or Unsecure. Defaults to Unsecure."
  type        = string
  default     = "Unsecure"
}

variable "identity" {
  description = "Map with identity block information."
  type = object({
    type         = optional(string, "SystemAssigned")
    identity_ids = optional(list(string))
  })
  default  = {}
  nullable = false
}

variable "init_containers" {
  description = "initContainer configuration."
  type = list(object({
    name                         = string
    image                        = string
    environment_variables        = optional(map(string), {})
    secure_environment_variables = optional(map(string), {})
    commands                     = optional(list(string), [])
    volume = optional(list(object({
      name                 = string
      mount_path           = string
      read_only            = optional(bool)
      empty_dir            = optional(bool)
      storage_account_name = optional(string)
      storage_account_key  = optional(string)
      share_name           = optional(string)
      secret               = optional(map(any))
    })), [])
    security = optional(object({
      privilege_enabled = bool
    }), null)
  }))
  default  = []
  nullable = false
}
