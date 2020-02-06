FROM python:3.7

#Copying s3 files
ENV AWS_ACCESS_KEY_ID=AKIAIHD3ARZLWFJTASVQ
ENV AWS_SECRET_ACCESS_KEY=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
ENV AWS_DEFAULT_REGION=us-east-1
RUN curl -O https://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py --user
RUN apt-get update && apt-get install -y awscli
RUN aws s3 cp s3://harshay-test/ ./
RUN ls
