pipeline {
    agent any

    stages {
        stage('Clone') {
            steps {
                echo "Cloning repository..."
                git branch: 'main', url: 'https://github.com/ChippaRuchitha/restaurant.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image..."
                sh 'docker build -t restaurant-app .'
            }
        }

        stage('Run Container') {
            steps {
                echo "Running Docker container..."
                // Stop & remove old container if already running
                sh '''
                docker stop restaurant-container || true
                docker rm restaurant-container || true
                docker run -d --name restaurant-container -p 8086:80 restaurant-app
                '''
            }
        }
    }
}
