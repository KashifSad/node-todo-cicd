pipeline {
    agent any

    environment {
        DOCKERHUB_USERNAME = "kashifsadiq"
        APP_NAME = "flask-app"
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

        stage("delete docker image"){
            steps{
                script{
                    sh "docker rmi ${IMAGE_NAME}:${IMAGE_TAG}"
                    sh "docker rmi ${IMAGE_NAME}:latest"
                }
            }
        }
        stage("Updating k8s manifest"){
            steps{
                script{
                    sh """
                    cat deployment.yml
                    sed -i 's/${APP_NAME}.*/${APP_NAME}:${IMAGE_TAG}/g' deployment.yml
                    cat deployment.yml
                """
                }
            }
        }
        stage("jenkins push changes into deployment.yml"){
            steps{
                script{
                 sh """
                    git config --global user.name "KashifSad"
                    git config --global user.email "kashraza010@gmail.com"
                    git add deployment.yml
                    git commit -m "change the versionn"
                    """
                    withCredentials([gitUsernamePassword(credentialsId: 'githubcred', gitToolName: 'Default')]){ 
                    sh "git push https://github.com/KashifSad/node-todo-cicd.git master"
                    }
                }
            }
        }
    }
}
