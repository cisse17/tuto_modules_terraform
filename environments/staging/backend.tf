terraform {
    backend "s3" {
      bucket = "terraform-state-bassirou-2026"
      key = "staging/terraform.tfstate"
      region = "eu-west-3"
    #   dynamodb_table = "terraform-lock-bassirou"
      use_lockfile = true
      encrypt = true
    }
}