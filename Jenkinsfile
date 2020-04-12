pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'docker build ./ -t hello-world-python:$BUILD_NUMBER'
                  }
        }
    }
}
