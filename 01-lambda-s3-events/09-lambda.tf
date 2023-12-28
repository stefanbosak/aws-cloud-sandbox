# create lambda.zip archive using archive provider
data "archive_file" "sandbox_lambda_archive" {
  type = "zip"

  source_dir  = format("%s/%s", "${path.root}", var.lambda_workspace_directory_name)
  output_path = "${path.root}/lambda.zip"
}

#
# preparation for alternative way to create lamda.zip archive
# including automated processing Python requirement
#
#resource "null_resource" "package_lambda_function" {
#  provisioner "local-exec" {
#    command = <<EOT
#      pip install -r requirements.txt -t lambda
#      zip -r lambda.zip my_lambda
#    EOT
#  }
#}

# configuration for lambda
resource "aws_lambda_function" "sandbox_lambda" {
  function_name    = var.lambda_function_name
  role             = aws_iam_role.sandbox_lambda_assume_role.arn
  handler          = format("%s.%s", var.lambda_script_name, var.lambda_function_name)
  architectures    = [var.lambda_architecture]
  runtime          = var.lambda_runtime
  filename         = data.archive_file.sandbox_lambda_archive.output_path
  s3_bucket        = aws_s3_bucket.sandbox_s3_event_bucket.arn
  s3_key           = format("%s.zip", var.lambda_function_name)
  memory_size      = 128
  publish          = true
  source_code_hash = data.archive_file.sandbox_lambda_archive.output_base64sha256
  layers           = [aws_lambda_layer_version.sandbox_lambda_layer.arn]
  # enable tracing
  #tracing_config {
  #  mode = "Active"
  #}
  # AWS Elastic Container Registry to cover Lambda inside Docker image
  #image_uri       = aws_ecr_repository.sandbox_ecr_repository.repository_url
  #package_type    = "Image"
  # Snap start
  #snap_start {
  #  apply_on = "PublishedVersions"
  #}
}

resource "aws_lambda_provisioned_concurrency_config" "sandbox_lambda_provisioned_concurrency_config" {
  function_name                     = aws_lambda_function.sandbox_lambda.function_name
  qualifier                         = aws_lambda_function.sandbox_lambda.version
  provisioned_concurrent_executions = 1
}

# lambda permissions S3 event via CloudWatch event bridge
resource "aws_lambda_permission" "sandbox_lambda_permission" {
  statement_id  = "Allow-S3-Event-via-CloudWatchEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.sandbox_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.sandbox_s3_event_rule.arn
}

# lambda permissions S3 event via S3 notification
#resource "aws_lambda_permission" "sandbox_lambda_permission" {
#  statement_id  = "Allow-S3-Event-via-S3Notification"
#  action        = "lambda:InvokeFunction"
#  function_name = aws_lambda_function.sandbox_lambda.function_name
#  principal     = "s3.amazonaws.com"
#  source_arn    = aws_s3_bucket.sandbox_s3_event_bucket.arn
#}

resource "aws_lambda_layer_version" "sandbox_lambda_layer" {
  filename            = aws_s3_object.sandbox_lambda_s3_object.bucket
  layer_name          = "sandbox_lambda_layer"
  compatible_runtimes = ["${var.lambda_runtime}"]
}
