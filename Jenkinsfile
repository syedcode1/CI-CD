pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'docker build ./ -t hello-world-python:$BUILD_NUMBER'
                  }
        }
        stage('Build') {
            steps {
sh '#Defines images to be downloaded from Docker hub'
sh 'IMAGE="hello-world-python"'
sh '"hello-world-python-onprem"'

sh ' #Get the latest CS scanner '
sh 'docker login -u pubread -p BXaXRD9n3uEWKkGgt56eHVD5h tenableio-docker-consec-local.jfrog.io'
sh 'docker pull tenableio-docker-consec-local.jfrog.io/cs-scanner:latest'

sh '#Push the image to on-prem Container Security scanner'
sh 'retval=1'
sh 'count=0'
sh 'while [ $retval -ne 0 ]; do'

sh 'docker save $IMAGE:$BUILD_NUMBER | docker run -e TENABLE_ACCESS_KEY=$TENABLE_IO_ACCESS_KEY \
-e TENABLE_SECRET_KEY=$TENABLE_IO_SECRET_KEY -e IMPORT_REPO_NAME=$REPO \
-i tenableio-docker-consec-local.jfrog.io/cs-scanner:latest inspect-image $IMAGE:$BUILD_NUMBER'

sh 'retval=$?'
sh 'if [ $retval -ne 0 ]; then '
sh 'echo "Error analyzing image. Will retry in a while." '
sh 'sleep 30'
sh 'let count=count+1'
sh 'else'
sh 'echo "Pushed $IMAGE:$BUILD_NUMBER to Tenable CS on-prem scanner at" `date`'
sh 'fi'
sh 'done'

sh 'echo "Checking for assessment results" '
sh 'while [ 1 -eq 1 ]; do'

sh 'RESP=`curl -s --request GET --url "https://cloud.tenable.com/container-security/api/v1/compliancebyname?image=$IMAGE&repo=$REPO&tag=$BUILD_NUMBER" \ --header 'accept: application/json' --header "x-apikeys: accessKey=$TENABLE_IO_ACCESS_KEY;secretKey=$TENABLE_IO_SECRET_KEY" \ |sed -n 's/.*\"status\":\"\([^\"]*\)\".*/\1/p'`'   
                
sh 'if [ "x$RESP" = "xpass" ]; then'
sh 'echo "Container marked as PASSED by policy rules" '
sh 'exit 0'
sh 'fi'
sh 'if [ "x$RESP" = "xfail" ]; then'
sh 'echo "Container marked as FAILED by policy rules" '
sh 'exit 1'
sh 'fi'
sh 'sleep 30'
sh 'done'

                  }
        }
        
    }
}
