version: 0.2phases: 
  install:
    runtime-versions:
        docker: 18     
    commands: 
      - nohup /usr/local/bin/dockerd --host=unix:///var/run/docker.sock --host=tcp://127.0.0.1:2375 --storage-driver=overlay2&
      - timeout 15 sh -c "until docker info; do echo .; sleep 1; done"
  pre_build: 
    commands: 
    - echo Logging in to Amazon ECR.... 
    - aws --version
    # update the following line with your own region
    - $(aws ecr get-login --no-include-email --region eu-west-1)
    - COMMIT_HASH=$(echo $CODEBUILD_RESOLVED_SOURCE_VERSION | cut -c 1-7)
    - IMAGE_TAG=${COMMIT_HASH:=latest}
    - REPOSITORY_URI=344195135476.dkr.ecr.us-east-1.amazonaws.com/dockerimages
  build: 
    commands: 
    - echo Build started on `date` 
    - echo Building the Docker image... 
    # update the following line with the name of your own ECR repository
    - docker build -t $REPOSITORY_URI:latest .
    # update the following line with the URI of your own ECR repository (view the Push Commands in the console)
    - docker tag $REPOSITORY_URI:latest $REPOSITORY_URI:$IMAGE_TAG 
  post_build: 
    commands: 
    - echo Build completed on `date` 
    - echo pushing to repo
    # update the following line with the URI of your own ECR repository
    - docker push $REPOSITORY_URI:latest
    - docker push $REPOSITORY_URI:$IMAGE_TAG
    - echo Writing image definitions file... 
    #- printf '[{"ImageURI":"%s"}]' $REPOSITORY_URI:$IMAGE_TAG > imageDetail.json
    - printf '{"ImageURI":"%s"}' $REPOSITORY_URI:$IMAGE_TAG > imageDetail.json
artifacts:
  files:
    - imageDetail.json
