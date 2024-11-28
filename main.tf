terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"

  # This configures where terraform stores its tfstate file.
  backend "azurerm" {
    resource_group_name = "shared-project-resources"
    storage_account_name = "dglstorageaccount"
    container_name = "tfstate"
    key = "http-hello-world.tfstate"
    use_oidc = true
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "http-hello-world" {
  name = "http-hello-world"
  location = "eastus"
}

