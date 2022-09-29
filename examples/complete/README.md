<!-- BEGIN_TF_DOCS -->
# Set Rule Example

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example will create resources. Resources can be destroyed with `terraform destroy`.

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
<!-- END_TF_DOCS -->