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
 docker save hello-world-python:$BUILD_NUMBER \
 docker run -e TENABLE_ACCESS_KEY=212b4c0ab8e464bbd39812be2e7eaa3a89bf61f73768d32674311ba6a2400fed \
-e TENABLE_SECRET_KEY=8c465e8fc76bf0a6fccdea13755afa8aa7e6889e661422b3dfa62e4df75a0a93 -e IMPORT_REPO_NAME="hello-world-python-onprem" \
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
'''
                
                
sh 'echo "Checking for assessment results" '
sh 'while [ 1 -eq 1 ]; do'
sh ''' RESP=`curl -s --request GET --url "https://cloud.tenable.com/container-security/api/v1/compliancebyname?image=$IMAGE&repo=$REPO&tag=$BUILD_NUMBER" \
--header 'accept: application/json' --header "x-apikeys: accessKey=212b4c0ab8e464bbd39812be2e7eaa3a89bf61f73768d32674311ba6a2400fed;secretKey=8c465e8fc76bf0a6fccdea13755afa8aa7e6889e661422b3dfa62e4df75a0a93" 
| sed -n 's/.*\\\"status\\\":\\\"\\([^\\\"]*\\)\\\".*/\\1/p'` '''
               
                
                
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
