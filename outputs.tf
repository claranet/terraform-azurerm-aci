output "aci_id" {
  value       = azurerm_container_group.aci.id
  description = "Azure container instance group ID"
}

output "aci_ip_address" {
  value       = azurerm_container_group.aci.ip_address
  description = "The IP address allocated to the container instance group."
}

output "aci_fqdn" {
  value       = azurerm_container_group.aci.fqdn
  description = "The FQDN of the container group derived from `dns_name_label`."
}

output "aci_identity_principal_id" {
  description = "ACI identity principal ID."
  value       = try(azurerm_container_group.aci.identity[0].principal_id, null)
}
