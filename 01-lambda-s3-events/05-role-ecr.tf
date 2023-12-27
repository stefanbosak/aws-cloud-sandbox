# ECR policy document
#data "aws_iam_policy_document" "sandbox_ecr_assume_role_service_policy_document" {
#  statement {
#    effect  = "Allow"
#    actions = ["sts:AssumeRole"]
#    principals {
#      type        = "Service"
#      identifiers = ["ecr.amazonaws.com"]
#    }
#  }
#}

# ECR assume role service policy
#resource "aws_iam_role" "sandbox_ecr_assume_role" {
#  name               = "sandbox_ecr_assume_role"
#  assume_role_policy = data.aws_iam_policy_document.sandbox_ecr_assume_role_service_policy_document.json
#}

# ECR policy attachment
#resource "aws_iam_role_policy_attachment" "sandbox_ecr_policy_attachment" {
#  role       = aws_iam_role.sandbox_ecr_assume_role.name
#  policy_arn = aws_iam_policy.sandbox_ecr_policy.arn
#}

# ECR assume role resource policy document 
#data "aws_iam_policy_document" "sandbox_ecr_assume_role_resource_policy_document" {
#  statement {
#    effect    = "Allow"
#    actions   = ["sts:AssumeRole"]
#    resources = ["${aws_iam_role.sandbox_ecr_assume_role.arn}"]
#  }
#}

# assume for ECR role policy (for assigment to user)
#resource "aws_iam_policy" "sandbox_ecr_assume_role_policy" {
#  name   = "sandbox_ecr_assume_role_policy"
#  policy = data.aws_iam_policy_document.sandbox_ecr_assume_role_resource_policy_document.json
#}
