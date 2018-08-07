locals {
  my_vm_name = "${var.prefix}MyVM"
}

resource "azurerm_public_ip" "my_ip" {
  name                         = "${local.my_vm_name}-ppip"
  location                     = "${var.location}"
  resource_group_name          = "${var.resource_group_name}"
  public_ip_address_allocation = "static"
}

resource "azurerm_network_interface" "my_nic" {
	name                    = "${local.my_vm_name}-nic"
	location                = "${var.location}"
	resource_group_name     = "${var.resource_group_name}"
	internal_dns_name_label = "${local.my_vm_name}"

	ip_configuration {
		name                          = "primary"
		subnet_id                     = "${var.subnet_id}"
		private_ip_address_allocation = "dynamic"
		public_ip_address_id          = "${azurerm_public_ip.my_ip.id}"
	}
}