pipeline {
    agent any
    stages {
        stage('Preparation') {
            steps {
                script {
                    catchError(buildResult: 'SUCCESS') {
                        sh '''
                        # Controleer of de container bestaat en forceer stop/verwijdering
                        CONTAINER_ID=$(docker ps -a -q -f name=samplerunning)
                        if [ ! -z "$CONTAINER_ID" ]; then
                            docker stop samplerunning || true
                            docker rm samplerunning || true
                        fi
                        '''
                    }
                }
            }
        }
        stage('Build') {
            steps {
                build job: 'BuildSampleApp'
            }
        }
    }
}
