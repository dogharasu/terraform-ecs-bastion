############################################################################
# プロバイダ設定
############################################################################
provider "aws" {
  region = "ap-northeast-1"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.68"
    }
  }
}

############################################################################
# バックエンド設定
############################################################################
terraform {
  backend "s3" {
    bucket         = "dev-s3-terraform-ecs-bastion-20220206"
    key            = "state/terraform.tfstate"
    encrypt        = true
    region         = "ap-northeast-1"
    dynamodb_table = "dev-dynamodb-terraform-ecs-bastion"
  }
}