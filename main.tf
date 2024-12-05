variable "vm_ssh_public_key_path" {
  type        = string
  default     = "~/.ssh/http-hello-world-vm.pub"
  description = "The VM opens port 22 through a public IP for SSH connections. Provide the path to an ssh key pair public key to use it for authentication."
  validation {
    condition     = fileexists(var.vm_ssh_public_key_path)
    error_message = "VM ssh public key does not exist at path vm_ssh_public_key_path."
  }
}

locals {
  vm_username = "adminuser"
}

output "vm_ssh_connection_command" {
  value = "ssh -i ${var.vm_ssh_public_key_path} ${local.vm_username}@${azurerm_linux_virtual_machine.http-hello-world-vm.public_ip_address}"
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"

  # Terraform will store and retrieve its tfstate file from here.
  backend "azurerm" {
    resource_group_name  = "shared-project-resources"
    storage_account_name = "dglstorageaccount"
    container_name       = "tfstate"
    key                  = "http-hello-world.tfstate"
    use_oidc             = true
  }
}

provider "azurerm" {
  features {}
}

# Terraform files are declarative, resources do not need to appear in any
# particular order. The resources I've put first are those I think are most
# representative of this project.

resource "azurerm_resource_group" "rg" {
  name     = "http-hello-world"
  location = "canadaeast"
}

resource "azurerm_linux_virtual_machine" "http-hello-world-vm" {
  name                = "http-hello-world-vm"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_B2als_v2"
  admin_username      = local.vm_username

  network_interface_ids = [
    azurerm_network_interface.vm-nic.id
  ]

  admin_ssh_key {
    username   = local.vm_username
    public_key = file(var.vm_ssh_public_key_path)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
}

resource "azurerm_public_ip" "vm-ip" {
  name                = "vm-ip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "vm-nic" {
  name                = "nic"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  ip_configuration {
    name                          = "nic-config"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm-ip.id
  }
}

resource "azurerm_network_security_group" "vm-nsg" {
  name                = "vm-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "vm-nic-nsg" {
  network_interface_id      = azurerm_network_interface.vm-nic.id
  network_security_group_id = azurerm_network_security_group.vm-nsg.id
}

