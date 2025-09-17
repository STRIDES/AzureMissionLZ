variable "sub_id" {
  description = "ID of the Subscription"
  type        = string
  default     = null
  sensitive   = true
}

variable "sub_owners" {
  description = "List of Subscription Owner Principal IDs."
  type        = list(string)
  default     = []
}

variable "security_contact_email" {
  description = "Email address to send security notifications to."
  type        = string
  default     = "citcloudservicesazurealerts@mail.nih.gov"
}

variable "security_contact_name" {
  description = "Name of the security contact."
  type        = string
  default     = "CIT Cloud Services"
}

variable "defender_tier" {
  description = "Whether Defender Standard or Free tier should be used."
  type        = string
  default     = "Free"
}

variable "laws_agent" {
  description = "Whether to enable laws agent autoprovisioning."
  type        = string
  default     = "On"
}
