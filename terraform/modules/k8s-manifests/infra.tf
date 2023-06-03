#AWS-ebs-csi-driver
resource "helm_release" "aws-ebs-csi-driver" {
  name       = "aws-ebs-csi-driver"
  namespace  = "kube-system"
  repository = "https://kubernetes-sigs.github.io/aws-ebs-csi-driver"
  chart      = "aws-ebs-csi-driver"
  version    = "2.16.0"
}


#Metrics server 
resource "helm_release" "metric-server" {
  name       = "metric-server"
  namespace  = "kube-system"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "metrics-server"
  version    = "6.2.9"

  set {
    name  = "apiService.create"
    value = "true"
  }
}

resource "helm_release" "autoscaler" {
  name       = "cluster-autoscaler"
  namespace  = "kube-system"
  repository = "https://kubernetes.github.io/autoscaler"
  chart      = "cluster-autoscaler"
  version    = "9.24.0"
values = [
     "${file("~/dataloop-k8s/terraform/modules/k8s-manifests/charts/cluster-autoscaler/values.yaml")}"
   ]
}

