# S3 lambda bucket role service policy document
data "aws_iam_policy_document" "sandbox_s3_lambda_bucket_assume_role_service_policy_document" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }
  }
}

# S3 lambda bucket role policy
resource "aws_iam_role" "sandbox_s3_lambda_bucket_assume_role" {
  name               = "sandbox_s3_lambda_bucket_role"
  assume_role_policy = data.aws_iam_policy_document.sandbox_s3_lambda_bucket_assume_role_service_policy_document.json
}

# S3 lambda bucket policy attachment to S3 lambda bucket role
resource "aws_iam_role_policy_attachment" "sandbox_s3_lambda_bucket_policy_attachment" {
  role       = aws_iam_role.sandbox_s3_lambda_bucket_assume_role.name
  policy_arn = aws_iam_policy.sandbox_s3_lambda_bucket_policy.arn
}

# S3 lambda bucket managed policy attachment to S3 lambda bucket role
#resource "aws_iam_role_policy_attachment" "sandbox_s3_read_only_managed_policy_attachment" {
#  role       = aws_iam_role.sandbox_s3_lambda_bucket_role.name
#  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
#}

# S3 lambda bucket assume role resource policy document
data "aws_iam_policy_document" "sandbox_s3_lambda_bucket_assume_role_resource_policy_document" {
  statement {
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = ["${aws_iam_role.sandbox_s3_lambda_bucket_assume_role.arn}"]
  }
}

# assume for sandbox s3 role policy (for assigment to user)
resource "aws_iam_policy" "sandbox_assume_s3_lambda_bucket_role_policy" {
  name   = "sandbox_assume_s3_lambda_bucket_role_policy"
  policy = data.aws_iam_policy_document.sandbox_s3_lambda_bucket_assume_role_resource_policy_document.json
}