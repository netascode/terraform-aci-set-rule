output "dn" {
  value       = aci_rest.rtctrlAttrP.id
  description = "Distinguished name of `rtctrlAttrP` object."
}

output "name" {
  value       = aci_rest.rtctrlAttrP.content.name
  description = "Set rule name."
}
