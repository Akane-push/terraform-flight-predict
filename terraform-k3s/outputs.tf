output "namespace" {
  description = "Kubernetes namespace created"
  value       = kubernetes_namespace.flight_project.metadata[0].name
}

output "lufth_secret_name" {
  description = "Name of the Lufthansa credentials secret"
  value       = kubernetes_secret.lufth_credentials.metadata[0].name
}

output "gitlab_registry_secret_name" {
  description = "Name of the GitLab registry secret"
  value       = kubernetes_secret.gitlab_registry.metadata[0].name
}