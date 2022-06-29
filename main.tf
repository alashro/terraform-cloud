resource "azurerm_resource_group" "resourcegrp" {
  name     ="${terraform.workspace}-grp"
  location = local.location  
}

resource "azurerm_virtual_network" "network" {
  name                = "${terraform.workspace}-network"
  location            = local.location  
  resource_group_name = azurerm_resource_group.resourcegrp.name
  address_space       = [local.virtual_network.address_space]
  depends_on = [
    azurerm_resource_group.resourcegrp
  ]  
} 


resource "azurerm_subnet" "subnet" {    
    name                 = "${terraform.workspace}-subnet"
    resource_group_name  = azurerm_resource_group.resourcegrp.name
    virtual_network_name = azurerm_virtual_network.network.name
    address_prefixes     = [cidrsubnet(local.virtual_network.address_space,8,0)]
    depends_on = [
      azurerm_virtual_network.network
    ]
}

