pipeline {
    agent any

    environment {
        DOCKERHUB_USERNAME = "kashifsadiq"
        APP_NAME = "node-todo-cicd"
        IMAGE_NAME = "${DOCKERHUB_USERNAME}/${APP_NAME}"
        REGISTRY_CREDS = "dockerhubcred"
    }

    stages {
        stage('Cleanup workspace') {
            steps {
                cleanWs()
            }
        }
        stage("Checkout SCM") {
            steps{
                 
            }
        
    }

}
}
