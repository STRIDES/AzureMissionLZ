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

# VNet Flowlogs

resource "azurerm_network_watcher_flow_log" "vnetfl" {

  name                 = "${trim(substr(azurerm_virtual_network.vnet.name, 0, 70), "-_")}-flow-log"
  location             = var.location
  network_watcher_name = "NetworkWatcher_${replace(var.location, " ", "")}"
  resource_group_name  = "NetworkWatcherRG"

  target_resource_id = sensitive(azurerm_virtual_network.vnet.id)
  storage_account_id = var.flow_log_storage_id
  enabled            = true
  version            = 2

  retention_policy {
    enabled = true
    days    = var.flow_log_retention_in_days
  }

  traffic_analytics {
    enabled               = true
    workspace_id          = var.log_analytics_workspace_id
    workspace_region      = var.log_analytics_workspace_location
    workspace_resource_id = var.log_analytics_workspace_resource_id
    interval_in_minutes   = 10
  }
  tags = var.tags
  lifecycle {
    ignore_changes = [
      name
    ]
  }
}
