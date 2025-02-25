init:
	sudo npm install -g serverless
	sudo npm install -g serverless-offline
	sls config credentials --provider aws --key <> --secret <>

serverless.yml:
	sls create --template aws-python3 --path .

.serverless/twentyfour-hour-video-python.zip:
	sls deploy

docker-image:
	docker build --progress=plain -t 064592191516.dkr.ecr.us-east-1.amazonaws.com/sqs_consumer:latest .

docker-login-ecr:
	aws --profile 064592191516 ecr get-login-password | docker login --username AWS --password-stdin 064592191516.dkr.ecr.us-east-1.amazonaws.com

docker-push:
	docker push 064592191516.dkr.ecr.us-east-1.amazonaws.com/sqs_consumer:latest

integrate: docker-image docker-login-ecr docker-push

docker-stop:
	docker stop tvp || true

docker-run:
	docker run --rm --name tvp -p 32768:8080 -d 064592191516.dkr.ecr.us-east-1.amazonaws.com/sqs_consumer:latest

docker-test-negative:
	curl "http://localhost:32768/2015-03-31/functions/function/invocations" -d '{}'

docker-test-positive:
	curl "http://localhost:32768/2015-03-31/functions/function/invocations" --data-binary '@test/s3-put.json'

check-infra:
	cd infra && terraform init && terraform validate && tflint

plan: check-infra
	cd infra && terraform plan

apply:
	cd infra && terragrunt --terragrunt-source-update plan && terragrunt apply -auto-approve