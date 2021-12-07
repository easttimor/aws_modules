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

##########################
# Organizational Policies 
##########################
variable create_organizations_policies {
  type        = bool
  default     = false
  description = "Toggle Organizational Policies creation"
}

variable organizations_policy {
  type = list(object({
    name        = string
    description = string
    type        = string
    content     = string
  }))
  default = [
    {
      name        = "my_policy",
      description = "this is my policy",
      type        = "SERVICE_CONTROL_POLICY",
      content     = <<CONTENT
{
  "Version": "2012-10-17",
  "Statement": {
    "Effect": "Allow",
    "Action": "*",
    "Resource": "*"
  }
}
CONTENT
    }
  ]
  description = "Organizations Policies"
}

variable "policy_id" {
  default     = ""
  description = "The unique identifier (ID) of the policy that you want to attach to the target"
}

variable "target_id" {
  type        = any
  default     = []
  description = "The unique identifier (ID) of the root, organizational unit, or account number that you want to attach the policy to"
}

# Tags

variable "tags" {
  type        = map(string)
  description = "Tags"
  default     = { "Name" = "" }
} 