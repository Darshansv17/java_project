pipeline {
    agent any

    stages {
        stage('cloning from git') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'git@github.com:Darshansv17/java_project.git']])
            }
        }
        stage('build') {
            steps {
                sh 'mvn clean install'
            }
        }
     
        stage('Remove old Container and image') {
             steps {
                 sh '''
                  # Stop and remove existing container if it exists
                  docker stop java-tomcat-container || true
                  docker rm java-tomcat-container || true
                  docker rmi java-tomcat-app 
                  '''
             }
        } 
        stage('Build Docker Image') {
             steps {
                 sh '''
                  docker build -t java-tomcat-app \
                  --build-arg WAR_FILE=target/*.war .
                   '''
            }
        }
        
           stage('run new container'){
             steps{
                  sh '''  
                  # Run new container
                  docker run -d \
                 --name java-tomcat-container \
                 -p 8081:8080 \
                 java-tomcat-app
                  '''
            }
        }
    }
}


