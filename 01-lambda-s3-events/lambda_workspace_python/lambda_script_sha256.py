import hashlib
import boto3

# calculate the SHA-256 hash
def calculate_sha256(file_path):
    with open(file_path, 'rb') as f:
        sha256_hasher = hashlib.sha256()
        for chunk in iter(lambda: f.read(4096), b''):
            sha256_hasher.update(chunk)
        return sha256_hasher.hexdigest()

# upload the SHA-256 hash to S3 bucket
def upload_sha256_hash(bucket, key, sha256_hash):
    s3_client = boto3.client('s3')
    s3_client.put_object(Bucket=bucket, Key=key, Body=sha256_hash.encode('utf-8'))

# lamda handler processing triggered by subscribed S3 event
def lambda_handler(event, context):
    # explicitly receive SNS object from records, extract message
    # and parse JSON into Python dictionary
    #s3_event = json.loads(event['Records'][0]['Sns']['Message'])

    # parse JSON into Python dictionary
    #s3_event = json.loads(event["Records"][0]["body"])

    # extract S3 bucket name and key from the event
    file_name = event['Records'][0]['s3']['object']['key']
    bucket_name = event['Records'][0]['s3']['bucket']['name']

    # perform SHA-256 calculation for file stored on S3 bucket
    # for which S3 creation event has been triggered
    sha256_hash = calculate_sha256(f's3://{bucket_name}/{file_name}')

    # store calculated SHA-256 hash as file on same S3 bucket
    # for which S3 creation event has been triggered
    upload_sha256_hash(bucket_name, f'{file_name}.sha256', sha256_hash)
