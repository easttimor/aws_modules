terraform {
  experiments = [module_variable_optional_attrs]

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

locals {
  # Organization
  create_org                    = false
  create_organizational_units   = false
  create_organizations_policy   = false
  create_organizations_accounts = true
}

module "organization" {
  source = "../../../aws_organizations"

  # Organization
  create_org = local.create_org

  # Organizational Units
  create_organizational_units = local.create_organizational_units

  # Organizations Accounts
  # terraform import module.organization.aws_organizations_account.this[\"accountname\"] 111111111111

  create_organizations_accounts = local.create_organizations_accounts
  organizations_accounts = [
    {
      name      = "",
      email     = "m",
      parent_id = "",
      role_name = ""
    },
    {
      name      = "",
      email     = "",
      parent_id = "",
      role_name = ""
    }
  ]
}