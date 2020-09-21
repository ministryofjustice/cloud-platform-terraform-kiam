#############
# Namespace #
#############

resource "kubernetes_namespace" "kiam" {
  metadata {
    name = "kiam"

    labels = {
      "name"                                           = "kiam"
      "component"                                      = "kiam"
      "cloud-platform.justice.gov.uk/environment-name" = "production"
      "cloud-platform.justice.gov.uk/is-production"    = "true"
    }

    annotations = {
      "cloud-platform.justice.gov.uk/application"   = "KIAM"
      "cloud-platform.justice.gov.uk/business-unit" = "cloud-platform"
      "cloud-platform.justice.gov.uk/owner"         = "Cloud Platform: platforms@digital.justice.gov.uk"
      "cloud-platform.justice.gov.uk/source-code"   = "https://github.com/ministryofjustice/cloud-platform-infrastructure/blob/master/terraform/cloud-platform-components/kiam.tf"
      "cloud-platform.justice.gov.uk/slack-channel" = "cloud-platform"
    }
  }
}

resource "null_resource" "kube_system_kiam_annotation" {
  provisioner "local-exec" {
    command = "kubectl annotate --overwrite namespace kube-system 'iam.amazonaws.com/permitted=.*'"
  }
}

data "helm_repository" "uswitch" {
  name = "uswitch"
  url  = "https://uswitch.github.io/kiam-helm-charts/charts"
}


resource "helm_release" "kiam" {
  name          = "kiam"
  chart         = "kiam"
  repository    = data.helm_repository.uswitch.metadata[0].name
  namespace     = kubernetes_namespace.kiam.id
  recreate_pods = "true"
  version       = "5.8.1"

  values = [templatefile("${path.module}/templates/kiam.yaml", {
    kiam_version = "v3.5"
  })]

  depends_on = [
    var.dependence_prometheus,
    var.dependence_opa
  ]
}
