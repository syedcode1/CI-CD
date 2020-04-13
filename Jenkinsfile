pipeline {
    agent any
    stages {
        stage ('Commit')
        {
            steps {
          echo 'Code commited in Github'
            }
        }
        stage('Build') {
            steps {
                sh 'docker build ./ -t hello-world-python:$BUILD_NUMBER'
                  }
        }
        stage('Test') {
            steps {
sh '#Defines images to be downloaded from Docker hub'
sh 'IMAGE="hello-world-python"'
sh 'REPO="hello-world-python-onprem"'

sh ' #Get the latest CS scanner '
sh 'docker login -u pubread -p BXaXRD9n3uEWKkGgt56eHVD5h tenableio-docker-consec-local.jfrog.io'
sh 'docker pull tenableio-docker-consec-local.jfrog.io/cs-scanner:latest'

sh '#Push the image to on-prem Container Security scanner'
sh '''retval=1
count=0
while [ $retval -ne 0 ]; do 
 docker save hello-world-python:$BUILD_NUMBER | docker run -e TENABLE_ACCESS_KEY=${TENABLE_IO_ACCESS_KEY} \
-e TENABLE_SECRET_KEY=${TENABLE_IO_SECRET_KEY} -e IMPORT_REPO_NAME="hello-world-python-onprem" \
-i tenableio-docker-consec-local.jfrog.io/cs-scanner:latest inspect-image "hello-world-python":$BUILD_NUMBER 
retval=$?  
if [ $retval -ne 0 ]; then 
echo "Error analyzing image. Will retry in a while." 
sleep 30
let count=count+1
else
echo "Pushed $IMAGE:$BUILD_NUMBER to Tenable CS on-prem scanner at" `date` 
fi
 done 
'''
                
                
sh 'echo "Checking for assessment results" '
sh ''' while [ 1 -eq 1 ]; do
RESP=`curl -s --request GET --url "https://cloud.tenable.com/container-security/api/v1/compliancebyname?image=hello-world-python&repo=hello-world-python-onprem&tag=$BUILD_NUMBER" \
--header 'accept: application/json' --header "x-apikeys: accessKey=${TENABLE_IO_ACCESS_KEY};secretKey=${TENABLE_IO_SECRET_KEY}"  | sed -n 's/.*\\\"status\\\":\\\"\\([^\\\"]*\\)\\\".*/\\1/p'` 
               
                           
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
        
        stage ('Deploy')
        {
            steps {
            sh 'docker run --rm hello-world-python:$BUILD_NUMBER'
            }
        }
        
        
    }
}
