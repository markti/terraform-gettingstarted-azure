resource "azurerm_virtual_network" "vnet" {

	name = "${var.resource_group_name}-vnet"
	address_space = ["10.0.0.0/16"]
	location = "${var.location}"
	resource_group_name = "${var.resource_group_name}"
}

resource "azurerm_subnet" "my-subnet" {
	name                 = "my-subnet"
	virtual_network_name = "${azurerm_virtual_network.vnet.name}"
	resource_group_name  = "${var.resource_group_name}"
	address_prefix       = "10.0.0.0/24"
}