data "aws_iam_policy_document" "sqs_consumer_ecr_policy_doc" {
  statement {
    sid    = "LambdaECRImageRetrievalPolicy"
    effect = "Allow"

    actions = [
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer",
      "ecr:SetRepositoryPolicy",
      "ecr:DeleteRepositoryPolicy",
      "ecr:GetRepositoryPolicy",
    ]

    condition {
      test     = "StringLike"
      variable = "aws:sourceArn"
      values   = ["arn:aws:lambda:us-east-1:064592191516:function:*"]
    }

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_ecr_repository_policy" "tfer--sqs_consumer" {
  policy     = data.aws_iam_policy_document.sqs_consumer_ecr_policy_doc.json
  repository = "sqs_consumer"
}
