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
                    sh 'docker build --no-cache -t pegasusbi/com:latest .'
                }
            }
        }
        stage('Push') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials') {
                        sh 'docker push pegasusbi/com:latest'
                    }
                }
            }
        }

        stage('Apply to Kubernetes') {
            steps {
                script{
                    sh '''
                        kubectl delete pod -l app=flask  # Delete old pods to force pulling
                        kubectl apply -f dep.yaml
                        kubectl rollout status deployment/flask-app
            '''
                }
            }
        }
    }
}
