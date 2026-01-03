pipeline {
    agent any

    stages {
        stage('Build & Test & Package') {
            steps {
                // Compile, test, and package into WAR
                sh 'mvn clean package'
            }
        }
    }

    post {
        success {
            // Archive the WAR file
            archiveArtifacts artifacts: 'target/*.war', fingerprint: true
        }
    }
}


