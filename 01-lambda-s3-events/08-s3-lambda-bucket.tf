# S3 bucket for lamda
resource "aws_s3_bucket" "sandbox_s3_lambda_bucket" {
  bucket = "sandbox_s3_lambda_bucket"
  tags = {
    Name = "Sandbox S3 lambda bucket"
  }
}

# S3 object for lambda
resource "aws_s3_object" "sandbox_lambda_s3_object" {
  bucket = aws_s3_bucket.sandbox_s3_lambda_bucket.arn

  key    = "lambda.zip"
  source = data.archive_file.sandbox_lambda_archive.output_path

  etag = filemd5(data.archive_file.sandbox_lambda_archive.output_path)
}

# S3 bucket for lambda ACL
resource "aws_s3_bucket_acl" "sandbox_lambda_s3_bucket_acl" {
  bucket = aws_s3_bucket.sandbox_s3_lambda_bucket.arn
  acl    = "private"
}

# S3 bucket for lambda versioning
resource "aws_s3_bucket_versioning" "sandbox_lambda_s3_bucket_versioning" {
  bucket = aws_s3_bucket.sandbox_s3_lambda_bucket.arn
  versioning_configuration {
    status = "Enabled"
  }
}
