output "id" {
  value       = azurerm_container_group.main.id
  description = "Azure container instance group ID"
}

output "resource" {
  description = "Resource output."
  value       = azurerm_container_group.main
}

output "module_diagnostics" {
  description = "Diagnostics Settings output."
  value       = module.diagnostics
}

output "name" {
  value       = local.aci_name
  description = "Azure container instance group name"
}

output "ip_address" {
  value       = azurerm_container_group.main.ip_address
  description = "The IP address allocated to the container instance group."
}

output "fqdn" {
  value       = azurerm_container_group.main.fqdn
  description = "The FQDN of the container group derived from `dns_name_label`."
}

output "identity_principal_id" {
  description = "ACI identity principal ID."
  value       = one(azurerm_container_group.main.identity[*].principal_id)
}
