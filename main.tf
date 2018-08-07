provider "azurerm" 
{
	subscription_id = "${var.subscription_id}"
	client_id = "${var.client_id}"
	client_secret = "${var.client_secret}"
	tenant_id = "${var.tenant_id}"
}

locals {
  prefix = "Mark"
  resource_group = "IACLAB"
}

resource "azurerm_resource_group" "rg" {

	name = "${local.prefix}-${local.resource_group}"
	location = "Central US"

}

module "network" {

	source = 				"./modules/network"
	prefix = 				"${local.prefix}"
	resource_group_name = 	"${azurerm_resource_group.rg.name}"
	location = 				"${azurerm_resource_group.rg.location}"

}

module "vm" {

	source                        = "./modules/vm"
	prefix                        = "${local.prefix}"
	resource_group_name           = "${azurerm_resource_group.rg.name}"
	location                      = "${azurerm_resource_group.rg.location}"
	subnet_id                     = "${module.network.my_subnet_id}"
	admin_username                = "${var.admin_username}"
	admin_password                = "${var.admin_password}"
	
}