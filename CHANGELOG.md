# Unreleased

Added
  * Add Liveness and readiness probes
  * Add Dns Name Label Reuse Policy

# v7.3.0 - 2022-12-09

Changed
  * [GH-3](https://github.com/claranet/terraform-azurerm-aci/pull/3): Update private ACI mode (VNet integration), bump AzureRM provider to `v3.29+`

# v7.2.0 - 2022-11-23

Changed
  * AZ-908: Use the new data source for CAF naming (instead of resource)

# v7.1.0 - 2022-10-21

Added
  * [GH-1](https://github.com/claranet/terraform-azurerm-aci/pull/1): Add volumes configuration option

# v7.0.0 - 2022-10-21

Breaking
  * AZ-840: Require Terraform 1.3+
  * AZ-880: Rework module code, minimum AzureRM version to `v3.22`
  * AZ-846: Bump diagnostics settings module

# v5.0.0 - 2022-05-06

Breaking
  * AZ-515: Option to use Azure CAF naming provider to name resources
  * AZ-515: Require Terraform 0.13+

Changed
  * AZ-589: Update diagnostics settings to `v5.0.0`

# v4.4.0 - 2022-05-06

Added
  * AZ-677: Add `containers_config` options (`environment_variables, secure_environment_variables, commands`)

# v4.3.0 - 2022-01-21

Added
  * AZ-615: Add an option to enable or disable default tags

Fixed
  * AZ-615: Cannot use a `null` value in `dynamic for_each`

# v4.2.0 - 2021-11-15

Added
  * AZ-589: Add and enable diagnostics

# v4.1.0 - 2021-10-07

Breaking
  * AZ-563: Add VNet integration

Changed
  * AZ-572: Revamp examples and improve CI

# v3.0.2/v4.0.1 - 2021-08-27

Changed
  * AZ-532: Revamp README with latest `terraform-docs` tool

# v2.0.1/v3.0.1/v4.0.0 - 2020-10-20

Updated
  * AZ-273: Module now compatible terraform `v0.13+`

# v2.0.0/v3.0.0 - 2020-09-16

Added
  * AZ-259: Azure Container instances - first Release
