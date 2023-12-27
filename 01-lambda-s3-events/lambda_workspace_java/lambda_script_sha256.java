import java.io.BufferedInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.security.MessageDigest;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.PutObjectRequest;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.lambda.runtime.events.S3Event;

public class Lambda implements RequestHandler<S3Event, String> {

    private static final int BUFFER_SIZE = 4096;

    public static String calculateSha256(String filePath) {
        MessageDigest messageDigest = null;
        try {
            messageDigest = MessageDigest.getInstance("SHA-256");
        } catch (Exception e) {
            throw new RuntimeException("Failed to initialize SHA-256 message digest", e);
        }

        try (InputStream inputStream = new FileInputStream(filePath)) {
            byte[] data = new byte[BUFFER_SIZE];
            int read;
            while ((read = inputStream.read(data)) != -1) {
                messageDigest.update(data, 0, read);
            }
        } catch (IOException e) {
            throw new RuntimeException("Failed to read file for SHA-256 calculation", e);
        }

        byte[] sha256HashBytes = messageDigest.digest();
        return new String(sha256HashBytes, "UTF-8");
    }

    public static void uploadSha256hash(String bucketName, String key, String sha256Hash) {
        AmazonS3 s3Client = new AmazonS3Client();
        PutObjectRequest putObjectRequest = new PutObjectRequest(bucketName, key, sha256Hash.getBytes("UTF-8"));
        s3Client.putObject(putObjectRequest);
    }

    @Override
    public String lambda_handler(S3Event s3Event, Context context) {
        S3EventNotification notification = s3Event.getRecords().get(0);
        String bucketName = notification.getS3().getBucket().getName();
        String fileName = notification.getS3().getObject().getKey();

        try {
            // Calculate the SHA-256 hash of the file
            String sha256Hash = calculateSha256("s3://" + bucketName + "/" + fileName);

            // Store the calculated SHA-256 hash as a file in the same S3 bucket
            uploadSha256hash(bucketName, fileName + ".sha256", sha256Hash);
        } catch (Exception e) {
            e.printStackTrace();
            return "Failed to process S3 objectCreated event: " + e.getMessage();
        }
        return "Successfully processed S3 objectCreated event.";
    }
}