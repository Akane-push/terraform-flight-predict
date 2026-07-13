resource "kubernetes_namespace" "flight_project" {
  metadata {
    name = var.namespace
  }
}
