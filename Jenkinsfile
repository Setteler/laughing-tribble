pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Setteler/laughing-tribble.git'
            }
        }
        stage('Build') {
            steps {
                script {
                    sh 'docker build --no-cache -t pegasusbi/com:${BUILD_NUMBER} .'
                }
            }
        }
        stage('Push') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials') {
                        sh 'docker push pegasusbi/com:${BUILD_NUMBER}'
                    }
                }
            }
        }

        stage('Apply to Kubernetes') {
            steps {
                script{
                    sh '''
                        kubectl apply -f dep.yaml
                        kubectl rollout status deployment/flask-app
            '''
                }
            }
        }
    }
}
