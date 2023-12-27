terraform {
  required_providers {
    # provider to interact with AWS ecosystem
    # using latest version available on 20.Dec.2023
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.31.0"
    }
    # provider to handle lambda archiving
    # using latest version available on 20.Dec.2023
    archive = {
      source  = "hashicorp/archive"
      version = ">=2.4.1"
    }

    # provider to handle specific local operations
    # using latest version available on 20.Dec.2023
    null = {
      source  = "hashicorp/null"
      version = ">=3.2.2"
    }
  }
  # version requirement for terraform client
  # using latest version available on 20.Dec.2023
  required_version = ">= 1.6.6"
}
