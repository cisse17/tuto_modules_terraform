
# OIDC PROVIDER AWS fait confiance à github
resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com"
  ]

#  Empreinte du certificat GIthub - valeur fixe officielle
  thumbprint_list = [
    "6938fd4d98bab03faadb97b34396831e3780aea1",
    "1c58a3a8518e8759bf075b76b750d4f2df264fcd"
  ]

  tags = {
    Name = "github-actions-oidc"
  }
}

# IAM ROLE ce que github actions peut faire 
resource "aws_iam_role" "github_actions" {
  name = "github-actions-role"

#   Qui peut utiliser ce rôle
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.github.arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringLike = {
            # uniquement mon repo github qui peut utiliser ce rôle
            "token.actions.githubusercontent.com:sub" = "repo:cisse17/tuto_modules_terraform:*"
          }
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          }
        }
      }
    ]
  })

  tags = {
    Name = "github-actions-role"
  }
}

# IAM POLICY - les permissions exactes
resource "aws_iam_role_policy" "github_actions" {
  name = "github-actions-policy"
  role = aws_iam_role.github_actions.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        # terraform a besoin de ces permissions pour gerer l'infra
        Effect = "Allow"
        Action = [
 
          "ec2:*",
          "rds:*",
          "vpc:*",
          "elasticloadbalancing:*",
          "s3:*",
        #   "dynamodb:*", 
          "iam:*"
        ]
        Resource = "*"
      }
    ]
  })
}
