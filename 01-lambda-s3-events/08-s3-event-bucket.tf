# S3 bucket (S3 creation event triggering lambda)
# (disable tags when using S3 bucket notification directly to lambda)
resource "aws_s3_bucket" "sandbox_s3_event_bucket" {
  bucket = "sandbox_s3_event_bucket"
  tags = {
    Name = "S3 event bucket"
  }
}

# S3 event via CloudWatch event rule
# (disable when using S3 bucket notification directly to lambda)
resource "aws_s3_bucket_notification" "sandbox_s3_event_bucket_notification" {
  bucket      = aws_s3_bucket.sandbox_s3_event_bucket.arn
  eventbridge = true
}

# S3 bucket notification directly to lambda for handling S3 events without CloudWatch event rule
# (alternative to CloudWatch event rule, remove CloudWatch event rules to use this approach)
# receive via SNS (Simple Notification Service) or SQS (Simple Queue Service) which has to be configured
#resource "aws_s3_bucket_notification" "sandbox_s3_event_bucket_notification" {
#  bucket = aws_s3_bucket.sandbox_s3_event_bucket.arn
#  lambda_function {
#    lambda_function_arn = aws_lambda_function.sandbox_lambda.arn
#    events = ["s3:ObjectCreated:*"]
#    filter_prefix = "test"
#    filter_suffix = ".txt"
#  }
#  depends_on = [aws_lambda_permission.sandbox_lambda_permission]
#}
