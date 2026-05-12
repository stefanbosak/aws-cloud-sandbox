# configuration for AWS provider
provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}

# configuration for archive provider
provider "archive" {}

# configuration for null provider
provider "null" {}
