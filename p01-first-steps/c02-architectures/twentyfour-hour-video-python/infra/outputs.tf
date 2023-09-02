output "aws_iam_role_policy_attachment_media-convert-role_AmazonS3FullAccess_id" {
  value = aws_iam_role_policy_attachment.media-convert-role_AmazonS3FullAccess.id
}

output "aws_iam_role_policy_attachment_transcode-video_AWSElementalMediaConvertFullAccess_id" {
  value = aws_iam_role_policy_attachment.transcode-video_AWSElementalMediaConvertFullAccess.id
}

output "aws_iam_role_policy_attachment_transcode-video_AWSLambdaExecute_id" {
  value = aws_iam_role_policy_attachment.transcode-video_AWSLambdaExecute.id
}


output "aws_iam_role_media-convert-role_id" {
  value = aws_iam_role.media-convert-role.id
}

output "aws_iam_role_transcode-video_id" {
  value = aws_iam_role.transcode-video.id
}


output "aws_lambda_function_hello-world-dev-hello_id" {
  value = aws_lambda_function.hello-world-dev-hello.id
}

output "aws_lambda_function_twentyfour-hour-video-dev-transcode-video_id" {
  value = aws_lambda_function.twentyfour-hour-video-dev-transcode-video.id
}

output "aws_lambda_function_twentyfour-hour-video-python-dev-custom-resource-existing-s3_id" {
  value = aws_lambda_function.twentyfour-hour-video-python-dev-custom-resource-existing-s3.id
}

output "aws_lambda_function_twentyfour-hour-video-python-dev-transcode-video_id" {
  value = aws_lambda_function.twentyfour-hour-video-python-dev-transcode-video.id
}
