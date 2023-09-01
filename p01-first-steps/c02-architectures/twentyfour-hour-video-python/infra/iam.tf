resource "aws_iam_role" "lambda_role" {
  name = "transcode-video"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "lambda_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AWSLambda_FullAccess"
  roles      = [aws_iam_role.lambda_role.name]
}
