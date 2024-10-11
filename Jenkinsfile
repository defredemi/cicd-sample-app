pipeline {
    agent any
    stages {
        stage('Preparation') {
            steps {
                script {
                    catchError(buildResult: 'SUCCESS') {
                        sh '''
                        # Controleer of de container draait en stop hem zo nodig
                        if [ "$(docker ps -q -f name=samplerunning)" ]; then
                            docker stop samplerunning
                        fi
                        # Verwijder de container als deze nog bestaat
                        if [ "$(docker ps -a -q -f name=samplerunning)" ]; then
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
