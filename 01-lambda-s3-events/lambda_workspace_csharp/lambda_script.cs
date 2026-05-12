using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Amazon.Lambda.Core;
using Amazon.S3;
using Amazon.S3.Event;

[assembly:LambdaSerializer(typeof(Amazon.Lambda.Serialization.Json.JsonSerializer))]

namespace Sandbox
{
    public class Lambda
    {
        public async Task lambda_handler(S3Event evnt, ILambdaContext context)
        {
            var s3 = new AmazonS3Client();

            foreach (var record in evnt.Records)
            {
                var bucket = record.S3.Bucket.Name;
                var key = record.S3.Object.Key;

                context.Logger.LogLine($"Processing object {key} from bucket {bucket}");
            }
        }
    }
}