################
# Organization 
################

variable "create_org" {
  type        = bool
  default     = false
  description = "Toggle Organization creation"
}

variable "aws_service_access_principals" {
  type        = list(any)
  default     = []
  description = "(Optional) List of AWS service principal names for which you want to enable integration with your organization."
}

variable "enabled_policy_types" {
  type        = list(any)
  default     = []
  description = "(Optional) List of Organizations policy types to enable in the Organization Root."
}

variable "feature_set" {
  type        = string
  default     = "ALL"
  description = "(Optional) Specify ALL (default) or CONSOLIDATED_BILLING."
}

########################
# Organizational Units 
########################
variable "create_organizational_units" {
  type        = bool
  default     = false
  description = "Toggle OU creation"
}

variable "organizational_units" {
  type = list(object({
    name      = string
    parent_id = string
  }))
  default = [
    {
      name      = "my_ou",
      parent_id = "parent_id"
    }
  ]
  description = "Organizational Units"
}