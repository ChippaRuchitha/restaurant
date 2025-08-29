pipeline {
    agent any

    stages {
        stage('Clone') {
            steps {
                echo "Cloning repository..."
                git branch: 'main', url: 'https://github.com/ChippaRuchitha/Restaurant.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image..."
                sh 'docker build -t Restaurant-app .'
            }
        }

        stage('Run Container') {
            steps {
                echo "Running Docker container..."
                // Stop & remove old container if already running
                sh '''
                docker stop Restaurant-container || true
                docker rm Restaurant-container || true
                docker run -d --name bio-container -p 8086:80 Restaurant-app
                '''
            }
        }
    }
}
