terraform {
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
  create_org = true
  aws_service_access_principals = [
    "guardduty.amazonaws.com",
    "access-analyzer.amazonaws.com",
    # "macie.amazonaws.com",
    # "aws-artifact-account-sync.amazonaws.com",
    "account.amazonaws.com",
    # "backup.amazonaws.com",
    # "license-manager.amazonaws.com",
    # "member.org.stacksets.cloudformation.amazonaws.com",
    "cloudtrail.amazonaws.com",
    # "compute-optimizer.amazonaws.com",
    "config.amazonaws.com",
    # "ds.amazonaws.com",
    # "fms.amazonaws.com", # Firewall Manager
    # "ram.amazonaws.com",
    # "storage-lens.s3.amazonaws.com",
    "securityhub.amazonaws.com",
    # "servicecatalog.amazonaws.com",
    "sso.amazonaws.com",
    # "ssm.amazonaws.com",
    # "tagpolicies.tag.amazonaws.com",     
  ]

  enabled_policy_types = [
    "AISERVICES_OPT_OUT_POLICY",
    # "BACKUP_POLICY",
    "SERVICE_CONTROL_POLICY",
    # "TAG_POLICY"
  ]
  feature_set = "ALL"

  # Organizational Unit
  create_organizational_units = true
  organizational_units = [
    {
      name      = "workloads",
      parent_id = "" # overridden by root ou
    },
    {
      name      = "central",
      parent_id = "" # overridden by root ou
    },
  ]

  # Organizational Policies
  create_organizations_policy = false
}

module "organization" {
  source = "../../../aws_organizations"

  # Organization
  create_org                    = local.create_org
  aws_service_access_principals = local.aws_service_access_principals
  enabled_policy_types          = local.enabled_policy_types
  feature_set                   = local.feature_set

  # Organizational Units
  create_organizational_units = local.create_organizational_units
  organizational_units        = local.organizational_units
}