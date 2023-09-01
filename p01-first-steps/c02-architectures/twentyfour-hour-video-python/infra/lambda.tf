resource "aws_iam_role" "lambda_role" {
  name = "lambda_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_lambda_function" "transcode_video" {
  function_name = "transcode-video"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_function.handler"  # Adjust the handler as needed
  runtime       = "provided"                # Use the "provided" runtime for custom images

  image_config {
    image_uri = "064592191516.dkr.ecr.us-east-1.amazonaws.com/transcode_video_python:latest"  # Replace with your ECR image URI
  }

  environment {
    variables = {
      MEDIA_ENDPOINT          = "https://lxlxpswfb.mediaconvert.us-east-1.amazonaws.com"
      MEDIA_ROLE              = "arn:aws:iam::064592191516:role/media-convert-role"
      TRANSCODED_VIDEO_BUCKET = "064592191516-serverless-video-transcode-python"
    }
  }
}

resource "aws_lambda_permission" "allow_s3_trigger" {
  statement_id  = "AllowExecutionFromS3"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.transcode_video.arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.video_upload_bucket.arn
}

resource "aws_s3_bucket_notification" "video_upload_notification" {
  bucket = aws_s3_bucket.video_upload_bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.transcode_video.arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "uploads/"
    filter_suffix       = ".jpg"
  }
}
