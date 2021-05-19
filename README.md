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

<!--- BEGIN_TF_DOCS --->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| helm | n/a |
| kubernetes | n/a |
| null | n/a |

## Modules

No Modules.

## Resources

| Name |
|------|
| [helm_release](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) |
| [kubernetes_namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) |
| [null_resource](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) |

## Inputs

No input.

## Outputs

| Name | Description |
|------|-------------|
| helm\_kiam\_status | n/a |

<!--- END_TF_DOCS --->

## Reading Material

Click [here](https://github.com/uswitch/kiam#overview) for the official kiam documentation.
