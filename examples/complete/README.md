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
  version = ">= 0.0.1"

  tenant         = "ABC"
  name           = "SR1"
  description    = "My Description"
  community      = "no-export"
  community_mode = "replace"
}

```
<!-- END_TF_DOCS -->