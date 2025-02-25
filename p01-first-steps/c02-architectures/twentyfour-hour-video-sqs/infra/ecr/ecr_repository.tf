resource "aws_ecr_repository" "tfer--images" {
  encryption_configuration {
    encryption_type = "KMS"
    kms_key         = "arn:aws:kms:us-east-1:064592191516:key/83dec65c-2291-42e6-8116-187471e14532"
  }

  image_scanning_configuration {
    scan_on_push = "false"
  }

  image_tag_mutability = "MUTABLE"
  name                 = "images"
}

resource "aws_ecr_repository" "tfer--sqs_consumer" {
  encryption_configuration {
    encryption_type = "KMS"
    kms_key         = "arn:aws:kms:us-east-1:064592191516:key/83dec65c-2291-42e6-8116-187471e14532"
  }

  image_scanning_configuration {
    scan_on_push = "false"
  }

  image_tag_mutability = "MUTABLE"
  name                 = "sqs_consumer"
}
