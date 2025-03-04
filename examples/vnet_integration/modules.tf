locals {
  vnet_cidr_list = ["10.10.0.0/16"]
}

module "vnet" {
  source  = "claranet/vnet/azurerm"
  version = "x.x.x"

  environment         = var.environment
  location            = module.azure_region.location
  location_short      = module.azure_region.location_short
  client_name         = var.client_name
  stack               = var.stack
  resource_group_name = module.rg.name

  cidrs = local.vnet_cidr_list
}

module "subnet" {
  source  = "claranet/subnet/azurerm"
  version = "x.x.x"

  environment         = var.environment
  location_short      = module.azure_region.location_short
  client_name         = var.client_name
  stack               = var.stack
  resource_group_name = module.rg.name

  virtual_network_name = module.vnet.name

  cidrs = ["10.10.11.0/24"]

  delegations = {
    "Microsoft.ContainerInstance.containerGroups" = [
      {
        name    = "Microsoft.ContainerInstance/containerGroups"
        actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
      }
    ]
  }
}

module "acr" {
  source  = "claranet/acr/azurerm"
  version = "x.x.x"

  location            = module.azure_region.location
  location_short      = module.azure_region.location_short
  client_name         = var.client_name
  environment         = var.environment
  stack               = var.stack
  resource_group_name = module.rg.name

  sku = "Premium"

  logs_destinations_ids = [
    module.logs.id,
    module.logs.storage_account_id
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

  vnet_integration_enabled = true
  subnet_ids               = [module.subnet.id]

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
    module.logs.id,
    module.logs.storage_account_id
  ]

  extra_tags = {
    foo = "bar"
  }
}
