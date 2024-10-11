module "acr" {
  source  = "claranet/acr/azurerm"
  version = "x.x.x"

  location            = module.azure_region.location
  location_short      = module.azure_region.location_short
  resource_group_name = module.rg.name
  client_name         = var.client_name
  environment         = var.environment
  stack               = var.stack

  sku = "Standard"

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

  location            = module.azure_region.location
  location_short      = module.azure_region.location_short
  client_name         = var.client_name
  environment         = var.environment
  stack               = var.stack
  resource_group_name = module.rg.name

  restart_policy = "OnFailure"

  containers_config = [
    {
      name   = "aci-example"
      image  = "${module.acr.login_server}/samples/nginx:latest"
      cpu    = 1
      memory = 2

      ports = [
        {
          port     = 80
          protocol = "TCP"
        }
      ]
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
