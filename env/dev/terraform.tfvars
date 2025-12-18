rgs = {
  rg1 = {
    name     = "ltminfra"
    location = "Centralindia"
} }

stgs = {
  stg1 = {
    name                     = "ltminfrastorage890"
    resource_group_name      = "ltminfra"
    location                 = "centralindia"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }
}

containers = {
  container1 = {
    name                  = "ltimindtree098"
    storage_account_id    = "stg1"
    container_access_type = "private"
  }
}

vnets = {
  vnet1 = {
    name                = "vnetvm"
    address_space       = ["10.0.0.0/16"]
    location            = "Centralindia"
    resource_group_name = "ltminfra"
  }
}
subnets = {
  subnet1 = {
    name                 = "frontedsubnet"
    resource_group_name  = "ltminfra"
    virtual_network_name = "vnetvm"
    address_prefixes     = ["10.0.1.0/24"]
  }
  subnet2 = {
    name                 = "backnedsubnet"
    resource_group_name  = "ltminfra"
    virtual_network_name = "vnetvm"
    address_prefixes     = ["10.0.2.0/24"]
  }
  subnet3 = {
    name                 = "azurebastion"
    resource_group_name  = "ltminfra"
    virtual_network_name = "vnetvm"
    address_prefixes     = ["10.0.3.0/24"]
  }
}

nsgs = {
  nsg1 = {
    name                = "frontednsg"
    location            = "Centralindia"
    resource_group_name = "ltminfra"

    security_rules = {
      rules1 = {
        name                       = "fronted-subnet-rules"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    }
  }

  nsg2 = {
    name                = "backnednsg"
    location            = "Centralindia"
    resource_group_name = "ltminfra"

    security_rules = {
      rules1 = {
        name                       = "backned-subnet-rules"
        priority                   = 200
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    }
  }
}

associations = {
  association1 = {
    subnet_id                 = "subnet1"
    network_security_group_id = "nsg1"
  }
  association2 = {
    subnet_id                 = "subnet2"
    network_security_group_id = "nsg2"
  }
}

nics = {
  nic1 = {
    name                = "fronted-nic"
    location            = "Centralindia"
    resource_group_name = "ltminfra"
    ip_configurations = {
      ip_configuration1 = {
        name                          = "internal"
        subnet_id                     = "subnet1"
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = "pip1"
      }
    }
  }
  nic2 = {
    name                = "backned-nic"
    location            = "Centralindia"
    resource_group_name = "ltminfra"
    ip_configurations = {
      ip_configuration2 = {
        name                          = "internal2"
        subnet_id                     = "subnet2"
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = "pip2"
      }
    }
  }
}

pips = {
  pip1 = {
    name                = "fronted-pip"
    location            = "Centralindia"
    resource_group_name = "ltminfra"
    allocation_method   = "Static"
  }
  pip2 = {
    name                = "backned-pip"
    location            = "Centralindia"
    resource_group_name = "ltminfra"
    allocation_method   = "Static"
  }
}

vms = {
  vm1 = {
    name                = "vm1"
    location            = "Centralindia"
    resource_group_name = "ltminfra"
    vm_size             = "Standard_D2s_v3"

    nic_id = "nic1"

    image = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    }

    os_disk_name    = "vm1-osdisk"
    os_disk_caching = "ReadWrite"
    os_disk_type    = "Standard_LRS"

    computer_name                   = "vm1host"
    admin_username                  = "testadmin"
    admin_password                  = "Password123456"
    disable_password_authentication = false
  }


  vm2 = {
    name                = "vm2"
    location            = "Centralindia"
    resource_group_name = "ltminfra"
    vm_size             = "Standard_D2s_v3"

    nic_id = "nic2"

    image = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    }

    os_disk_name    = "vm2-osdisk"
    os_disk_caching = "ReadWrite"
    os_disk_type    = "Standard_LRS"

    computer_name                   = "vm2host"
    admin_username                  = "testadmin"
    admin_password                  = "Password12345"
    disable_password_authentication = false
  }
}


