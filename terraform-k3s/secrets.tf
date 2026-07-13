# Lufthansa API credentials  ================================================
resource "kubernetes_secret" "lufth_credentials" {
  metadata {
    name      = "lufth-credentials"
    namespace = kubernetes_namespace.flight_project.metadata[0].name
  }

  data = {
    Lufth_client_id     = var.lufth_client_id
    Lufth_client_secret = var.lufth_client_secret
    Lufth_grant_type    = var.lufth_grant_type
  }
}

# Api key for Auth API  ================================================
resource "kubernetes_secret" "auth_api" {
  metadata {
    name      = "auth-api"
    namespace = kubernetes_namespace.flight_project.metadata[0].name
  }

  data = {
    API_KEY = var.auth_api_key
  }
}

# GitLab registry  ================================================
resource "kubernetes_secret" "gitlab_registry" {
  metadata {
    name      = "gitlab-registry"
    namespace = kubernetes_namespace.flight_project.metadata[0].name
  }

  type = "kubernetes.io/dockerconfigjson"

  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        "registry.gitlab.com" = {
          username = var.gitlab_registry_user
          password = var.gitlab_registry_token
          auth     = base64encode("${var.gitlab_registry_user}:${var.gitlab_registry_token}")
        }
      }
    })
  }
}
