terraform {
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }

    aci = {
      source  = "netascode/aci"
      version = ">=0.2.0"
    }
  }
}

resource "aci_rest" "fvTenant" {
  dn         = "uni/tn-TF"
  class_name = "fvTenant"
}

module "main" {
  source = "../.."

  tenant         = aci_rest.fvTenant.content.name
  name           = "SR1"
  description    = "My Description"
  community      = "no-export"
  community_mode = "replace"
}

data "aci_rest" "rtctrlAttrP" {
  dn = module.main.dn

  depends_on = [module.main]
}

resource "test_assertions" "rtctrlAttrP" {
  component = "rtctrlAttrP"

  equal "name" {
    description = "name"
    got         = data.aci_rest.rtctrlAttrP.content.name
    want        = module.main.name
  }

  equal "descr" {
    description = "descr"
    got         = data.aci_rest.rtctrlAttrP.content.descr
    want        = "My Description"
  }
}

data "aci_rest" "rtctrlSetComm" {
  dn = "${data.aci_rest.rtctrlAttrP.id}/scomm"

  depends_on = [module.main]
}

resource "test_assertions" "rtctrlSetComm" {
  component = "rtctrlSetComm"

  equal "community" {
    description = "community"
    got         = data.aci_rest.rtctrlSetComm.content.community
    want        = "no-export"
  }

  equal "setCriteria" {
    description = "setCriteria"
    got         = data.aci_rest.rtctrlSetComm.content.setCriteria
    want        = "replace"
  }

  equal "type" {
    description = "type"
    got         = data.aci_rest.rtctrlSetComm.content.type
    want        = "community"
  }
}
