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

variable "subnet_id" {
  description = <<EOD
Subnet Id of the private network profile of the container.
Mandatory when VNet integration is enabled.
EOD
  type        = string
  default     = null
}

variable "os_type" {
  description = "The OS for the container group. Allowed values are Linux and Windows. Changing this forces a new resource to be created."
  type        = string
  default     = "Linux"
}

variable "restart_policy" {
  description = "Restart policy for the container group. Allowed values are Always, Never, OnFailure. Defaults to Always. Changing this forces a new resource to be created."
  type        = string
  default     = "Always"
}

variable "vnet_integration_enabled" {
  description = "Allow to enable Vnet integration"
  type        = bool
  default     = false
}

variable "dns_name_label" {
  description = "ACI Custom DNS name label used when container is public."
  type        = string
  default     = null
}
