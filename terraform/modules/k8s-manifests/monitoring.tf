resource "helm_release" "prometheus" {
  name             = "prometheus"
  namespace        = "monitoring"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "prometheus"
  create_namespace = "true"
  version          = "19.4.0"
values = [
     "${file("~/dataloop-k8s/terraform/modules/k8s-manifests/charts/prometheus/values.yaml")}"
   ]
}

resource "helm_release" "grafana" {
  name       = "grafana"
  namespace  = "monitoring"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  version = "6.50.7"
values = [
     "${file("~/dataloop-k8s/terraform/modules/k8s-manifests/charts/grafana/values.yaml")}"
   ]
}

