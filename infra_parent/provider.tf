terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.32.0"
    }
  }
}

provider "azurerm" {
  features {}
subscription_id = "f732a1d0-ce01-4a76-a731-84b6a6286211"

}