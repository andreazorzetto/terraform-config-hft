# Configure the Azure Provider
provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  version = "=1.38.0"
  subscription_id = "a559d111-d63d-4467-941e-582332046768"
}

# Create a resource group
resource "azurerm_resource_group" "betting_hft" {
  name     = "betting_hft"
  location = "North Europe"
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "betting_hft_vnet" {
  name                = "betting_hft-vnet"
  resource_group_name = azurerm_resource_group.betting_hft.name
  location            = azurerm_resource_group.betting_hft.location
  address_space       = ["10.0.0.0/24"]
}
