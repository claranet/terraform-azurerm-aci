output "id" {
  description = "Azure Container Instance ID."
  value       = azurerm_container_group.main.id
}

output "resource" {
  description = "Azure Container Instance resource object."
  value       = azurerm_container_group.main
}

output "name" {
  description = "Azure Container Instance name."
  value       = local.name
}

output "module_diagnostics" {
  description = "Diagnostics module output."
  value       = module.diagnostics
}

output "ip_address" {
  description = "The IP address allocated to the container instance group."
  value       = azurerm_container_group.main.ip_address
}

output "fqdn" {
  description = "The FQDN of the container group derived from `dns_name_label`."
  value       = azurerm_container_group.main.fqdn
}

output "identity_principal_id" {
  description = "ACI identity principal ID."
  value       = one(azurerm_container_group.main.identity[*].principal_id)
}
