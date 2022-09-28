terraform {
  required_version = ">= 1.0.0"

  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }

    aci = {
      source  = "CiscoDevNet/aci"
      version = ">=2.0.0"
    }
  }
}

resource "aci_rest_managed" "fvTenant" {
  dn         = "uni/tn-TF"
  class_name = "fvTenant"
}

module "main" {
  source = "../.."

  tenant         = aci_rest_managed.fvTenant.content.name
  name           = "SR1"
  description    = "My Description"
  community      = "no-export"
  community_mode = "replace"
}

data "aci_rest_managed" "rtctrlAttrP" {
  dn = module.main.dn

  depends_on = [module.main]
}

resource "test_assertions" "rtctrlAttrP" {
  component = "rtctrlAttrP"

  equal "name" {
    description = "name"
    got         = data.aci_rest_managed.rtctrlAttrP.content.name
    want        = module.main.name
  }

  equal "descr" {
    description = "descr"
    got         = data.aci_rest_managed.rtctrlAttrP.content.descr
    want        = "My Description"
  }
}

data "aci_rest_managed" "rtctrlSetComm" {
  dn = "${data.aci_rest_managed.rtctrlAttrP.id}/scomm"

  depends_on = [module.main]
}

resource "test_assertions" "rtctrlSetComm" {
  component = "rtctrlSetComm"

  equal "community" {
    description = "community"
    got         = data.aci_rest_managed.rtctrlSetComm.content.community
    want        = "no-export"
  }

  equal "setCriteria" {
    description = "setCriteria"
    got         = data.aci_rest_managed.rtctrlSetComm.content.setCriteria
    want        = "replace"
  }

  equal "type" {
    description = "type"
    got         = data.aci_rest_managed.rtctrlSetComm.content.type
    want        = "community"
  }
}
