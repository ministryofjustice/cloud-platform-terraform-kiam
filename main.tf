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
      "cloud-platform.justice.gov.uk/business-unit" = "Platforms"
      "cloud-platform.justice.gov.uk/owner"         = "Cloud Platform: platforms@digital.justice.gov.uk"
      "cloud-platform.justice.gov.uk/source-code"   = "https://github.com/ministryofjustice/cloud-platform-infrastructure/blob/master/terraform/cloud-platform-components/kiam.tf"
      "cloud-platform.justice.gov.uk/slack-channel" = "cloud-platform"
      "cloud-platform-out-of-hours-alert"           = "true"
    }
  }
}

resource "null_resource" "kube_system_kiam_annotation" {
  provisioner "local-exec" {
    command = "kubectl annotate --overwrite namespace kube-system 'iam.amazonaws.com/permitted=.*'"
  }
}

resource "helm_release" "kiam" {
  name          = "kiam"
  chart         = "kiam"
  repository    = "https://uswitch.github.io/kiam-helm-charts/charts"
  namespace     = kubernetes_namespace.kiam.id
  recreate_pods = "true"
  version       = "5.8.1"

  values = [templatefile("${path.module}/templates/kiam.yaml", {
    kiam_version = "v3.5"
  })]
}
