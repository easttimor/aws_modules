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
    # Artifact
    "account.amazonaws.com",
    # AWS Backup
    # AWS Marketplace - License Management
    # CloudFormation StackSets
    "cloudtrail.amazonaws.com",
    # Compute Optimizer
    "config.amazonaws.com",
    # Directory Service
    # Firewall Manager
    # License Manager
    # RAM
    # S3 Storage Lens
    "securityhub.amazonaws.com",
    # Service Catalog
    "sso.amazonaws.com",
    # Systems Manager
    # Tag Policies

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