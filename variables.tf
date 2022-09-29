variable "tenant" {
  description = "Tenant name."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9_.-]{0,64}$", var.tenant))
    error_message = "Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `_`, `.`, `-`. Maximum characters: 64."
  }
}

variable "name" {
  description = "Set rule name."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9_.-]{0,64}$", var.name))
    error_message = "Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `_`, `.`, `-`. Maximum characters: 64."
  }
}

variable "description" {
  description = "Description."
  type        = string
  default     = ""

  validation {
    condition     = can(regex("^[a-zA-Z0-9\\!#$%()*,-./:;@ _{|}~?&+]{0,128}$", var.description))
    error_message = "Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `\\`, `!`, `#`, `$`, `%`, `(`, `)`, `*`, `,`, `-`, `.`, `/`, `:`, `;`, `@`, ` `, `_`, `{`, `|`, }`, `~`, `?`, `&`, `+`. Maximum characters: 128."
  }
}

variable "community" {
  description = "Community."
  type        = string
  default     = ""
}

variable "community_mode" {
  description = "Community mode. Choices: `append`, `replace`."
  type        = string
  default     = "append"

  validation {
    condition     = contains(["append", "replace"], var.community_mode)
    error_message = "Allowed values are `append` or `replace`."
  }
}


variable "tag" {
  description = "Tag"
  type        = number
  default     = null

  validation {
    condition     = coalesce(var.tag, 0) >= 0 && coalesce(var.tag, 4294967295) <= 4294967295
    error_message = "Minimum value: `0`. Maximum value: `4294967295`."
  }
}

variable "dampening" {
  description = "Dampening"
  type = object({
    half_life         = optional(number, 15)
    max_suppress_time = optional(number, 60)
    reuse_limit       = optional(number, 750)
    suppress_limit    = optional(number, 2000)
  })
  default = {}

  validation {
    condition     = lookup(var.dampening, "half_life", 1) >= 1 && lookup(var.dampening, "half_life", 1) <= 60
    error_message = "`half_life` minimum value: `1`. Maximum value: `60`."
  }

  validation {
    condition     = lookup(var.dampening, "max_suppress_time", 1) >= 1 && lookup(var.dampening, "max_suppress_time", 1) <= 255
    error_message = "`max_suppress_time` minimum value: `1`. Maximum value: `255`."
  }

  validation {
    condition     = lookup(var.dampening, "reuse_limit", 1) >= 1 && lookup(var.dampening, "reuse_limit", 1) <= 2000
    error_message = "`reuse_limit` minimum value: `1`. Maximum value: `2000`."
  }

  validation {
    condition     = lookup(var.dampening, "suppress_limit", 1) >= 1 && lookup(var.dampening, "suppress_limit", 1) <= 2000
    error_message = "`suppress_limit` minimum value: `1`. Maximum value: `2000`."
  }
}

variable "weight" {
  description = "Weight"
  type        = number
  default     = null

  validation {
    condition     = coalesce(var.weight, 0) >= 0 && coalesce(var.weight, 65535) <= 65535
    error_message = "Minimum value: `0`. Maximum value: `65535`."
  }
}


variable "next_hop" {
  description = "Next Hop"
  type        = string
  default     = ""

}

variable "preference" {
  description = "Preference"
  type        = number
  default     = null

  validation {
    condition     = coalesce(var.preference, 0) >= 0 && coalesce(var.preference, 65535) <= 65535
    error_message = "Minimum value: `0`. Maximum value: `4294967295`."
  }
}

variable "metric" {
  description = "Metric"
  type        = number
  default     = null

  validation {
    condition     = coalesce(var.metric, 0) >= 0 && coalesce(var.metric, 65535) <= 65535
    error_message = "Minimum value: `0`. Maximum value: `4294967295`."
  }
}

variable "metric_type" {
  description = "Metric Type"
  type        = string
  default     = ""

  validation {
    condition     = contains(["ospf-type1", "ospf-type2", ""], var.metric_type)
    error_message = "Valid values are `ospf-type1` or `ospf-type2`."
  }
}


variable "additional_communities" {
  description = "Additional communities"
  type = list(object({
    community   = string
    description = optional(string, "")
  }))
  default = []

  validation {
    condition = alltrue([
      for c in var.additional_communities : c.description == null || can(regex("^[a-zA-Z0-9\\!#$%()*,-./:;@ _{|}~?&+]{0,128}$", c.description))
    ])
    error_message = "`description`: Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `\\`, `!`, `#`, `$`, `%`, `(`, `)`, `*`, `,`, `-`, `.`, `/`, `:`, `;`, `@`, ` `, `_`, `{`, `|`, }`, `~`, `?`, `&`, `+`. Maximum characters: 128."
  }
}

variable "set_as_path" {
  description = "AS-Path Set"
  type = object({
    criteria = optional(string, "prepend")
    count    = optional(number, 0)
    asn      = optional(number, 0)
    order    = optional(number, 0)
  })
  default = {}


  validation {
    condition     = contains(["prepend", "prepend-last-as"], lookup(var.set_as_path, "criteria", "prepend"))
    error_message = "Valid values for `criteria` are `prepend` or `prepend-last-as`."
  }

  validation {
    condition     = lookup(var.set_as_path, "count", 0) >= 0 && lookup(var.set_as_path, "half_life", 10) <= 10
    error_message = "`count` minimum value: `0`. Maximum value: `10`."
  }

  validation {
    condition     = lookup(var.set_as_path, "asn", 0) >= 0 && lookup(var.set_as_path, "asn", 65535) <= 65535
    error_message = "`asn` minimum value: `0`. Maximum value: `65535`."
  }

  validation {
    condition     = lookup(var.set_as_path, "order", 0) >= 0 && lookup(var.set_as_path, "order", 31) <= 31
    error_message = "`order` minimum value: `0`. Maximum value: `31`."
  }
}

variable "next_hop_propagation" {
  description = "Next Hop Propagation"
  type        = bool
  default     = false
}

variable "multipath" {
  description = "Multipath"
  type        = bool
  default     = false
}