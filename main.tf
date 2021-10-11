resource "aci_rest" "rtctrlAttrP" {
  dn         = "uni/tn-${var.tenant}/attr-${var.name}"
  class_name = "rtctrlAttrP"
  content = {
    name  = var.name
    descr = var.description
  }
}

resource "aci_rest" "rtctrlSetComm" {
  count      = var.community != "" ? 1 : 0
  dn         = "${aci_rest.rtctrlAttrP.dn}/scomm"
  class_name = "rtctrlSetComm"
  content = {
    "community"   = var.community
    "setCriteria" = var.community_mode
    "type"        = "community"
  }
}
