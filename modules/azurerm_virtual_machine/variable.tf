variable "vms" {
  type = map(object({
    name          = string
    location      = string
    resource_group_name = string
    vm_size       = string

    nic_id        = string

    image = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })

    os_disk_name     = string
    os_disk_caching  = string
    os_disk_type     = string

    computer_name                    = string
    admin_username                   = string
    admin_password                   = string
    disable_password_authentication  = bool

   
  }))
}

variable "nic_ids" {
type = map(string)
}