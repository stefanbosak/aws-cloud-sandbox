FROM public.ecr.aws/lambda/dotnet:7
  
COPY publish/* ${LAMBDA_TASK_ROOT}
  
CMD [ "Sandbox::Lambda::lambda_handler" ]