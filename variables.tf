## Common variables
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

variable "name_prefix" {
  description = "Optional prefix for Azure Container Instances group name"
  type        = string
  default     = ""
}

variable "custom_name" {
  description = "Custom Azure Container Instances group name, generated if not set"
  type        = string
  default     = ""
}

variable "extra_tags" {
  description = "Additional tags to associate with your Azure Container Instances group."
  type        = map(string)
  default     = {}
}

## ACI Specifics
variable "containers_config" {
  description = <<EOD
Containers configurations, defined by this type:
```
map(
  container-name (string) : object({
    image  = string
    cpu    = number
    memory = number

    ports = object({
      port     = number
      protocol = string
    })
  })
)
```
EOD
  type        = map(any)
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

variable "nic_custom_name" {
  description = "Custom name for the container private network interface. Used when VNet integration is enabled."
  type        = string
  default     = null
}

variable "ipcfg_custom_name" {
  description = "Custom name for the container ip configuration attached to its private network interface. Used when VNet integration is enabled."
  type        = string
  default     = null
}

variable "network_profile_custom_name" {
  description = "Custom name for the container private network profile. Used when VNet integration is enabled."
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

