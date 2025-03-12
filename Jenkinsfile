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
                    dockerImage = docker.build("pegasusbi/com:latest")
                }
            }
        }
        stage('Push') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials') {
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Apply to Kubernetes') {
            steps {
                sh 'kubectl rollout restart deployment flask-app'
            }
        }
        stage('Port Forwarding') {
            steps {
                script {
                    sh "nohup kubectl port-forward svc/flask-service ${LOCAL_PORT}:${REMOTE_PORT} > /dev/null 2>&1 &"
                }
            }
        }
    }
}
