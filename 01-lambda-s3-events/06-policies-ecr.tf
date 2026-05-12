# ECR policy document
#data "aws_iam_policy_document" "sandbox_ecr_policy_document" {
#  statement {
#    effect = "Allow"
#    actions = [
#      "ecr:BatchCheckLayerAvailability",
#      "ecr:InitiateLayerUpload",
#      "ecr:UploadLayerPart",
#      "ecr:CompleteLayerUpload",
#      "ecr:PutImage"
#      "ecr:BatchGetImage",
#      "ecr:GetDownloadUrlForLayer",
#    ]
#    resources = [
#      "${aws_ecr_registry.sandbox_ecr_registry.arn}"
#    ]
#  }
#}

# ECR policy wrapping lambda policy document
#resource "aws_iam_policy" "sandbox_ecr_policy" {
#  name   = "sandbox_ecr_policy"
#  policy = data.aws_iam_policy_document.sandbox_ecr_policy_document.json
#}
