# CloudWatch logging
resource "aws_cloudwatch_log_group" "sandbox_lambda_logs" {
  name              = "/aws/lambda/${aws_lambda_function.sandbox_lambda.function_name}"
  retention_in_days = 7
}