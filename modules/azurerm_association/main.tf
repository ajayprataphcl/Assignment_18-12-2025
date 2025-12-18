resource "azurerm_subnet_network_security_group_association" "association" {
for_each = var.associations
subnet_id = var.subnet_ids[each.value.subnet_id]
network_security_group_id = var.nsg_ids[each.value.network_security_group_id]
}


variable "associations" {
type = map(object({
  subnet_id = string
  network_security_group_id = string
}))
  }

variable "subnet_ids" {
type = map(string)
  
}

variable "nsg_ids" {
type = map(string)
  
}
