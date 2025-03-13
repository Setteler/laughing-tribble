pipeline {
    agent any
    environment {
        MINIKUBE_IP = "192.168.49.2" // Change if needed
        LOCAL_PORT = "5002"          // Local port to forward to
        REMOTE_PORT = "5000"         // Flask app's port
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Setteler/laughing-tribble.git'
            }
        }
        stage('Build') {
            steps {
                script {
                    sh 'docker build --no-cache -t $DOCKER_IMAGE .'
                }
            }
        }
        stage('Push') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials') {
                        sh 'docker push $DOCKER_IMAGE'
                    }
                }
            }
        }
        
        stage('Apply to Kubernetes') {
            steps {
                script{
                    sh '''
                        kubectl apply -f deployment.yaml
                        kubectl rollout status deployment/flask-app
            '''
                }
            }
        }
    }
}
