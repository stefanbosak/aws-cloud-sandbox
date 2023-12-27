# S3 lambda bucket policy document
data "aws_iam_policy_document" "sandbox_s3_lambda_bucket_policy_document" {
  statement {
    effect = "Allow"
    actions = [
      "s3:ListBucket"
    ]
    resources = [
      "${aws_s3_bucket.sandbox_s3_lambda_bucket.arn}"
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject"
    ]
    resources = [
      "${aws_s3_bucket.sandbox_s3_lambda_bucket.arn}/*"
    ]
  }
}

# S3 lambda bucket policy wrapping S3 lambda bucket policy document
resource "aws_iam_policy" "sandbox_s3_lambda_bucket_policy" {
  name   = "sandbox_s3_lambda_bucket_policy"
  policy = data.aws_iam_policy_document.sandbox_s3_lambda_bucket_policy_document.json
}