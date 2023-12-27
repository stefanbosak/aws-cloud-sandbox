#!/bin/bash
cwd=$(dirname $(realpath "${0}"))

# S3 event bucket attributes
S3_EVENT_BUCKET_ID="sandbox_s3_event_bucket_arn"
S3_EVENT_BUCKET_DOMAIN_APPENDER=".s3.amazonaws.com"
S3_EVENT_BUCKET_OBJECT_PREFIX="test"
S3_EVENT_BUCKET_OBJECT_SUFFIX=".txt"

# S3 event bucket (additional suffix for generated file containing calculated SHA256 data)
S3_EVENT_BUCKET_OBJECT_SUFFIX_SHA256=".sha256"

# generated content of source file
SOURCE_FILE_CONTENT="Data: ${SRANDOM}"

# target file stored on S3 event bucket
TARGET_FILE_URI="https://${S3_EVENT_BUCKET_ID}${S3_EVENT_BUCKET_DOMAIN_APPENDER}/${S3_EVENT_BUCKET_OBJECT_PREFIX}${S3_EVENT_BUCKET_OBJECT_SUFFIX}"

# remove file for S3 event bucket
echo "Deleting file from S3 event bucket"
curl -X DELETE "${TARGET_FILE_URI}"

# upload file directly to S3 event bucket
TMP_FILE=$(mktemp)

# cleanup handler (clean temporary file)
trap 'rm -f ${TMP_FILE}' EXIT

echo "${SOURCE_FILE_CONTENT}" > "${TMP_FILE}"
echo "Uploading generated file to S3 event bucket"
curl -X PUT -T "${TMP_FILE}" "${TARGET_FILE_URI}"

# create file with content directly on S3 event bucket (alternative to upload of file with content mentioned above)
#echo "Creating new file on S3 event bucket"
#curl -X PUT -H "Content-Type: text/plain" --data-binary "${SOURCE_FILE_CONTENT}" "${TARGET_FILE_URI}"

# calculate SHA256 (using common system tools)
CALCULATED_DATA=$(sha256sum "${TMP_FILE}" | awk '{print $1}')

# obtain calculated SHA256
OBTAINED_DATA=$(curl "${TARGET_FILE_URI}${S3_EVENT_BUCKET_OBJECT_SUFFIX_SHA256}")

# calculate SHA256 (using the same AWS lambda python code)
#pushd "${cwd}/../lamda_workspace_python/" > /dev/null 2>&1
#CALCULATED_DATA=$(python3 -c "from lambda_script_sha256 import calculate_sha256; print(calculate_sha256('${TMP_FILE}'))")
#popd > /dev/null 2>&1

# compare / check matching of obtained and calculated data
if [ "${OBTAINED_DATA}" == "${CALCULATED_DATA}" ]; then
  echo "Obtained and calculated data are the same: PASSED"
fi
