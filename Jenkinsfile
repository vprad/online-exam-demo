pipeline {
    agent any

    environment {
        DOCKER_REGISTRY = "docker.io"
        DOCKER_REPOSITORY = "bootcamp"
        DOCKER_IMAGE_NAME = "onlineexam"
        DOCKER_USERNAME = credentials('docker-hub-username')
        DOCKER_PASSWORD = credentials('docker-hub-password')
        DOCKER_TAG = "latest"
        AWS_DEFAULT_REGION = 'us-east-1'
        EKS_CLUSTER_NAME = 'myapp-eks-cluster'
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
                    sh 'docker tag onlineexam:latest pradeepvenk99/bootcamp:latest'
                    sh 'docker push pradeepvenk99/bootcamp:latest'
                    sh 'docker logout'

                }
            }
        }
        stage('Terraform Init') {
            steps {
                script {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    sh 'export AWS_ACCESS_KEY_ID=your-access-key'
                    sh 'export AWS_SECRET_ACCESS_KEY=your-secret-key'
                    sh 'terraform plan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                input 'Proceed with Terraform Apply?'
                script {
                    sh 'terraform apply -auto-approve'
                }
            }
        }

        stage('Deploy to EKS') {
            steps {
                script {
                    sh "aws eks update-kubeconfig --region ${AWS_DEFAULT_REGION} --name ${EKS_CLUSTER_NAME}"
                    sh "kubectl apply -f deployment.yaml"
                }
            }
        }

        stage('Terraform Destroy') {
            steps {
                input 'Proceed with Terraform Destroy?'
                script {
                    sh 'terraform destroy -auto-approve'
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
