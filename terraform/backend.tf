terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstateash224948386"
    container_name       = "tfstate"
    key                  = "week08.tfstate"
  }
}