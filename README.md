<!-- BEGIN_TF_DOCS -->
[![Tests](https://github.com/netascode/terraform-aci-set-rule/actions/workflows/test.yml/badge.svg)](https://github.com/netascode/terraform-aci-set-rule/actions/workflows/test.yml)

# Terraform ACI Set Rule Module

Manages ACI Set Rule

Location in GUI:
`Tenants` » `XXX` » `Policies` » `Protocol` » `Set Rules`

## Examples

```hcl
module "aci_set_rule" {
  source  = "netascode/set-rule/aci"
  version = ">= 0.1.0"

  tenant         = "ABC"
  name           = "SR1"
  description    = "My Description"
  community      = "no-export"
  community_mode = "replace"
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aci"></a> [aci](#requirement\_aci) | >= 2.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aci"></a> [aci](#provider\_aci) | >= 2.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_tenant"></a> [tenant](#input\_tenant) | Tenant name. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Set rule name. | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | Description. | `string` | `""` | no |
| <a name="input_community"></a> [community](#input\_community) | Community. | `string` | `""` | no |
| <a name="input_community_mode"></a> [community\_mode](#input\_community\_mode) | Community mode. Choices: `append`, `replace`. | `string` | `"append"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dn"></a> [dn](#output\_dn) | Distinguished name of `rtctrlAttrP` object. |
| <a name="output_name"></a> [name](#output\_name) | Set rule name. |

## Resources

| Name | Type |
|------|------|
| [aci_rest_managed.rtctrlAttrP](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/rest_managed) | resource |
| [aci_rest_managed.rtctrlSetComm](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/rest_managed) | resource |
<!-- END_TF_DOCS -->