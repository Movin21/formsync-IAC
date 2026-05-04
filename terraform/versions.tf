terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4"
    }
  }

  # Uncomment and configure for remote state in production
  # backend "s3" {
  #   bucket         = "formsync-tfstate"
  #   key            = "ec2-docker/terraform.tfstate"
  #   region         = "us-east-1"
  #   dynamodb_table = "formsync-tfstate-lock"
  #   encrypt        = true
  # }
}
