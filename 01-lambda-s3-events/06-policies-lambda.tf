# lambda policy document
data "aws_iam_policy_document" "sandbox_lambda_policy_document" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "lambda:InvokeFunction"
    ]
    resources = [
      "${aws_lambda_function.sandbox_lambda.arn}"
    ]
  }
}

# lambda policy wrapping lambda policy document
resource "aws_iam_policy" "sandbox_lambda_policy" {
  name   = "sandbox_lambda_policy"
  policy = data.aws_iam_policy_document.sandbox_lambda_policy_document.json
}