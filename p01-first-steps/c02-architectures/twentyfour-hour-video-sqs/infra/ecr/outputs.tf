output "aws_ecr_repository_policy_tfer--sqs_consumer_id" {
  value = "${aws_ecr_repository_policy.tfer--sqs_consumer.id}"
}

output "aws_ecr_repository_tfer--images_id" {
  value = "${aws_ecr_repository.tfer--images.id}"
}

output "aws_ecr_repository_tfer--sqs_consumer_id" {
  value = "${aws_ecr_repository.tfer--sqs_consumer.id}"
}
