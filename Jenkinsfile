pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                script{
                    docker build ./ -t hello-world-python:$BUILD_NUMBER}
              
            }
        }
    }
}
