pipeline {
    agent any

    stages {
        stage('Preparation') {
            steps {
                script {
                    sh '''
                    # Controleer of er een bestaande container is met de naam 'samplerunning'
                    if [ "$(docker ps -a -q -f name=samplerunning)" ]; then
                        echo "Stopping and removing existing container 'samplerunning'..."
                        docker stop samplerunning || true
                        docker rm samplerunning || true
                    fi
                    '''
                }
            }
        }

        stage('Build') {
            steps {
                script {
                    sh '''
                    # Bouw de Docker image
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
                    # Start een nieuwe container met de naam 'samplerunning'
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
                    # Test de applicatie om te controleren of deze draait
                    echo "Testing the application..."
                    curl --fail http://localhost:5050 || exit 1
                    '''
                }
            }
        }
    }

    post {
        always {
            script {
                echo 'Cleaning up...'
                sh '''
                # Verwijder de container na de build
                docker stop samplerunning || true
                docker rm samplerunning || true
                '''
            }
        }
    }
}
