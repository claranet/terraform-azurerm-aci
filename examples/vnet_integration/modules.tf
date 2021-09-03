locals {
  vnet_cidr_list = ["10.10.0.0/16"]
}

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

module "vnet" {
  source  = "claranet/vnet/azurerm"
  version = "x.x.x"

  environment    = var.environment
  location       = module.azure_region.location
  location_short = module.azure_region.location_short
  client_name    = var.client_name
  stack          = var.stack

  resource_group_name = module.rg.resource_group_name
  vnet_cidr           = local.vnet_cidr_list
}

module "subnet" {
  source  = "claranet/subnet/azurerm"
  version = "x.x.x"

  environment    = var.environment
  location_short = module.azure_region.location_short
  client_name    = var.client_name
  stack          = var.stack

  resource_group_name  = module.rg.resource_group_name
  virtual_network_name = module.vnet.virtual_network_name

  subnet_cidr_list = ["10.10.11.0/24"]

  subnet_delegation = {
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

  location       = module.azure_region.location
  location_short = module.azure_region.location_short
  client_name    = var.client_name

  resource_group_name = module.rg.resource_group_name
  sku                 = "Premium"

  environment = var.environment
  stack       = var.stack
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

  aci_restart_policy = "OnFailure"

  aci_subnet_id               = module.subnet.subnet_id
  aci_enable_vnet_integration = true

  aci_containers_config = {
    "aci" = {
      image  = "${module.acr.login_server}/samples/nginx:latest"
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
    server   = module.acr.login_server
  }

}
