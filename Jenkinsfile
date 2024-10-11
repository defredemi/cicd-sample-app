pipeline {
    agent any

    stages {
        stage('Preparation') {
            steps {
                script {
                    // Zorg ervoor dat de container wordt gestopt en verwijderd als deze bestaat
                    sh '''
                    if [ "$(docker ps -q -f name=samplerunning)" ]; then
                        echo "Stopping running container 'samplerunning'..."
                        docker stop samplerunning || true
                    fi

                    if [ "$(docker ps -a -q -f name=samplerunning)" ]; then
                        echo "Removing existing container 'samplerunning'..."
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
                    echo "Starting new container 'samplerunning'..."
                    docker run -d --name samplerunning -p 5050:5050 sampleapp:latest
                    '''
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    sh '''
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
