module "rg" {
  source = "../../modules/azurerm_resource_group"
  rgs    = var.rgs
}

module "stg" {
  depends_on = [module.rg]
  source     = "../../modules/azurerm_storage_account"
  stgs       = var.stgs
}

module "container" {
  depends_on          = [module.stg]
  source              = "../../modules/azurerm_container"
  containers          = var.containers
  storage_account_ids = module.stg.stgs
}

module "vnet" {
  depends_on = [module.rg]
  source     = "../../modules/azurerm_virtual_network"
  vnets      = var.vnets

}

module "subnet" {
  depends_on = [module.vnet]
  source     = "../../modules/azurerm_subnet"
  subnets    = var.subnets
}

module "nsg" {
  depends_on = [module.vnet, module.vnet]
  source     = "../../modules/azurerm_network_security_group"
  nsgs       = var.nsgs
}

module "association" {
  depends_on   = [module.subnet, module.nsg]
  source       = "../../modules/azurerm_association"
  associations = var.associations
  subnet_ids   = module.subnet.subnet_ids
  nsg_ids      = module.nsg.nsg_ids
}

module "nic" {
  depends_on = [module.subnet, module.pip, module.nsg]
  source     = "../../modules/azurerm_network_interface_card"
  nics       = var.nics
  pip_ids    = module.pip.pip_ids
  subnet_ids = module.subnet.subnet_ids
}

module "pip" {
  depends_on = [module.rg]
  source     = "../../modules/azurerm_public_ip"
  pips       = var.pips
}

module "vm" {
  depends_on = [module.rg,module.nic]
  source     = "../../modules/azurerm_virtual_machine"
  vms        = var.vms
  nic_ids    = module.nic.nic_ids

}


