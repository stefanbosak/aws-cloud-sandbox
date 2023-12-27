# CloudWatch event rule for S3 object created event
# (disable when using S3 bucket notification directly to lambda,
# see more in 6-s3-event-bucket.tf)
resource "aws_cloudwatch_event_rule" "sandbox_s3_event_rule" {
  name          = "sandbox_s3_event_rule"
  event_pattern = <<EOF
{
  "detail": {
    "object": {
      "key":[
      {
        "prefix": "test"
      }
      {
        "suffix": ".txt"
      }]
    },
    "bucket": {
      "name": ["${aws_s3_bucket.sandbox_s3_event_bucket.arn}"]
    }
  },
  "detail-type": ["Object Created"],
  "source": ["aws.s3"]
}
EOF
}

# CloudWatch event target for S3 object created event targetting lambda 
# (disable when using S3 bucket notification directly to lambda,
# see more in 6-s3-event-bucket.tf)
resource "aws_cloudwatch_event_target" "sandbox_s3_event_target" {
  rule      = aws_cloudwatch_event_rule.sandbox_s3_event_rule.name
  target_id = "sandbox_s3_event_target"
  arn       = aws_lambda_function.sandbox_lambda.arn
}