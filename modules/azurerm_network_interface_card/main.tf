resource "azurerm_network_interface" "nic" {
  for_each            = var.nics
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name


  dynamic "ip_configuration" {
    for_each = each.value.ip_configurations
    content {
      name                          = ip_configuration.value.name
      subnet_id                     = var.subnet_ids[ip_configuration.value.subnet_id]
      private_ip_address_allocation = ip_configuration.value.private_ip_address_allocation
      public_ip_address_id          = var.pip_ids[ip_configuration.value.public_ip_address_id]
    }
  }

}
variable "nics" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    ip_configurations = map(object({
      name                          = string
      subnet_id                     = string
      private_ip_address_allocation = string
      public_ip_address_id          = string
    }))
  }))
}
# variable "nic_ids" {
# type = map(string)
#   }
variable "subnet_ids" {
type = map(string)
}
variable "pip_ids" {
type = map(string)
}

output "nic_ids" {
value = {
for name, n in azurerm_network_interface.nic : name => n.id
}
  
}





# resource "azurerm_network_interface" "example" {
#   name                = "example-nic"
#   location            = azurerm_resource_group.example.location
#   resource_group_name = azurerm_resource_group.example.name

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = azurerm_subnet.example.id
#     private_ip_address_allocation = "Dynamic"
#   }
# }
