# S3 event bucket policy document
data "aws_iam_policy_document" "sandbox_s3_event_bucket_policy_document" {
  statement {
    effect = "Allow"
    actions = [
      "s3:ListBucket"
    ]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    resources = [
      "${aws_s3_bucket.sandbox_s3_event_bucket.arn}"
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "s3:CreateObject",
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    resources = [
      "${aws_s3_bucket.sandbox_s3_event_bucket.arn}/*"
    ]
  }
}

# S3 event bucket policy wrapping S3 event policy document
resource "aws_iam_policy" "sandbox_s3_event_bucket_policy" {
  name   = "sandbox_s3_event_bucket_policy"
  policy = data.aws_iam_policy_document.sandbox_s3_event_bucket_policy_document.json
}