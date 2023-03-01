# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.
data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_address_space
  tags                = merge(var.tags, var.ipam_tags)
}

resource "azurerm_virtual_network_dns_servers" "custom_dns" {
  count              = length(var.dns_server_list) == 0 ? 0 : 1
  virtual_network_id = azurerm_virtual_network.vnet.id
  dns_servers        = sensitive(var.dns_server_list)
}
