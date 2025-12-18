resource "azurerm_storage_container" "container" {
for_each = var.containers
name = each.value.name
storage_account_id = var.storage_account_ids[each.value.storage_account_id]
container_access_type = each.value.container_access_type
  
}


variable "containers" {
type = map(object({
  name = string
  storage_account_id = string
  container_access_type = string
}))
  
}

variable "storage_account_ids" {
type = map(string)
}