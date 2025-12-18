resource "azurerm_public_ip" "pip" {
for_each = var.pips
name = each.value.name
location = each.value.location
resource_group_name = each.value.resource_group_name
allocation_method = each.value.allocation_method
}

variable "pips" {
type = map(object({
  name = string
  location = string
  resource_group_name = string
  allocation_method = string
}))
  
}

output "pip_ids" {
value = {
for name, p in azurerm_public_ip.pip: name => p.id
}
  
}













# resource "azurerm_public_ip" "example" {
#   name                = "acceptanceTestPublicIp1"
#   location            = "West US"
#   resource_group_name = "${azurerm_resource_group.example.name}"
#   allocation_method   = "Static"

#   tags = {
#     environment = "Production"
#   }
# }