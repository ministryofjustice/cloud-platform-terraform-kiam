# cloud-platform-terraform-kiam

[![Releases](https://img.shields.io/github/release/ministryofjustice/cloud-platform-terraform-template/all.svg?style=flat-square)](https://github.com/ministryofjustice/cloud-platform-terraform-kiam/releases)

Terraform module that deploy cloud-platform kiam, which runs as an agent on each node in your Kubernetes cluster and allows cluster users to associate IAM roles to Pods.

## Usage

```hcl
module "kiam" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-kiam?ref=0.0.1"

  # This module requires helm and OPA already deployed
  dependence_prometheus  = module.prometheus.helm_prometheus_operator_status
  dependence_opa         = module.opa.helm_opa_status
}

```
## Inputs

_Describe what to pass the module_
_example_:

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| dependence_prometheus               |  Prometheus Dependence variable  | string | | yes |
| dependence_opa        | OPA Dependence variable                | string   |         | yes |

## Reading Material

Click [here](https://github.com/uswitch/kiam#overview) for the official kiam documentation.