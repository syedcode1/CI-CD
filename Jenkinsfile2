#!/usr/bin/env groovy

pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'docker build ./ -t hello-world-python:$BUILD_NUMBER'
                  }
        }
        stage('Test') {
            steps {
sh '''#!/usr/bin/env bash
#Defines images to be downloaded from Docker hub
IMAGE="hello-world-python"
REPO="hello-world-python-onprem"

#Get the latest CS scanner
docker login -u pubread -p BXaXRD9n3uEWKkGgt56eHVD5h tenableio-docker-consec-local.jfrog.io
docker pull tenableio-docker-consec-local.jfrog.io/cs-scanner:latest

#Push the image to on-prem Container Security scanner
retval=1
count=0
while [ $retval -ne 0 ]; do

docker save $IMAGE:$BUILD_NUMBER | docker run -e TENABLE_ACCESS_KEY=$TENABLE_IO_ACCESS_KEY \
-e TENABLE_SECRET_KEY=$TENABLE_IO_SECRET_KEY -e IMPORT_REPO_NAME=$REPO \
-i tenableio-docker-consec-local.jfrog.io/cs-scanner:latest inspect-image $IMAGE:$BUILD_NUMBER

retval=$?
if [ $retval -ne 0 ]; then
echo "Error analyzing image. Will retry in a while."
sleep 30
let count=count+1
else
echo "Pushed $IMAGE:$BUILD_NUMBER to Tenable CS on-prem scanner at" `date`
fi
done

echo "Checking for assessment results"
while [ 1 -eq 1 ]; do
RESP=`curl -s --request GET --url "https://cloud.tenable.com/container-security/api/v1/compliancebyname?image=$IMAGE&repo=$REPO&tag=$BUILD_NUMBER" \
--header 'accept: application/json' --header "x-apikeys: accessKey=212b4c0ab8e464bbd39812be2e7eaa3a89bf61f73768d32674311ba6a2400fed;secretKey=8c465e8fc76bf0a6fccdea13755afa8aa7e6889e661422b3dfa62e4df75a0a93" \
| sed -n 's/.*\"status\":\"\([^\"]*\)\".*/\1/p'`
if [ "x$RESP" = "xpass" ]; then
echo "Container marked as PASSED by policy rules"
exit 0
fi
if [ "x$RESP" = "xfail" ]; then
echo "Container marked as FAILED by policy rules"
exit 1
fi
sleep 30
done

'''




                  }
        }
        
    }
}
