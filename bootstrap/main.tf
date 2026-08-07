terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "5.0.0"
    }
  }
}

provider "aws"{
    region = "eu-west-3"
}

# S3 bucket, stockage fichiers tfstate
resource "aws_s3_bucket" "terraform_state"{
    bucket = "terraform-state-bassirou-2026"

    # lifecycle {
    #   prevent_destroy = true
    # }

    tags = {
        Name = "terraform-state-bassirou"
    }
}


# Versioning, garde l'historique de nos states
resource "aws_s3_bucket_versioning" "terraform_state"{
    bucket = aws_s3_bucket.terraform_state.id

    versioning_configuration {
      status = "Enabled"
    }
}

# Chiffrement, la sécurité des données
resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state"{
    bucket = aws_s3_bucket.terraform_state.id

    rule {
        apply_server_side_encryption_by_default {
          sse_algorithm = "AES256"
        }
    }
}


# Bloquer tout accés public 
resource "aws_s3_bucket_public_access_block" "terraform_state"{
    bucket = aws_s3_bucket.terraform_state.id
    #  ACL = une liste de qui peut acceder à quoi
    block_public_acls = true
    block_public_policy = true
    ignore_public_acls = true 
    restrict_public_buckets = true

}


# # DynamoDB : verrou du state
# resource "aws_dynamodb_table" "terraform_lock"{
#     name = "terraform-lock-bassirou"
#     billing_mode = "PAY_PER_REQUEST"
#     hash_key = "LockID"

#     attribute {
#       name = "LockID"
#       type = "S"
#     }

#     tags = {
#         Name = "terraform-lock-bassirou"
#     }

# }