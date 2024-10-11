pipeline {
    agent any

    stages {
        stage('Preparation') {
            steps {
                script {
                    catchError(buildResult: 'SUCCESS') {
                        sh '''
                        # Controleer of de container bestaat en forceer stop/verwijdering
                        if [ "$(docker ps -q -f name=samplerunning)" ]; then
                            echo "Stopping running container..."
                            docker stop samplerunning || true
                        fi
                        
                        if [ "$(docker ps -a -q -f name=samplerunning)" ]; then
                            echo "Removing existing container..."
                            docker rm -f samplerunning || true
                        fi
                        '''
                    }
                }
            }
        }

        stage('Build') {
            steps {
                script {
                    sh '''
                    # Bouw de Docker-afbeelding
                    echo "Building Docker image..."
                    docker build -t sampleapp:latest .
                    '''
                }
            }
        }

        stage('Run') {
            steps {
                script {
                    sh '''
                    # Start de container
                    echo "Starting new container..."
                    docker run -d --name samplerunning -p 5050:5050 sampleapp:latest
                    '''
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    sh '''
                    # Test de applicatie
                    echo "Running application tests..."
                    curl --fail http://localhost:5050 || exit 1
                    '''
                }
            }
        }
    }

    post {
        always {
            script {
                echo 'Cleaning up Docker...'
                sh '''
                # Cleanup Docker resources after pipeline execution
                docker stop samplerunning || true
                docker rm samplerunning || true
                '''
            }
        }
    }
}
