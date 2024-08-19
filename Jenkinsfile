pipeline {
    agent any

    environment {
        DOCKERHUB_USERNAME = "kashifsadiq"
        APP_NAME = "node-todo-cicd"
        IMAGE_TAG = "${BUILD_NUMBER}"
        IMAGE_NAME = "${DOCKERHUB_USERNAME}/${APP_NAME}"
        REGISTRY_CREDS = "dockerhubcred"
    }

    stages {
        stage('Cleanup workspace') {
            steps {
                cleanWs()
            }
        }
        stage('Checkout SCM') {
            steps {
                git url: 'https://github.com/KashifSad/node-todo-cicd.git', branch: 'master'
                echo 'Code has been cloned successfully.'
            }
        }
        stage('Build') {
            steps {
                script {docker_image = docker.build "${IMAGE_NAME}"
                }
            }
        }
        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('', "${REGISTRY_CREDS}") {
                        docker_image.push("$BUILD_NUMBER")
                        docker_image.push("latest")
                    }
                }
            }
        }
    }
}
