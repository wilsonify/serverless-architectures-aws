resource "aws_s3_bucket_notification" "s3_trigger" {
  bucket = "064592191516-serverless-video-upload-python"  # Replace with your S3 bucket ID
  lambda_function {
    lambda_function_arn = "arn:aws:lambda:us-east-1:064592191516:function:twentyfour-hour-video-python-transcode-video"
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "uploads/"
    filter_suffix       = ".mp4"
  }
}