module "todo_rg" {
  source = "../modules/azurerm_resourcegroup"
resource_group ="rg_444"
location ="West Europe"

}

module "todo_vnet" {
  source = "../modules/azurerm_virtual_network"
vnet-name="gmvnet1"
address_space=["10.0.0.0/21"]
location ="West Europe"
resource_group_name="rg_444"


}

module "todo_frontendsubnet" {

  source = "../modules/azurerm_subnet"
 subnet-name ="gmfrontsubnet"
address_prefixes =["10.0.1.0/24"]
virtual_network_name ="gmvnet1"
resource_group_name="rg_444"

}
module "todo_backendsubnet" {

  source = "../modules/azurerm_subnet"
 subnet-name ="gmbackendsubnet"
address_prefixes =["10.0.2.0/24"]
virtual_network_name ="gmvnet1"
resource_group_name="rg_444"

}


module "todofrontpip" {

  source = "../modules/azurerm_public_ip"

pip_name="frontend_pip"

location ="West Europe"
resource_group_name="rg_444"

}

module "todobackendpip" {

  source = "../modules/azurerm_public_ip"

pip_name="backend_pip"

location ="West Europe"
resource_group_name="rg_444"

}

module "todofrontnic" {
source = "../modules/azurerm_nic"

ipname="frontnicip"
subnet_id="/subscriptions/cebec115-76a4-41a3-b52f-1485335c2232/resourceGroups/rg_444/providers/Microsoft.Network/virtualNetworks/gmvnet1/subnets/gmfrontsubnet"
nic_name="frontnic"
location ="West Europe"
resource_group_name="rg_444"
public_ip_address_id="/subscriptions/cebec115-76a4-41a3-b52f-1485335c2232/resourceGroups/rg_444/providers/Microsoft.Network/publicIPAddresses/frontend_pip"
}

module "todobackendnic" {
source = "../modules/azurerm_nic"

ipname="backendnicip"
subnet_id="/subscriptions/cebec115-76a4-41a3-b52f-1485335c2232/resourceGroups/rg_444/providers/Microsoft.Network/virtualNetworks/gmvnet1/subnets/gmbackendsubnet"
nic_name="backendnic"
location ="West Europe"
resource_group_name="rg_444"
public_ip_address_id="/subscriptions/cebec115-76a4-41a3-b52f-1485335c2232/resourceGroups/rg_444/providers/Microsoft.Network/publicIPAddresses/backend_pip"
}


module "frontend_vm" {

source = "../modules/azurerm_virtual_machine"

vm_name="frontendvm"
vm_rg_name="rg_444"
vm_rg_location="West Europe"
vm_username="gmvmadmin01"
vm_password="Password@1222"
vm_nic_id=["/subscriptions/cebec115-76a4-41a3-b52f-1485335c2232/resourceGroups/rg_444/providers/Microsoft.Network/networkInterfaces/frontnic"]
vm_publisher="Canonical"
vm_offer="0001-com-ubuntu-server-jammy"
vm_sku="22_04-lts"
  
}

module "backend_vm" {

source = "../modules/azurerm_virtual_machine"

vm_name="backendvm"
vm_rg_name="rg_444"
vm_rg_location="West Europe"
vm_username="gmvmadmin02"
vm_password="Password@1111"
vm_nic_id=["/subscriptions/cebec115-76a4-41a3-b52f-1485335c2232/resourceGroups/rg_444/providers/Microsoft.Network/networkInterfaces/backendnic"]
vm_publisher="Canonical"
vm_offer="0001-com-ubuntu-server-jammy"
vm_sku="22_04-lts"
  
}