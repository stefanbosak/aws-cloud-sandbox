output "sandbox_lambda_s3_bucket" {
  value = aws_lambda_function.sandbox_lambda.s3_bucket
}

output "sandbox_lambda_s3_key" {
  value = aws_lambda_function.sandbox_lambda.s3_key
}

output "sandbox_s3_lambda_bucket" {
  value = aws_s3_bucket.sandbox_s3_lambda_bucket.arn
}

output "sandbox_s3_event_bucket_arn" {
  value = "s3://${aws_s3_bucket.sandbox_s3_event_bucket.arn}"
}

output "sandbox_lambda_qualified_arn" {
  value = aws_lambda_function.sandbox_lambda.qualified_arn
}
