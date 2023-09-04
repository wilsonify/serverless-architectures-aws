data "aws_iam_policy_document" "video_transcode_sqs_done_polcy_doc" {
  statement {
    sid       = "__owner_statement"
    effect    = "Allow"
    resources = ["arn:aws:sqs:us-east-1:064592191516:serverless-video-transcode-sqs-done"]
    actions   = ["SQS:*"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::064592191516:root"]
    }
  }

  statement {
    sid       = "__sender_statement"
    effect    = "Allow"
    resources = ["arn:aws:sqs:us-east-1:064592191516:serverless-video-transcode-sqs-done"]
    actions   = ["SQS:SendMessage"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::064592191516:role/twentyfour-hour-video-python-IamRoleCustomResources"]
    }
  }

  statement {
    sid       = "__receiver_statement"
    effect    = "Allow"
    resources = ["arn:aws:sqs:us-east-1:064592191516:serverless-video-transcode-sqs-done"]

    actions = [
      "SQS:ChangeMessageVisibility",
      "SQS:DeleteMessage",
      "SQS:ReceiveMessage",
    ]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::064592191516:role/twentyfour-hour-video-python-IamRoleCustomResources"]
    }
  }
}

data "aws_iam_policy_document" "video_transcode_sqs_fail_policy_doc" {
  statement {
    sid       = "__owner_statement"
    effect    = "Allow"
    resources = ["arn:aws:sqs:us-east-1:064592191516:serverless-video-transcode-sqs-fail"]
    actions   = ["SQS:*"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::064592191516:root"]
    }
  }

  statement {
    sid       = "__sender_statement"
    effect    = "Allow"
    resources = ["arn:aws:sqs:us-east-1:064592191516:serverless-video-transcode-sqs-fail"]
    actions   = ["SQS:SendMessage"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::064592191516:role/twentyfour-hour-video-python-IamRoleCustomResources"]
    }
  }

  statement {
    sid       = "__receiver_statement"
    effect    = "Allow"
    resources = ["arn:aws:sqs:us-east-1:064592191516:serverless-video-transcode-sqs-fail"]

    actions = [
      "SQS:ChangeMessageVisibility",
      "SQS:DeleteMessage",
      "SQS:ReceiveMessage",
    ]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::064592191516:role/twentyfour-hour-video-python-IamRoleCustomResources"]
    }
  }
}

data "aws_iam_policy_document" "video_transcode_sqs_try_policy_doc" {
  statement {
    sid       = "__owner_statement"
    effect    = "Allow"
    resources = ["arn:aws:sqs:us-east-1:064592191516:serverless-video-transcode-sqs-try"]
    actions   = ["SQS:*"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::064592191516:root"]
    }
  }

  statement {
    sid       = "__sender_statement"
    effect    = "Allow"
    resources = ["arn:aws:sqs:us-east-1:064592191516:serverless-video-transcode-sqs-try"]
    actions   = ["SQS:SendMessage"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::064592191516:role/twentyfour-hour-video-python-IamRoleCustomResources"]
    }
  }

  statement {
    sid       = "__receiver_statement"
    effect    = "Allow"
    resources = ["arn:aws:sqs:us-east-1:064592191516:serverless-video-transcode-sqs-try"]

    actions = [
      "SQS:ChangeMessageVisibility",
      "SQS:DeleteMessage",
      "SQS:ReceiveMessage",
    ]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::064592191516:role/twentyfour-hour-video-python-IamRoleCustomResources"]
    }
  }
}

resource "aws_sqs_queue" "tfer--serverless-video-transcode-sqs-done" {
  content_based_deduplication       = "false"
  delay_seconds                     = "0"
  fifo_queue                        = "false"
  kms_data_key_reuse_period_seconds = "300"
  kms_master_key_id                 = "alias/aws/sqs"
  max_message_size                  = "262144"
  message_retention_seconds         = "345600"
  name                              = "serverless-video-transcode-sqs-done"
  policy                            = data.aws_iam_policy_document.video_transcode_sqs_done_polcy_doc.json
  receive_wait_time_seconds         = "0"
  redrive_policy                    = "{\"deadLetterTargetArn\":\"arn:aws:sqs:us-east-1:064592191516:serverless-video-transcode-sqs-fail\",\"maxReceiveCount\":10}"
  sqs_managed_sse_enabled           = "false"
  visibility_timeout_seconds        = "30"
}

resource "aws_sqs_queue" "tfer--serverless-video-transcode-sqs-fail" {
  content_based_deduplication       = "false"
  delay_seconds                     = "0"
  fifo_queue                        = "false"
  kms_data_key_reuse_period_seconds = "300"
  kms_master_key_id                 = "alias/aws/sqs"
  max_message_size                  = "262144"
  message_retention_seconds         = "345600"
  name                              = "serverless-video-transcode-sqs-fail"
  policy = data.aws_iam_policy_document.video_transcode_sqs_fail_policy_doc.json
  receive_wait_time_seconds  = "0"
  redrive_allow_policy       = "{\"redrivePermission\":\"byQueue\",\"sourceQueueArns\":[\"arn:aws:sqs:us-east-1:064592191516:serverless-video-transcode-sqs-done\",\"arn:aws:sqs:us-east-1:064592191516:serverless-video-transcode-sqs-try\"]}"
  sqs_managed_sse_enabled    = "false"
  visibility_timeout_seconds = "30"
}

resource "aws_sqs_queue" "tfer--serverless-video-transcode-sqs-try" {
  content_based_deduplication       = "false"
  delay_seconds                     = "0"
  fifo_queue                        = "false"
  kms_data_key_reuse_period_seconds = "300"
  kms_master_key_id                 = "alias/aws/sqs"
  max_message_size                  = "262144"
  message_retention_seconds         = "345600"
  name                              = "serverless-video-transcode-sqs-try"
  policy = data.aws_iam_policy_document.video_transcode_sqs_try_policy_doc.json
  receive_wait_time_seconds  = "0"
  redrive_policy             = "{\"deadLetterTargetArn\":\"arn:aws:sqs:us-east-1:064592191516:serverless-video-transcode-sqs-fail\",\"maxReceiveCount\":10}"
  sqs_managed_sse_enabled    = "false"
  visibility_timeout_seconds = "30"
}
