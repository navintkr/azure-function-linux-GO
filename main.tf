provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "${var.prefix}-functionapp-rg"
  location = var.region
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}functionvnet"
  location            = var.region
  resource_group_name = azurerm_resource_group.example.name
  address_space       = ["10.0.0.0/16"]

  dns_servers = ["168.63.129.16"]
}

resource "azurerm_subnet" "subnetFunctionApp" {
  name                 = "${var.prefix}functionsubnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/24"]
  service_endpoints    = ["Microsoft.Storage"]
  delegation {
    name = "delegation"
    service_delegation {
      name = "Microsoft.Web/serverFarms"
    }
  }
}

resource "azurerm_service_plan" "adf-functions-premium-asp" {
  name                = "${var.prefix}-function-asp"
  location            = var.region
  resource_group_name = azurerm_resource_group.example.name
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_function_app" "functionapp" {

  name                       = "${var.prefix}funcexample"
  location                   = var.region
  resource_group_name        = azurerm_resource_group.example.name
  service_plan_id            = azurerm_service_plan.adf-functions-premium-asp.id
  storage_account_name       = azurerm_storage_account.functionAppStorage.name
  storage_account_access_key = azurerm_storage_account.functionAppStorage.primary_access_key
  virtual_network_subnet_id  = azurerm_subnet.subnetFunctionApp.id
  https_only                 = true
  site_config { 
    minimum_tls_version = "1.2"
  }

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME" = "custom",
    "WEBSITE_DNS_SEVER"                        = "168.63.129.16"
  }
}
