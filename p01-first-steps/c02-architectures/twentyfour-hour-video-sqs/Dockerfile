FROM public.ecr.aws/lambda/python:3.8
COPY . /var/task
ENV TRANSCODED_VIDEO_BUCKET="your-favorite-bucket"
EXPOSE 8080
CMD [ "sqs_consumer/__main__.lambda_handler" ]
