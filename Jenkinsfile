pipeline {
    agent { dockerfile true }
    stages {
        stage('Build') {
            steps {
                script{
                    docker build ./ -t hello-world-python:$BUILD_NUMBER}
              
            }
        }
    }
}
