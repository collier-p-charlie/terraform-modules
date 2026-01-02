terraform {
  required_version = "~> 1.14.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.27"
    }
  }
}

provider "aws" {
  region = var.region

  assume_role {  # role to assume for cross-account permissions
    role_arn     = var.command_role_arn
    session_name = "DiggerDeploy"
  }

  default_tags {
    tags = {
      Project     = var.project_id
      Region      = var.region
      Environment = var.environment
      Terraform   = true
    }
  }
}
