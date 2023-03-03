output "address_prefixes" {
  description = "Subnet Address Prefixes"
  value       = length(var.address_space) == 0 ? jsondecode(data.azurerm_key_vault_secret.address_prefixes[0].value) : var.address_space
  sensitive   = true
}

output "nsg_rules" {
  description = "Map of subnet params from Key Vault"
  value       = { for nsg_name, nsg_secret in merge(data.azurerm_key_vault_secret.default_nsg_rules, data.azurerm_key_vault_secret.nsg_rules) : nsg_name => jsondecode(nsg_secret.value) }
  sensitive   = true
}
