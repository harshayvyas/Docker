#This is a sample Image 
FROM ubuntu 

RUN apt-get update 
RUN apt-get install nginx 
CMD [“echo”,”Image created”] 
