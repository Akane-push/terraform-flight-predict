# Kubernetes  ================================================
variable "kubeconfig_path" {
  description = "Path to kubeconfig file retrieved from K3s server"
  type        = string
  default     = "./kubeconfig.yaml"
}

variable "namespace" {
  description = "Kubernetes namespace for the project"
  type        = string
  default     = "flight-project"
}

# Images  ================================================
variable "image_tag" {
  description = "Docker image tag to deploy"
  type        = string
  default     = "latest"
}

variable "image_registry" {
  description = "Docker image registry"
  type        = string
  default     = "registry.gitlab.com/akane-push/flight-predict"
}

# Secrets  ================================================
variable "lufth_client_id" {
  description = "Lufthansa API client ID"
  type        = string
  sensitive   = true
}

variable "lufth_client_secret" {
  description = "Lufthansa API client secret"
  type        = string
  sensitive   = true
}

variable "lufth_grant_type" {
  description = "Lufthansa API grant type"
  type        = string
  sensitive   = true
}

variable "auth_api_key" {
  description = "API key for auth-api secret"
  type        = string
  sensitive   = true
}

variable "gitlab_registry_user" {
  description = "GitLab registry username"
  type        = string
  sensitive   = true
}

variable "gitlab_registry_token" {
  description = "GitLab registry token"
  type        = string
  sensitive   = true
}

# Helm charts  ================================================
variable "airflow_chart_version" {
  description = "Airflow Helm chart version"
  type        = string
  default     = "1.21.0"
}

# Storage  ================================================
variable "k3s_node_name" {
  description = "K3s node name for PersistentVolume"
  type        = string
}

variable "k3s_host_path" {
  description = "Host path on K3s node for PersistentVolume"
  type        = string
  default     = "/home/ubuntu/flight-predict/Datas"
}
