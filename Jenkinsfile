pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'my-java-app:latest'
        CONTAINER_NAME = 'my-java-container'
    }

    stages {
        stage('Checkout') {
            steps {
                // Use scmGit to checkout the code
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'tetris_token', url: 'https://github.com/youssefharrak1/TetrisCICD.git']])
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    sh "docker build -t ${DOCKER_IMAGE} ."
                }
            }
        }

        stage('Run Docker Container and Extract Files') {
            steps {
                script {
                    // Run the Docker container
                    sh "docker run --name ${CONTAINER_NAME} ${DOCKER_IMAGE}"
                    
                    // Copy the required file from the container
                    sh "docker cp ${CONTAINER_NAME}:/app/bin/Tetris.jar Tetris.jar"

                    // Remove the container
                    sh "docker rm ${CONTAINER_NAME}"
                }
            }
        }

        stage('Archive Output Files') {
            steps {
                // Archive the output file
                archiveArtifacts artifacts: 'Tetris.jar', fingerprint: true
            }
        }
    }

    post {
        always {
            // Cleanup, remove image if needed
            sh "docker rmi ${DOCKER_IMAGE} || true"
        }
    }
}
