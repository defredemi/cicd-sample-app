pipeline {
    agent any
    stages {
        stage('Preparation') {
            steps {
                script {
                    catchError(buildResult: 'SUCCESS') {
                        sh '''
                        if [ "$(docker ps -q -f name=samplerunning)" ]; then
                            docker stop samplerunning
                            docker rm samplerunning
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
