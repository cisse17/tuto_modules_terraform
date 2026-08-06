terraform{
    backend "s3"{
        bucket = "terraform-state-bassirou-2026"
        key = "staging/terraform.tfstate"
        region = "eu-west-3"
        use_lockfile = true
        # dynamodb_table = "terraform-lock-bassirou"
        encrypt = true
    }
}