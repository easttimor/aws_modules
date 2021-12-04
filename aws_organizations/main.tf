data "aws_caller_identity" "current" {}

################
# Organization 
################
resource "aws_organizations_organization" "this" {

  count = var.create_org ? 1 : 0

  aws_service_access_principals = var.aws_service_access_principals
  enabled_policy_types          = var.enabled_policy_types
  feature_set                   = var.feature_set

}

########################
# Organizational Units 
########################
resource "aws_organizations_organizational_unit" "this" {

  for_each = var.create_organizational_units ? { for ou in var.organizational_units : ou.name => ou } : {}

  name      = each.value.name
  parent_id = length(each.value.parent_id) > 0 ? each.value.parent_id : aws_organizations_organization.this[0].roots[0].id

}

############################
#  Organizations Accounts  #
############################


##########################
#  Organizations Policy  #
##########################