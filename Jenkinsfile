
pipeline {
    agent any

    environment {
        APP_NAME = "gs-maven"
        WAR_FILE = "target/gs-maven-0.1.0.war"  // full path in workspace
        DOCKER_IMAGE = "gs-maven-app:latest"
        DOCKER_CONTAINER = "gs-maven-container"
        REMOTE_USER = "ubuntu"
        REMOTE_HOST = "16.171.129.229"
        SSH_KEY = "/var/lib/jenkins/.ssh/id_ed25519"
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main', url: 'git@github.com:Darshansv17/java_project.git'
            }
        }

        stage('Build WAR') {
            steps {
                sh 'mvn clean package'
                sh 'ls -l target/'  // verify WAR is generated
            }
        }

        stage('Run Tests') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image..."
                sh """
                docker build \
                    --build-arg WAR_FILE=${WAR_FILE} \
                    -t ${DOCKER_IMAGE} .
                """
            }
        }

        stage('Push Docker Image (Optional)') {
            steps {
                // If you have a Docker registry, you can push here
                echo "Skipping push step (optional)"
            }
        }

        stage('Deploy to EC2-B') {
            steps {
                echo "Deploying Docker container to EC2-B..."
                sh """
                ssh -i ${SSH_KEY} -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_HOST} '
                    docker stop ${DOCKER_CONTAINER} || true
                    docker rm ${DOCKER_CONTAINER} || true
                    docker run -d --name ${DOCKER_CONTAINER} -p 8080:8080 ${DOCKER_IMAGE}
                '
                """
            }
        }
    }

    post {
        success {
            echo "Deployment successful! Open http://${REMOTE_HOST}:8080/"
        }
        failure {
            echo "Deployment failed!"
        }
    }
}
