# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

variable "location" {
  description = "The location/region to keep all your network resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table'"
  type        = string
}

variable "resource_group_name" {
  description = "A container that holds related resources for an Azure solution"
  type        = string
}

variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "vnet_address_space" {
  description = "The address space to be used for the virtual network"
  type        = list(string)
  sensitive   = true
}

variable "log_analytics_workspace_resource_id" {
  description = "The resource ID of the Log Analytics Workspace to log events from the virtual network"
  type        = string
}

variable "dns_server_list" {
  description = "List of IP addresses for custom dns servers."
  type        = list(string)
  default     = []
  sensitive   = true
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "ipam_tags" {
  description = "A map of tags to be added only to the vnets for ipam."
  type        = map(string)
  default     = {}
}
