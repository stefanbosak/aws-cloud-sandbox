# AWS profile
variable "aws_profile" {
  description = "AWS profile"
  type        = string
  default     = "default"
}

# AWS region
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

# lambda workspace directory name
variable "lambda_workspace_directory_name" {
  description = "lambda workspace directory name"
  type        = string
  default     = "lambda_workspace_python"
}

# lambda script name
variable "lambda_script_name" {
  description = "lambda script name"
  type        = string
  default     = "lambda_script"
  #default = "lambda_script_sha256"
}

# lambda function name
variable "lambda_function_name" {
  description = "lambda function name"
  type        = string
  default     = "lambda_handler"
}

# lambda architecture
variable "lambda_architecture" {
  description = "lambda architecture"
  type        = string
  default     = "x86_64"
}

# lambda runtime
variable "lambda_runtime" {
  description = "lambda runtime"
  type        = string
  default     = "python3.11"
  #default = "java11"
}