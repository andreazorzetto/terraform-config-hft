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


resource "azurerm_subnet" "default" {
  name = "default"
  resource_group_name  = azurerm_resource_group.betting_hft.name
  virtual_network_name = azurerm_virtual_network.betting_hft_vnet.name
  address_prefix       = "10.0.0.0/24"
}


# resource "azurerm_public_ip" "example" {
#   name                = "test"
#   location            = "${azurerm_resource_group.example.location}"
#   resource_group_name = "${azurerm_resource_group.example.name}"
#   allocation_method   = "Static"
#   domain_name_label   = "${azurerm_resource_group.example.name}"

#   tags = {
#     environment = "staging"
#   }
# }

# resource "azurerm_lb" "example" {
#   name                = "test"
#   location            = "${azurerm_resource_group.example.location}"
#   resource_group_name = "${azurerm_resource_group.example.name}"

#   frontend_ip_configuration {
#     name                 = "PublicIPAddress"
#     public_ip_address_id = "${azurerm_public_ip.example.id}"
#   }
# }

# resource "azurerm_lb_backend_address_pool" "bpepool" {
#   resource_group_name = "${azurerm_resource_group.example.name}"
#   loadbalancer_id     = "${azurerm_lb.example.id}"
#   name                = "BackEndAddressPool"
# }

# resource "azurerm_lb_nat_pool" "lbnatpool" {
#   resource_group_name            = "${azurerm_resource_group.example.name}"
#   name                           = "ssh"
#   loadbalancer_id                = "${azurerm_lb.example.id}"
#   protocol                       = "Tcp"
#   frontend_port_start            = 50000
#   frontend_port_end              = 50119
#   backend_port                   = 22
#   frontend_ip_configuration_name = "PublicIPAddress"
# }

# resource "azurerm_lb_probe" "example" {
#   resource_group_name = "${azurerm_resource_group.example.name}"
#   loadbalancer_id     = "${azurerm_lb.example.id}"
#   name                = "http-probe"
#   protocol            = "Http"
#   request_path        = "/health"
#   port                = 8080
# }

# resource "azurerm_virtual_machine_scale_set" "example" {
#   name                = "mytestscaleset-1"
#   location            = "${azurerm_resource_group.example.location}"
#   resource_group_name = "${azurerm_resource_group.example.name}"

#   # automatic rolling upgrade
#   automatic_os_upgrade = true
#   upgrade_policy_mode  = "Rolling"

#   rolling_upgrade_policy {
#     max_batch_instance_percent              = 20
#     max_unhealthy_instance_percent          = 20
#     max_unhealthy_upgraded_instance_percent = 5
#     pause_time_between_batches              = "PT0S"
#   }

#   # required when using rolling upgrade policy
#   health_probe_id = "${azurerm_lb_probe.example.id}"

#   sku {
#     name     = "Standard_F2"
#     tier     = "Standard"
#     capacity = 2
#   }

#   storage_profile_image_reference {
#     publisher = "Canonical"
#     offer     = "UbuntuServer"
#     sku       = "16.04-LTS"
#     version   = "latest"
#   }

#   storage_profile_os_disk {
#     name              = ""
#     caching           = "ReadWrite"
#     create_option     = "FromImage"
#     managed_disk_type = "Standard_LRS"
#   }

#   storage_profile_data_disk {
#     lun           = 0
#     caching       = "ReadWrite"
#     create_option = "Empty"
#     disk_size_gb  = 10
#   }

#   os_profile {
#     computer_name_prefix = "testvm"
#     admin_username       = "myadmin"
#   }

#   os_profile_linux_config {
#     disable_password_authentication = true

#     ssh_keys {
#       path     = "/home/myadmin/.ssh/authorized_keys"
#       key_data = "${file("~/.ssh/demo_key.pub")}"
#     }
#   }

#   network_profile {
#     name    = "terraformnetworkprofile"
#     primary = true

#     ip_configuration {
#       name                                   = "TestIPConfiguration"
#       primary                                = true
#       subnet_id                              = "${azurerm_subnet.example.id}"
#       load_balancer_backend_address_pool_ids = ["${azurerm_lb_backend_address_pool.bpepool.id}"]
#       load_balancer_inbound_nat_rules_ids    = ["${azurerm_lb_nat_pool.lbnatpool.id}"]
#     }
#   }

#   tags = {
#     environment = "staging"
#   }
# }
