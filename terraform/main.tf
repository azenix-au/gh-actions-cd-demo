terraform {
  backend "azurerm" {
    resource_group_name  = "phall-github-actions"
    storage_account_name = "phalltfstatefile"
    container_name       = "tfstate"
    key                  = "example.tfstate"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}

data "azurerm_client_config" "current" {}

# Using a SP limited to a RG so can't create a new RG.
# resource "azurerm_resource_group" "rsg_app" {
#   name     = "app-service-example"
#   location = "Australia East"
# }

resource "azurerm_app_service_plan" "example" {
  name                = "app-service-example-s1"
  resource_group_name = "phall-github-actions"
  location            = "Australia East"
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Free"
    size = "F1"
  }
}
