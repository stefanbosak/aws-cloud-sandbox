import java.io.PrintStream;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;

public class Lambda implements RequestHandler<S3Event, String> {

    private static final PrintStream logger = System.out;

    @Override
    public String lambda_handler(S3Event event, Context context) {
        logger.println("--- AWS Lambda (S3 creation event) start ---");
        logger.println(event);
        logger.println("--- AWS Lambda (S3 creation event) end ---");

        return "Processed lambda";
    }
}
