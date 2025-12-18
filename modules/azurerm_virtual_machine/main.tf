resource "azurerm_virtual_machine" "vm" {
  for_each = var.vms

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  network_interface_ids = [var.nic_ids[each.value.nic_id]
  ]

  vm_size = each.value.vm_size

  storage_image_reference {
    publisher = each.value.image.publisher
    offer     = each.value.image.offer
    sku       = each.value.image.sku
    version   = each.value.image.version
  }

  storage_os_disk {
    name              = each.value.os_disk_name
    caching           = each.value.os_disk_caching
    create_option     = "FromImage"
    managed_disk_type = each.value.os_disk_type
  }

  os_profile {
    computer_name  = each.value.computer_name
    admin_username = each.value.admin_username
    admin_password = each.value.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = each.value.disable_password_authentication
  } 
}
