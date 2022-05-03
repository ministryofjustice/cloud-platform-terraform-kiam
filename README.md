# cloud-platform-terraform-kiam

<a href="https://github.com/ministryofjustice/cloud-platform-terraform-kiam/releases">
  <img src="https://img.shields.io/github/release/ministryofjustice/cloud-platform-terraform-kiam/all.svg" alt="Releases" />
</a>

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


## Note

"live-1-kiam" branch for kops cluster. The "main" branch stores the releases for EKS, and the "live-1-kiam" serves as a kops cluster features branch, which was used for "live-1" cluster.