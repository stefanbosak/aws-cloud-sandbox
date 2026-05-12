# 01 lambda (S3 events)

This subdirectory of sandbox repository is focusing on experiments with [AWS Lambda](https://docs.aws.amazon.com/lambda/latest/dg/welcome.html).
Actual purpose is to handle S3 object creation event triggering execution of AWS Lambda function as target.
Process is covering extraction of S3 event bucket name and S3 object key as file name from S3 event and perform action above this dataset
(calculating of SHA256 for obtained file and storing value to new file with suffix .sha256 to the same S3 event bucket).

> [!NOTE]
> The whole codebase is frequently a prototype, not intended to be directly
tested in a real environment in every case. The main purpose is to eventually
have broader coverage and kind of templating later tight to required needs.
Deeper testing is considered to be conducted mostly for more relevant
purposes due to a time perspective. It means the codebase might need some
changes to be working in general.

> [!IMPORTANT]
> Check details before taking any action.

> [!CAUTION]
> User is responsible for any modification and execution of any parts from this repository.

__prerequisites:__
- for AWS tools following repository could considered to be used [aws-cloud-tools](https://github.com/stefanbosak/aws-cloud-tools)
- recommended deployment chain is mentioned below

Many meta-configuration attributes might be based on a more verbose representation.
Previously stated means to use the possibilities of autocompletion and validation features.
The above-described approach is able to identify mistakes in a very early phase.
There are also frequently alternatives to the solutions described in the comments.

__some hightlights:__
- lambda warm/snap startup can be partially achieved by setting-up of few specificly available attributes within configuration metadata, but frequently needs more deeper understanding of given use cases and environment details (it is not so simple as it seems to be [out of box thinking] and on the other hand not so complicated as it might be [consider side effects of overengineering])
- security, monitoring, higher reliability/availability and other advanced topics are often multilayer-based and require multi-dimensional high-level view from more perspectives to accomplish given goals smarter way

__directories and their content:__
- [lambda_workspace_csharp](lambda_workspace_csharp): workspace for AWS Lambda using C#
- [lambda_workspace_csharp/Dockerfile](lambda_workspace_csharp/Dockerfile): Dockerfile for AWS Lambda using C#
- [lambda_workspace_csharp/lambda_script.cs](lambda_workspace_csharp/lambda_script.cs): simple C#-based lambda for quick prototyping
- [lambda_workspace_java](lambda_workspace_java): workspace for AWS Lambda using Java
- [lambda_workspace_java/Dockerfile](lambda_workspace_java/Dockerfile): Dockerfile for AWS Lambda using Java
- [lambda_workspace_java/lambda_script.java](lambda_workspace_java/lambda_script.java): simple Java-based lambda for quick prototyping
- [lambda_workspace_java/lambda_script_sha256.java](lambda_workspace_java/lambda_script_sha256.java): specific Java-based lambda to be triggered by specified S3 event
- [lambda_workspace_python](lambda_workspace_python): workspace for AWS Lambda using Python
- [lambda_workspace_python/Dockerfile](lambda_workspace_python/Dockerfile): Dockerfile for AWS Lambda using Python
- [lambda_workspace_python/lambda_script.java](lambda_workspace_java/lambda_script.py): simple Python-based lambda for quick prototyping
- [lambda_workspace_python/lambda_script_sha256.java](lambda_workspace_java/lambda_script_sha256.py): specific Python-based lambda to be triggered by specified S3 event
- [scripts](scripts): helper/wrapper scripts for specific purposes (e. g. automation)
- [scripts/s3-event-bucket_create-object-event-trigger.sh](scripts/s3-event-bucket_create-object-event-trigger.sh): helper/wrapper script for testing of S3 event

__files:__
- [00-terraform.tf](00-terraform.tf): Terraform application version and required providers
- [01-variables.tf](01-variables.tf): Variables used accross whole codebase
- [02-providers.tf](02-providers.tf): Setup for providers
- [03-outputs.tf](03-outputs.tf): Output attributes suitable for necessary purposes
- [04-user.tf](04-user.tf): Dedicated user for assign corresponsing access rights
- [05-role-lambda.tf](05-role-lambda.tf): Role for Lambda
- [05-role-s3-event-bucket.tf](05-role-s3-event-bucket.tf): Role for S3 bucket used as source for  and necessary data processings
- [05-role-s3-lambda-bucket.tf](05-role-s3-lambda-bucket.tf): Role for S3 bucket used as storage for lambda itself
- [06-policies-ecr.tf](06-policies-ecr.tf): Policies for ECR
- [06-policies-lambda.tf](06-policies-lambda.tf): Policies for Lambda
- [06-policies-s3-event-bucket.tf](06-policies-s3-event-bucket.tf): Policies for S3 bucket (events and dataprocessing)
- [06-policies-s3-lambda-bucket.tf](06-policies-s3-lambda-bucket.tf): Policies for S3 bucket (lambda storage)
- [07-cloudwatch-event.tf](07-cloudwatch-event.tf): Configuration(s) of CloudWatch events
- [07-cloudwatch-log.tf](07-cloudwatch-log.tf): Configuration(s) of CloudWatch log
- [08-s3-event-bucket.tf](08-s3-event-bucket.tf): Configuration(s) for S3 bucket (events)
- [08-s3-lambda-bucket.tf](08-s3-lambda-bucket.tf): Configuration(s) for S3 bucket (lambda)
- [09-lambda.tf](09-lambda.tf): Configuration(s) for lambda
- [10-ecr.tf](10-ecr.tf): Configuration(s) for ECR (elastic container registry)
- [01-Lambda-S3-events_presentation.pdf](01-Lambda-S3-events_presentation.pdf): Short presentation

__recommended deployment chain:__

01. create/setup AWS account, gather corresponding credentials required by AWS provider
02. align required configuration data as needed for your case
03. prepare and use corresponding AWS tools as required (see prerequisites section mentioned above for more details)
04. initialize local terraform environment:
   `terraform init`
05. rewrite terraform code to a canonical format:
   `terraform fmt`
06. validate terraform configuration and syntax as part of pre-checks:
   `terraform validate`
07. present generated terraform execution proposal considered to be executed:
   `terraform plan`
08. approve proposal previously presented by terraform:
   `terraform apply`
09. do related work with environment reflecting requested state (see recommended test chain section)
10. cleanup resources allocated by related infrastructure as code parts in AWS ecosystem when not needed to prevent unwanted usage and unnecessary billings/costs within AWS connected account:
   `terraform destroy`

__recommended test chain:__
01. align deployment as required
02. consider to use prepared helpers/wrappers in [scripts](scripts) directory (check and apply required alignments to given use case first)
03. perform corresponding testing as needed

__hints:__
- [pre-commit-terraform](https://github.com/antonbabenko/pre-commit-terraform/)
