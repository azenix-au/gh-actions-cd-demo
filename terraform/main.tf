terraform {
  backend "azurerm" {
    resource_group_name  = "tfstatefile"
    storage_account_name = "tfstatefileacc"
    container_name       = "tfstate"
    key                  = "example.tfstate"
  }
}

provider "azurerm" {
  # The "feature" block is required for AzureRM provider 2.x.
  # If you're using version 1.x, the "features" block is not allowed.
  version = "~>2.0"
  features {}
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rsg_app" {
  name     = "app-service-example"
  location = "Australia East"
}

resource "azurerm_app_service_plan" "example" {
  name                = "app-service-example-s1"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Standard"
    size = "S1"
  }
}
