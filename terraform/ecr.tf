############################################################################
# ECR
############################################################################
resource "aws_ecr_repository" "ecr" {
  image_tag_mutability = "MUTABLE"
  name                 = "dev-ecr"
  encryption_configuration {
    encryption_type = "AES256"
  }

  image_scanning_configuration {
    scan_on_push = false
  }
}

