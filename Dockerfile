FROM python:3.7

#Copying s3 files
RUN aws s3 cp s3://harshay-test/ ./
