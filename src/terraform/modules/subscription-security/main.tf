locals {
  defender_types = [
    "AppServices",
    "ContainerRegistry",
    "KeyVaults",
    "KubernetesService",
    "SqlServers",
    "SqlServerVirtualMachines",
    "StorageAccounts",
    "VirtualMachines",
    "Arm",
    "Dns",
    "OpenSourceRelationalDatabases",
    "Containers",
    "CloudPosture"
  ]
}

# Set Subscription RBAC
resource "azurerm_role_assignment" "sub_owner" {
  for_each             = toset(var.sub_owners)
  scope                = var.sub_id
  role_definition_name = "Owner"
  principal_id         = each.value
}

# Enable Security Email Alerts

resource "azurerm_security_center_contact" "security_contact" {
  email               = var.security_contact_email
  alert_notifications = true
  alerts_to_admins    = true
}

# Enable Audited Defender Solutions
# JC Note: Ignore tier change to allow customers to upgrade, but not remove.

resource "azurerm_security_center_subscription_pricing" "defender" {
  for_each      = toset(local.defender_types)
  tier          = var.defender_tier
  resource_type = each.value
  lifecycle {
    ignore_changes = [
      tier
    ]
  }
}

# Enable Log Analytics Agent Auto-provisioning
# JC Note: This has been deprecated. Removing.

# resource "azurerm_security_center_auto_provisioning" "laws_agent" {
#   auto_provision = var.laws_agent
# }
