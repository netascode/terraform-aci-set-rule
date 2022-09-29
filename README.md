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
  dampening = {
    half_life         = 15
    max_suppress_time = 60
    reuse_limit       = 750
    suppress_limit    = 2000
  }
  weight      = 100
  next_hop    = "1.1.1.1"
  metric      = 1
  preference  = 1
  metric_type = "ospf-type1"
  additional_communities = [
    {
      community   = "regular:as2-nn2:4:15"
      description = "My Community"
    }
  ]
  set_as_path = {
    criteria = "prepend"
    count    = 0
    asn      = 65001
    order    = 5
  }
  next_hop_propagation = true
  multipath            = true
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
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
| <a name="input_tag"></a> [tag](#input\_tag) | Tag | `number` | `null` | no |
| <a name="input_dampening"></a> [dampening](#input\_dampening) | Dampening | <pre>object({<br>    half_life         = optional(number, 15)<br>    max_suppress_time = optional(number, 60)<br>    reuse_limit       = optional(number, 750)<br>    suppress_limit    = optional(number, 2000)<br>  })</pre> | `{}` | no |
| <a name="input_weight"></a> [weight](#input\_weight) | Weight | `number` | `null` | no |
| <a name="input_next_hop"></a> [next\_hop](#input\_next\_hop) | Next Hop | `string` | `""` | no |
| <a name="input_preference"></a> [preference](#input\_preference) | Preference | `number` | `null` | no |
| <a name="input_metric"></a> [metric](#input\_metric) | Metric | `number` | `null` | no |
| <a name="input_metric_type"></a> [metric\_type](#input\_metric\_type) | Metric Type | `string` | `""` | no |
| <a name="input_additional_communities"></a> [additional\_communities](#input\_additional\_communities) | Additional communities | <pre>list(object({<br>    community   = string<br>    description = optional(string, "")<br>  }))</pre> | `[]` | no |
| <a name="input_set_as_path"></a> [set\_as\_path](#input\_set\_as\_path) | AS-Path Set | <pre>object({<br>    criteria = optional(string, "prepend")<br>    count    = optional(number, 0)<br>    asn      = optional(number, 0)<br>    order    = optional(number, 0)<br>  })</pre> | `{}` | no |
| <a name="input_next_hop_propagation"></a> [next\_hop\_propagation](#input\_next\_hop\_propagation) | Next Hop Propagation | `bool` | `false` | no |
| <a name="input_multipath"></a> [multipath](#input\_multipath) | Multipath | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dn"></a> [dn](#output\_dn) | Distinguished name of `rtctrlAttrP` object. |
| <a name="output_name"></a> [name](#output\_name) | Set rule name. |

## Resources

| Name | Type |
|------|------|
| [aci_rest_managed.rtctrlAttrP](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/rest_managed) | resource |
| [aci_rest_managed.rtctrlSetASPath](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/rest_managed) | resource |
| [aci_rest_managed.rtctrlSetASPathASN](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/rest_managed) | resource |
| [aci_rest_managed.rtctrlSetAddComm](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/rest_managed) | resource |
| [aci_rest_managed.rtctrlSetComm](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/rest_managed) | resource |
| [aci_rest_managed.rtctrlSetDamp](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/rest_managed) | resource |
| [aci_rest_managed.rtctrlSetNh](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/rest_managed) | resource |
| [aci_rest_managed.rtctrlSetNhUnchanged](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/rest_managed) | resource |
| [aci_rest_managed.rtctrlSetPref](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/rest_managed) | resource |
| [aci_rest_managed.rtctrlSetRedistMultipath](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/rest_managed) | resource |
| [aci_rest_managed.rtctrlSetRtMetric](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/rest_managed) | resource |
| [aci_rest_managed.rtctrlSetRtMetricType](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/rest_managed) | resource |
| [aci_rest_managed.rtctrlSetTag](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/rest_managed) | resource |
| [aci_rest_managed.rtctrlSetWeight](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/rest_managed) | resource |
<!-- END_TF_DOCS -->