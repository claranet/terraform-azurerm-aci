## 8.0.1 (2025-09-30)

### Code Refactoring

* **deps:** 🔗 update claranet/azurecaf to ~> 1.3.0 🔧 77cfea3

### Miscellaneous Chores

* **⚙️:** ✏️ update template identifier for MR review 75de90e
* 🗑️ remove old commitlint configuration files 889f8c8
* **deps:** 🔗 bump AzureRM provider version to v4.31+ 7cbaa7d
* **deps:** update dependency claranet/diagnostic-settings/azurerm to ~> 8.1.0 909c730
* **deps:** update dependency opentofu to v1.10.0 ce3ce74
* **deps:** update dependency opentofu to v1.10.1 07939a2
* **deps:** update dependency opentofu to v1.10.3 2514d33
* **deps:** update dependency opentofu to v1.10.6 e9c407b
* **deps:** update dependency opentofu to v1.9.1 84716c6
* **deps:** update dependency pre-commit to v4.2.0 34dc022
* **deps:** update dependency terraform-docs to v0.20.0 bdff796
* **deps:** update dependency tflint to v0.56.0 3081c02
* **deps:** update dependency tflint to v0.58.0 2e5e76d
* **deps:** update dependency tflint to v0.58.1 e1be357
* **deps:** update dependency tflint to v0.59.1 fc8e335
* **deps:** update dependency trivy to v0.60.0 5134c1e
* **deps:** update dependency trivy to v0.61.0 4afd181
* **deps:** update dependency trivy to v0.61.1 b1b8971
* **deps:** update dependency trivy to v0.63.0 9404110
* **deps:** update dependency trivy to v0.66.0 269afa6
* **deps:** update dependency trivy to v0.67.0 658ff2c
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.22.0 0e5198d
* **deps:** update pre-commit hook pre-commit/pre-commit-hooks to v6 48a72e6
* **deps:** update pre-commit hook tofuutils/pre-commit-opentofu to v2.2.0 34481ce
* **deps:** update pre-commit hook tofuutils/pre-commit-opentofu to v2.2.1 b361ce6
* **deps:** update terraform claranet/diagnostic-settings/azurerm to ~> 8.2.0 013722a
* **deps:** update tools 06ed2d4
* **deps:** update tools e80c52c
* **deps:** update tools 5710ac2
* **deps:** update tools 9b5afac

## 8.0.0 (2025-02-28)

### ⚠ BREAKING CHANGES

* **AZ-1088:** module standardization

### Features

* **AZ-1088:** module v8 be319b2
* **AZ-1088:** rework module fec2ae8

### Documentation

* fix example 6e614dc

### Miscellaneous Chores

* **AZ-1088:** apply suggestions fb859c6
* **deps:** update dependency opentofu to v1.8.4 952473c
* **deps:** update dependency opentofu to v1.8.6 9cfaddf
* **deps:** update dependency opentofu to v1.8.8 758d180
* **deps:** update dependency opentofu to v1.9.0 edc7963
* **deps:** update dependency pre-commit to v4 aff6fe4
* **deps:** update dependency pre-commit to v4.0.1 c7127e1
* **deps:** update dependency pre-commit to v4.1.0 e1635e9
* **deps:** update dependency tflint to v0.54.0 a864c8d
* **deps:** update dependency tflint to v0.55.0 6da8d3a
* **deps:** update dependency trivy to v0.56.2 41d47f6
* **deps:** update dependency trivy to v0.57.1 4ea1259
* **deps:** update dependency trivy to v0.58.1 2aff259
* **deps:** update dependency trivy to v0.58.2 7249310
* **deps:** update dependency trivy to v0.59.1 8da3425
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.19.0 ac6dd98
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.20.0 ff61d33
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.21.0 6157410
* **deps:** update pre-commit hook pre-commit/pre-commit-hooks to v5 23bbd0b
* **deps:** update pre-commit hook tofuutils/pre-commit-opentofu to v2.1.0 568e1c1
* **deps:** update tools 9aceab2
* **deps:** update tools ae8bcbc
* **deps:** update tools 3b53e67
* prepare for new examples structure 3f461b3
* update examples structure bc81c31
* update Github templates d769c9a
* update tflint config for v0.55.0 927c727

## 7.7.0 (2024-10-04)

### Features

* **AZ-1458:** add `user_assigned_identity` option to `registry_credential` input 8a4de85

### Miscellaneous Chores

* **deps:** update dependency claranet/diagnostic-settings/azurerm to v7 f3b22e8
* **deps:** update dependency opentofu to v1.8.3 25791bc
* **deps:** update dependency trivy to v0.56.0 c3c109d
* **deps:** update dependency trivy to v0.56.1 3f14554

## 7.6.0 (2024-10-03)

### Features

* use Claranet "azurecaf" provider a577184

### Documentation

* update README badge to use OpenTofu registry 8ee7670
* update README with `terraform-docs` v0.19.0 06c452b

### Continuous Integration

* **AZ-1391:** enable semantic-release ce6a976
* **AZ-1391:** update semantic-release config [skip ci] 50341c6

### Miscellaneous Chores

* **deps:** add renovate.json 6bcef0e
* **deps:** enable automerge on renovate 7cdaa5f
* **deps:** update dependency opentofu to v1.7.0 bccf4a9
* **deps:** update dependency opentofu to v1.7.1 4a8a4ed
* **deps:** update dependency opentofu to v1.7.2 92a0060
* **deps:** update dependency opentofu to v1.7.3 3b4c697
* **deps:** update dependency opentofu to v1.8.0 1ce04bf
* **deps:** update dependency opentofu to v1.8.1 1786331
* **deps:** update dependency opentofu to v1.8.2 1b7699d
* **deps:** update dependency pre-commit to v3.7.1 388bf41
* **deps:** update dependency pre-commit to v3.8.0 87c6040
* **deps:** update dependency terraform-docs to v0.18.0 0f5ccb4
* **deps:** update dependency terraform-docs to v0.19.0 ef2ec85
* **deps:** update dependency tflint to v0.51.0 537f265
* **deps:** update dependency tflint to v0.51.1 9caa435
* **deps:** update dependency tflint to v0.51.2 de282a8
* **deps:** update dependency tflint to v0.52.0 84fed2c
* **deps:** update dependency tflint to v0.53.0 64eac34
* **deps:** update dependency trivy to v0.50.2 8929ed7
* **deps:** update dependency trivy to v0.50.4 ceb2197
* **deps:** update dependency trivy to v0.51.0 2f96361
* **deps:** update dependency trivy to v0.51.1 21c91f2
* **deps:** update dependency trivy to v0.51.2 c7c6815
* **deps:** update dependency trivy to v0.51.3 b598921
* **deps:** update dependency trivy to v0.51.4 548cd59
* **deps:** update dependency trivy to v0.52.0 14abb3f
* **deps:** update dependency trivy to v0.52.1 736a0c6
* **deps:** update dependency trivy to v0.52.2 d9f2171
* **deps:** update dependency trivy to v0.53.0 1415967
* **deps:** update dependency trivy to v0.54.1 b2550be
* **deps:** update dependency trivy to v0.55.0 be85aec
* **deps:** update dependency trivy to v0.55.1 9b3a70a
* **deps:** update dependency trivy to v0.55.2 fd1030c
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.17.0 26cddd0
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.18.0 7519896
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.0 40aeb07
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.1 d405554
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.2 491e8d3
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.3 007a626
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.93.0 ba81643
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.0 064697a
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.1 769b382
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.2 a7a540e
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.3 7358e4a
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.95.0 b77c8a3
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.96.0 ea020e2
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.96.1 1b7dfad
* **deps:** update renovate.json 5a9b499
* **pre-commit:** update commitlint hook 15baaaa
* **release:** remove legacy `VERSION` file f8d1a6b

# v7.5.1 - 2024-02-23

Changed
  * AZ-1339: Remove Terraform version restriction

# v7.5.0 - 2023-12-01

Added
  * AZ-1194: Add init_containers block
  * AZ-1201: Add dns_config block

# v7.4.0 - 2023-09-29

Breaking
  * AZ-1153: Remove `retention_days` parameters, it must be handled at destination level now. (for reference: [Provider issue](https://github.com/hashicorp/terraform-provider-azurerm/issues/23051))

Added
  * [GH-5](https://github.com/claranet/terraform-azurerm-aci/pull/5): Add liveness and readiness probes
  * [GH-5](https://github.com/claranet/terraform-azurerm-aci/pull/5): Add DNS name label reuse policy
  * [GH-5](https://github.com/claranet/terraform-azurerm-aci/pull/5): Add identity block

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
