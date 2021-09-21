# Azure container instances group
[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-yellow.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![TF Registry](https://img.shields.io/badge/terraform-registry-blue.svg)](https://registry.terraform.io/modules/claranet/aci/azurerm/)

Azure module to generate a [Container instances](https://docs.microsoft.com/en-us/azure/container-instances/container-instances-overview) group.

<!-- BEGIN_TF_DOCS -->
## Global versioning rule for Claranet Azure modules

| Module version | Terraform version | AzureRM version |
| -------------- | ----------------- | --------------- |
| >= 5.x.x       | 0.15.x & 1.0.x    | >= 2.0          |
| >= 4.x.x       | 0.13.x            | >= 2.0          |
| >= 3.x.x       | 0.12.x            | >= 2.0          |
| >= 2.x.x       | 0.12.x            | < 2.0           |
| <  2.x.x       | 0.11.x            | < 2.0           |

## Usage

This module is optimized to work with the [Claranet terraform-wrapper](https://github.com/claranet/terraform-wrapper) tool
which set some terraform variables in the environment needed by this module.
More details about variables set by the `terraform-wrapper` available in the [documentation](https://github.com/claranet/terraform-wrapper#environment).

```hcl
module "azure_region" {
  source  = "claranet/regions/azurerm"
  version = "x.x.x"

  azure_region = var.azure_region
}

module "rg" {
  source  = "claranet/rg/azurerm"
  version = "x.x.x"

  location    = module.azure_region.location
  client_name = var.client_name
  environment = var.environment
  stack       = var.stack
}

module "acr" {
  source  = "claranet/acr/azurerm"
  version = "x.x.x"

  location            = module.azure_region.location
  location_short      = module.azure_region.location_short
  resource_group_name = module.rg.resource_group_name
  sku                 = "Standard"

  client_name = var.client_name
  environment = var.environment
  stack       = var.stack
}

module "aci_myapp" {
  source  = "claranet/aci/azurerm"
  version = "x.x.x"

  location       = module.azure_region.location
  location_short = module.azure_region.location_short
  client_name    = var.client_name
  environment    = var.environment
  stack          = var.stack

  resource_group_name = module.rg.resource_group_name

  name_prefix        = "myapp"
  aci_restart_policy = "OnFailure"

  aci_containers_config = {
    "container-hello-world" = {
      image  = "microsoft/aci-helloworld:latest"
      cpu    = 1
      memory = 2

      ports = [{
        port     = 80
        protocol = "TCP"
      }]
    }
  }

  aci_registry_credential = {
    username = module.acr.admin_username
    password = module.acr.admin_password
    server   = module.acr.acr_fqdn
  }
}

```

## Providers

| Name | Version |
|------|---------|
| azurerm | >= 1.31 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_container_group.aci](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aci\_containers\_config | Containers configurations, defined by this type:<pre>map(<br>  container-name (string) : object({<br>    image  = string<br>    cpu    = number<br>    memory = number<br><br>    ports = object({<br>      port     = number<br>      protocol = string<br>    })<br>  })<br>)</pre> | `map(any)` | n/a | yes |
| aci\_ip\_address\_type | Specifies the ip address type of the container.<br>`Public` or `Private`.<br>Changing this forces a new resource to be created. If set to `Private`, `network_profile_id` also needs to be set. | `string` | `"Public"` | no |
| aci\_os\_type | The OS for the container group. Allowed values are Linux and Windows. Changing this forces a new resource to be created. | `string` | `"Linux"` | no |
| aci\_registry\_credential | A image\_registry\_credential block as documented below. Changing this forces a new resource to be created.<pre>map(string) {<br>  username - (Required) The username with which to connect to the registry. Changing this forces a new resource to be created.<br>  password - (Required) The password with which to connect to the registry. Changing this forces a new resource to be created.<br>  server - (Required) The address to use to connect to the registry without protocol ("https"/"http"). For example: "myacr.acr.io". Changing this forces a new resource to be created.<br>}</pre> | `map(string)` | `null` | no |
| aci\_restart\_policy | Restart policy for the container group. Allowed values are Always, Never, OnFailure. Defaults to Always. Changing this forces a new resource to be created. | `string` | `"Always"` | no |
| client\_name | Client name/account used in naming | `string` | n/a | yes |
| custom\_name | Custom Azure Container Instances group name, generated if not set | `string` | `""` | no |
| environment | Project environment | `string` | n/a | yes |
| extra\_tags | Additional tags to associate with your Azure Container Instances group. | `map(string)` | `{}` | no |
| location | Azure region to use | `string` | n/a | yes |
| location\_short | Short string for Azure location | `string` | n/a | yes |
| name\_prefix | Optional prefix for Azure Container Instances group name | `string` | `""` | no |
| resource\_group\_name | Name of the resource group | `string` | n/a | yes |
| stack | Project stack name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| aci\_fqdn | The FQDN of the container group derived from `dns_name_label`. |
| aci\_id | Azure container instance group ID |
| aci\_ip\_address | The IP address allocated to the container instance group. |
<!-- END_TF_DOCS -->
## Related documentation

Microsoft Azure documentation: [docs.microsoft.com/en-us/azure/container-instances/container-instances-overview](https://docs.microsoft.com/en-us/azure/container-instances/container-instances-overview)
