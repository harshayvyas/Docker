FROM python:3.7

#Copying s3 files
RUN curl -O https://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py --user
RUN pip install -y aws-cli
RUN aws s3 cp s3://harshay-test/ ./
