resource "aws_iam_role" "media-convert-role" {
  assume_role_policy = <<POLICY
{
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "mediaconvert.amazonaws.com"
      },
      "Sid": ""
    }
  ],
  "Version": "2012-10-17"
}
POLICY

  description          = "Allows MediaConvert service to call S3 APIs and API Gateway on your behalf."
  managed_policy_arns  = ["arn:aws:iam::aws:policy/AmazonAPIGatewayInvokeFullAccess", "arn:aws:iam::aws:policy/AmazonS3FullAccess"]
  max_session_duration = "3600"
  name                 = "media-convert-role"
  path                 = "/"

  tags = {
    app = "video-encoding-pipeline"
  }

  tags_all = {
    app = "video-encoding-pipeline"
  }
}

resource "aws_iam_role" "transcode-video" {
  assume_role_policy = <<POLICY
{
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      }
    }
  ],
  "Version": "2012-10-17"
}
POLICY

  description          = "Allows Lambda functions to call AWS video transcode services on your behalf."
  managed_policy_arns  = ["arn:aws:iam::aws:policy/AWSElementalMediaConvertFullAccess", "arn:aws:iam::aws:policy/AWSLambdaExecute"]
  max_session_duration = "3600"
  name                 = "transcode-video"
  path                 = "/"

  tags = {
    app = "video-encoding-pipeline"
  }

  tags_all = {
    app = "video-encoding-pipeline"
  }
}

resource "aws_iam_role" "twentyfour-hour-video-python-IamRoleCustomResources" {
  assume_role_policy = <<POLICY
{
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      }
    }
  ],
  "Version": "2012-10-17"
}
POLICY

  inline_policy {
    name   = "dev-twentyfour-hour-video-python-custom-resources-lambda"
    policy = "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Action\":[\"s3:PutBucketNotification\",\"s3:GetBucketNotification\"],\"Resource\":\"arn:aws:s3:::064592191516-serverless-video-upload-python\",\"Effect\":\"Allow\"},{\"Action\":[\"lambda:AddPermission\",\"lambda:RemovePermission\"],\"Resource\":\"arn:aws:lambda:us-east-1:064592191516:function:*\",\"Effect\":\"Allow\"}]}"
  }

  max_session_duration = "3600"
  name                 = "twentyfour-hour-video-python-IamRoleCustomResources"
  path                 = "/"

  tags = {
    STAGE = "dev"
  }

  tags_all = {
    STAGE = "dev"
  }
}


resource "aws_iam_role_policy" "twentyfour-hour-video-python-IamRoleCustomResources_dev-twentyfour-hour-video-python-custom-resources-lambda" {
  name = "dev-twentyfour-hour-video-python-custom-resources-lambda"
  policy = <<POLICY
{
  "Statement": [
    {
      "Action": [
        "s3:PutBucketNotification",
        "s3:GetBucketNotification"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::064592191516-serverless-video-upload-python"
    },
    {
      "Action": [
        "lambda:AddPermission",
        "lambda:RemovePermission"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:lambda:us-east-1:064592191516:function:*"
    }
  ],
  "Version": "2012-10-17"
}
POLICY

  role = "twentyfour-hour-video-python-IamRoleCustomResources"
}

resource "aws_iam_role_policy_attachment" "media-convert-role_AmazonS3FullAccess" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  role       = "media-convert-role"
}

resource "aws_iam_role_policy_attachment" "transcode-video_AWSElementalMediaConvertFullAccess" {
  policy_arn = "arn:aws:iam::aws:policy/AWSElementalMediaConvertFullAccess"
  role       = "transcode-video"
}

resource "aws_iam_role_policy_attachment" "transcode-video_AWSLambdaExecute" {
  policy_arn = "arn:aws:iam::aws:policy/AWSLambdaExecute"
  role       = "transcode-video"
}
