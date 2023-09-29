# Azure container instances group
[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-yellow.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![TF Registry](https://img.shields.io/badge/terraform-registry-blue.svg)](https://registry.terraform.io/modules/claranet/aci/azurerm/)

Azure module to generate a [Container instances](https://docs.microsoft.com/en-us/azure/container-instances/container-instances-overview) group.

<!-- BEGIN_TF_DOCS -->
## Global versioning rule for Claranet Azure modules

| Module version | Terraform version | AzureRM version |
| -------------- | ----------------- | --------------- |
| >= 7.x.x       | 1.3.x             | >= 3.0          |
| >= 6.x.x       | 1.x               | >= 3.0          |
| >= 5.x.x       | 0.15.x            | >= 2.0          |
| >= 4.x.x       | 0.13.x / 0.14.x   | >= 2.0          |
| >= 3.x.x       | 0.12.x            | >= 2.0          |
| >= 2.x.x       | 0.12.x            | < 2.0           |
| <  2.x.x       | 0.11.x            | < 2.0           |

## Contributing

If you want to contribute to this repository, feel free to use our [pre-commit](https://pre-commit.com/) git hook configuration
which will help you automatically update and format some files for you by enforcing our Terraform code module best-practices.

More details are available in the [CONTRIBUTING.md](./CONTRIBUTING.md#pull-request-process) file.

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

module "logs" {
  source  = "claranet/run/azurerm//modules/logs"
  version = "x.x.x"

  client_name         = var.client_name
  environment         = var.environment
  stack               = var.stack
  location            = module.azure_region.location
  location_short      = module.azure_region.location_short
  resource_group_name = module.rg.resource_group_name
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

  logs_destinations_ids = [
    module.logs.logs_storage_account_id,
    module.logs.log_analytics_workspace_id
  ]

  extra_tags = {
    foo = "bar"
  }
}

module "aci" {
  source  = "claranet/aci/azurerm"
  version = "x.x.x"

  location       = module.azure_region.location
  location_short = module.azure_region.location_short
  client_name    = var.client_name
  environment    = var.environment
  stack          = var.stack

  resource_group_name = module.rg.resource_group_name

  restart_policy = "OnFailure"

  containers_config = [
    {
      name   = "aci-example"
      image  = "${module.acr.login_server}/samples/nginx:latest"
      cpu    = 1
      memory = 2

      ports = [{
        port     = 80
        protocol = "TCP"
      }]
    }
  ]

  registry_credential = {
    username = module.acr.admin_username
    password = module.acr.admin_password
    server   = module.acr.login_server
  }

  logs_destinations_ids = [
    module.logs.logs_storage_account_id,
    module.logs.log_analytics_workspace_id
  ]

  extra_tags = {
    foo = "bar"
  }
}
```

## Providers

| Name | Version |
|------|---------|
| azurecaf | ~> 1.2, >= 1.2.22 |
| azurerm | ~> 3.71 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| diagnostics | claranet/diagnostic-settings/azurerm | ~> 6.5.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_container_group.aci](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_group) | resource |
| [azurecaf_name.aci](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/data-sources/name) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| client\_name | Client name/account used in naming | `string` | n/a | yes |
| containers\_config | Containers configurations. | <pre>list(object({<br>    name = string<br><br>    image  = string<br>    cpu    = number<br>    memory = number<br><br>    environment_variables        = optional(map(string))<br>    secure_environment_variables = optional(map(string))<br>    commands                     = optional(list(string))<br><br>    ports = list(object({<br>      port     = number<br>      protocol = string<br>    }))<br><br>    volume = optional(list(object({<br>      name                 = string<br>      mount_path           = string<br>      read_only            = optional(bool)<br>      empty_dir            = optional(bool)<br>      storage_account_name = optional(string)<br>      storage_account_key  = optional(string)<br>      share_name           = optional(string)<br>      secret               = optional(map(any))<br>    })), [])<br><br>    readiness_probe = optional(object({<br>      exec = optional(list(string))<br>      http_get = optional(object({<br>        path         = optional(string)<br>        port         = optional(number)<br>        scheme       = optional(string)<br>        http_headers = optional(map(string))<br>      }))<br>      initial_delay_seconds = optional(number)<br>      period_seconds        = optional(number)<br>      failure_threshold     = optional(number)<br>      success_threshold     = optional(number)<br>      timeout_seconds       = optional(number)<br>    }))<br><br>    liveness_probe = optional(object({<br>      exec = optional(list(string))<br>      http_get = optional(object({<br>        path         = optional(string)<br>        port         = optional(number)<br>        scheme       = optional(string)<br>        http_headers = optional(map(string))<br>      }))<br>      initial_delay_seconds = optional(number)<br>      period_seconds        = optional(number)<br>      failure_threshold     = optional(number)<br>      success_threshold     = optional(number)<br>      timeout_seconds       = optional(number)<br>    }))<br><br>  }))</pre> | n/a | yes |
| custom\_diagnostic\_settings\_name | Custom name of the diagnostics settings, name will be 'default' if not set. | `string` | `"default"` | no |
| custom\_name | Custom Azure Container Instances group name, generated if not set | `string` | `""` | no |
| default\_tags\_enabled | Option to enable or disable default tags. | `bool` | `true` | no |
| dns\_name\_label | ACI Custom DNS name label used when container is public. | `string` | `null` | no |
| dns\_name\_label\_reuse\_policy | The value representing the security enum. Noreuse, ResourceGroupReuse, SubscriptionReuse, TenantReuse or Unsecure. Defaults to Unsecure. | `string` | `"Unsecure"` | no |
| environment | Project environment | `string` | n/a | yes |
| extra\_tags | Additional tags to associate with your Azure Container Instances group. | `map(string)` | `{}` | no |
| identity | Map with identity block information. | <pre>object({<br>    type         = optional(string, "SystemAssigned")<br>    identity_ids = optional(list(string))<br>  })</pre> | `{}` | no |
| init\_containers | initContainer configuration. | <pre>list(object({<br>    name                         = string<br>    image                        = string<br>    environment_variables        = optional(map(string), {})<br>    secure_environment_variables = optional(map(string), {})<br>    commands                     = optional(list(string), [])<br>    volume = optional(list(object({<br>      name                 = string<br>      mount_path           = string<br>      read_only            = optional(bool)<br>      empty_dir            = optional(bool)<br>      storage_account_name = optional(string)<br>      storage_account_key  = optional(string)<br>      share_name           = optional(string)<br>      secret               = optional(map(any))<br>    })), [])<br>    security = optional(object({<br>      privilege_enabled = bool<br>    }), null)<br>  }))</pre> | `[]` | no |
| location | Azure region to use | `string` | n/a | yes |
| location\_short | Short string for Azure location | `string` | n/a | yes |
| logs\_categories | Log categories to send to destinations. | `list(string)` | `null` | no |
| logs\_destinations\_ids | List of destination resources IDs for logs diagnostic destination.<br>Can be `Storage Account`, `Log Analytics Workspace` and `Event Hub`. No more than one of each can be set.<br>If you want to specify an Azure EventHub to send logs and metrics to, you need to provide a formated string with both the EventHub Namespace authorization send ID and the EventHub name (name of the queue to use in the Namespace) separated by the `|` character. | `list(string)` | n/a | yes |
| logs\_metrics\_categories | Metrics categories to send to destinations. | `list(string)` | `null` | no |
| name\_prefix | Optional prefix for the generated name | `string` | `""` | no |
| name\_suffix | Optional suffix for the generated name | `string` | `""` | no |
| os\_type | The OS for the container group. Allowed values are Linux and Windows. Changing this forces a new resource to be created. | `string` | `"Linux"` | no |
| registry\_credential | A registry\_credential object as documented below. Changing this forces a new resource to be created. | <pre>object({<br>    username = string<br>    password = string<br>    server   = string<br>  })</pre> | `null` | no |
| resource\_group\_name | Name of the resource group | `string` | n/a | yes |
| restart\_policy | Restart policy for the container group. Allowed values are `Always`, `Never`, `OnFailure`. Changing this forces a new resource to be created. | `string` | `"Always"` | no |
| stack | Project stack name | `string` | n/a | yes |
| subnet\_ids | Subnet IDs of the private network profile of the container.<br>Mandatory when VNet integration is enabled. | `list(string)` | `null` | no |
| use\_caf\_naming | Use the Azure CAF naming provider to generate default resource name. `custom_name` override this if set. Legacy default name is used if this is set to `false`. | `bool` | `true` | no |
| vnet\_integration\_enabled | Allow to enable Vnet integration. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| aci\_fqdn | The FQDN of the container group derived from `dns_name_label`. |
| aci\_id | Azure container instance group ID |
| aci\_identity\_principal\_id | ACI identity principal ID. |
| aci\_ip\_address | The IP address allocated to the container instance group. |
<!-- END_TF_DOCS -->

## Related documentation

Microsoft Azure documentation: [docs.microsoft.com/en-us/azure/container-instances/container-instances-overview](https://docs.microsoft.com/en-us/azure/container-instances/container-instances-overview)
