pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = 'dockerhub-cred'    // Jenkins credentials ID for Docker Hub
        DOCKERHUB_REPO = 'ruchitha1318/restaurant'  // Your Docker Hub repo name
        IMAGE_TAG = "latest"                        // Or use "${env.BUILD_NUMBER}"
        KUBECONFIG_CREDENTIALS = 'kubeconfig'       // Jenkins credentials ID for kubeconfig file
    }

    stages {
        stage('Clone Repository') {
            steps {
                echo "📥 Cloning GitHub repository..."
                git branch: 'main', url: 'https://github.com/ChippaRuchitha/restaurant.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "🐳 Building Docker image..."
                withCredentials([usernamePassword(credentialsId: "${DOCKERHUB_CREDENTIALS}", 
                                                 usernameVariable: 'DOCKER_USER', 
                                                 passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker build -t ${DOCKER_USER}/restaurant:${IMAGE_TAG} .
                    '''
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                echo "📤 Pushing image to Docker Hub..."
                withCredentials([usernamePassword(credentialsId: "${DOCKERHUB_CREDENTIALS}", 
                                                 usernameVariable: 'DOCKER_USER', 
                                                 passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push ${DOCKER_USER}/restaurant:${IMAGE_TAG}
                    '''
                }
            }
        }

        stage('Deploy to K3s') {
            steps {
                echo "🚀 Deploying to K3s cluster..."
                withCredentials([file(credentialsId: "${KUBECONFIG_CREDENTIALS}", variable: 'KUBECONFIG_FILE')]) {
                    sh '''
                        export KUBECONFIG=$KUBECONFIG_FILE
                        kubectl set image deployment/restaurant-deployment restaurant-container=${DOCKER_USER}/restaurant:${IMAGE_TAG} --record
                        kubectl rollout status deployment/restaurant-deployment
                        kubectl get pods -o wide
                    '''
                }
            }
        }
    }
}
