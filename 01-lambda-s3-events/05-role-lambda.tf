# lambda policy document
data "aws_iam_policy_document" "sandbox_lambda_assume_role_service_policy_document" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

# lambda assume role service policy
resource "aws_iam_role" "sandbox_lambda_assume_role" {
  name               = "sandbox_lambda_assume_role"
  assume_role_policy = data.aws_iam_policy_document.sandbox_lambda_assume_role_service_policy_document.json
}

# lambda policy attachment
resource "aws_iam_role_policy_attachment" "sandbox_lambda_policy_attachment" {
  role       = aws_iam_role.sandbox_lambda_assume_role.name
  policy_arn = aws_iam_policy.sandbox_lambda_policy.arn
}

# attachment example for lambda managed policies to lambda role
#resource "aws_iam_role_policy_attachment" "sandbox_lambda_basic_execution_managed_policy_attachment" {
#  role = aws_iam_role.sandbox_lambda_role.name               
#  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
#}

# lambda assume role resource policy document 
data "aws_iam_policy_document" "sandbox_lambda_assume_role_resource_policy_document" {
  statement {
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = ["${aws_iam_role.sandbox_lambda_assume_role.arn}"]
  }
}

# assume for lambda role policy (for assigment to user)
resource "aws_iam_policy" "sandbox_lambda_assume_role_policy" {
  name   = "sandbox_lambda_assume_role_policy"
  policy = data.aws_iam_policy_document.sandbox_lambda_assume_role_resource_policy_document.json
}