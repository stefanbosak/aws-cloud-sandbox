FROM public.ecr.aws/lambda/python:3.11

COPY requirements.txt ${LAMBDA_TASK_ROOT}

RUN pip install --upgrade pip && \
    pip install -r requirements.txt

COPY *.py ${LAMBDA_TASK_ROOT}

CMD ["lambda_script.lambda_handler"]
