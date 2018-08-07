resource "azurerm_virtual_machine" "my-vm" {

	name                          = "${local.my_vm_name}"
	location                      = "${var.location}"
	resource_group_name           = "${var.resource_group_name}"
	network_interface_ids         = ["${azurerm_network_interface.my_nic.id}"]
	vm_size                       = "Standard_A0"


	storage_image_reference {
        publisher = "MicrosoftWindowsServer"
        offer = "WindowsServer"
        sku = "2016-DataCenter"
        version = "latest"
	}

	storage_os_disk {
		name              = "${local.my_vm_name}-disk1"
		caching           = "ReadWrite"
		create_option     = "FromImage"
		managed_disk_type = "Standard_LRS"
	}

	os_profile {
		computer_name  = "${local.my_vm_name}"
		admin_username = "${var.admin_username}"
		admin_password = "${var.admin_password}"
	}

    os_profile_windows_config {
		provision_vm_agent        = true
		enable_automatic_upgrades = true
	}
}