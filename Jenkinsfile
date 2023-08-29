pipeline {
    agent any

    environment {
        DOCKER_REGISTRY = "docker.io"
        DOCKER_REPOSITORY = "bootcamp"
        DOCKER_IMAGE_NAME = "onlineexam"
        DOCKER_USERNAME = credentials('docker-hub-username')
        DOCKER_PASSWORD = credentials('docker-hub-password')
        DOCKER_TAG = "latest"
    }

    stages {
        stage('Clone Repository') {
            steps {
                checkout scm
            }
        }

        stage('Build and Test with Gradle') {
            steps {
                sh 'chmod +x ./gradlew'
                sh './gradlew clean build'
            }
        }

        stage('Dockerize') {
            steps {
                script {
                    /*docker.withRegistry("${DOCKER_REGISTRY}", "${DOCKER_USERNAME}", "${DOCKER_PASSWORD}") {
                        def customImage = docker.build("${DOCKER_USERNAME}/${DOCKER_REPOSITORY}:${env.BUILD_NUMBER}", ".")
                        customImage.push()*/
                    sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD'
                    sh 'docker build -t ${DOCKER_IMAGE_NAME} .'
                    sh 'docker tag ${DOCKER_IMAGE_NAME}:${DOCKER_TAG} ${DOCKER_REGISTRY}/${DOCKER_IMAGE_NAME}:${DOCKER_TAG}'
                    sh 'docker push pradeepvenk99/${DOCKER_REPOSITORY}:${DOCKER_TAG}'
                    sh 'docker logout'

                }
            }
        }
    }

    post {
        always {
            script {
                sh 'docker logout'
            }
        }
    }
}
