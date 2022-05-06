# Generic naming variables
variable "name_prefix" {
  description = "Optional prefix for the generated name"
  type        = string
  default     = ""
}

variable "name_suffix" {
  description = "Optional suffix for the generated name"
  type        = string
  default     = ""
}

variable "use_caf_naming" {
  description = "Use the Azure CAF naming provider to generate default resource name. `custom_name` override this if set. Legacy default name is used if this is set to `false`."
  type        = bool
  default     = true
}

# Custom naming override
variable "custom_name" {
  description = "Custom Azure Container Instances group name, generated if not set"
  type        = string
  default     = ""
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
