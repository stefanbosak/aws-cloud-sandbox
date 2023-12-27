# create new dedicated user
resource "aws_iam_user" "sandbox_iam_user" {
  name = "sandbox_user"
}

# set user access
resource "aws_iam_access_key" "sandbox_iam_access_key" {
  user = aws_iam_user.sandbox_iam_user
}

# attach assume s3 event bucket role policy to user
resource "aws_iam_user_policy_attachment" "sandbox_iam_user_policy_attachement_s3_event_bucket_assume_role_policy" {
  policy_arn = aws_iam_role.sandbox_s3_event_bucket_assume_role.arn
  user       = aws_iam_user.sandbox_iam_user
}

# attach assume s3 lambda bucket role policy to user
resource "aws_iam_user_policy_attachment" "sandbox_iam_user_policy_attachement_s3_lambda_bucket_assume_role_policy" {
  policy_arn = aws_iam_role.sandbox_s3_lambda_bucket_assume_role.arn
  user       = aws_iam_user.sandbox_iam_user
}

# attach assume lambda role policy to user
resource "aws_iam_user_policy_attachment" "sandbox_iam_user_policy_attachement_lambda_assume_role_policy" {
  policy_arn = aws_iam_role.sandbox_lambda_assume_role.arn
  user       = aws_iam_user.sandbox_iam_user
}