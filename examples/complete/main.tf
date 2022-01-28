module "aci_set_rule" {
  source  = "netascode/set-rule/aci"
  version = ">= 0.1.0"

  tenant         = "ABC"
  name           = "SR1"
  description    = "My Description"
  community      = "no-export"
  community_mode = "replace"
}
