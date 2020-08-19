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
variable "aci_containers_config" {
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

variable "aci_registry_credential" {
  description = <<EOD
A image_registry_credential block as documented below. Changing this forces a new resource to be created.
```
map(string) {
  username - (Required) The username with which to connect to the registry. Changing this forces a new resource to be created.
  password - (Required) The password with which to connect to the registry. Changing this forces a new resource to be created.
  server - (Required) The address to use to connect to the registry without protocol ("https"/"http"). For example: "myacr.acr.io". Changing this forces a new resource to be created.
}
```
EOD
  type        = map(string)
  default     = null
}

variable "aci_ip_address_type" {
  description = <<EOD
Specifies the ip address type of the container.
`Public` or `Private`.
Changing this forces a new resource to be created. If set to `Private`, `network_profile_id` also needs to be set.
EOD
  type        = string
  default     = "Public"
}

variable "aci_os_type" {
  description = "The OS for the container group. Allowed values are Linux and Windows. Changing this forces a new resource to be created."
  type        = string
  default     = "Linux"
}

variable "aci_restart_policy" {
  description = "Restart policy for the container group. Allowed values are Always, Never, OnFailure. Defaults to Always. Changing this forces a new resource to be created."
  type        = string
  default     = "Always"
}
