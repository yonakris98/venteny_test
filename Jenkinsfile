pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Flutter Version') {
            steps {
                bat '''
                git config --global --add safe.directory C:/flutter
                "C:\\flutter\\bin\\flutter.bat" --version
                '''
            }
        }

    }
}