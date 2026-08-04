pipeline {
    agent any

    options {
        disableConcurrentBuilds()
        timeout(time: 60, unit: 'MINUTES')
    }

    environment {
        REPOSITORY_URL    = 'https://github.com/yonakris98/venteny_test.git'
        REPOSITORY_BRANCH = 'main'

        FLUTTER_HOME = 'C:\\flutter'

        SPARROW_HOME = 'C:\\Yonatan\\Sparrow\\StealienIndonesia\\sparrow-enterprise-client-windows-2606.1'
        SPARROW_SERVER = 'https://192.168.100.103:10880'

        SPARROW_PROJECT_KEY = 'project-1'
        SPARROW_PROFILE = 'All Tasks and Detection Rules'
        SPARROW_USER = 'admin'
    }

    stages {
        stage('Clean Workspace') {
            steps {
                deleteDir()
            }
        }

        stage('Checkout') {
            steps {
                git branch: "${REPOSITORY_BRANCH}",
                    url: "${REPOSITORY_URL}"
            }
        }

        stage('Prepare') {
            steps {
                bat 'git config --global --add safe.directory C:/flutter'
            }
        }

        stage('Flutter Version') {
            steps {
                bat '"C:\\flutter\\bin\\flutter.bat" --version'
            }
        }

        // Aktifkan lagi nanti jika dependency Flutter sudah beres
        /*
        stage('Flutter Pub Get') {
            steps {
                bat '"C:\\flutter\\bin\\flutter.bat" pub get'
            }
        }

        stage('Flutter Analyze') {
            steps {
                bat '"C:\\flutter\\bin\\flutter.bat" analyze'
            }
        }

        stage('Flutter Build') {
            steps {
                bat '"C:\\flutter\\bin\\flutter.bat" build apk --debug'
            }
        }
        */

        stage('Test Sparrow Connection') {
            steps {
                powershell '''

        Write-Host "Testing Sparrow Server..."

        Test-NetConnection 192.168.100.103 -Port 10880

        '''
            }
        }

        stage('Sparrow SAST Analysis') {
            steps {
                powershell '''

                $ErrorActionPreference = "Stop"

                $cli = Join-Path $env:SPARROW_HOME "sparrow-cli.cmd"

                if (!(Test-Path $cli)) {
                    throw "Sparrow CLI not found: $cli"
                }

                Write-Host "====================================="
                Write-Host "Starting Sparrow SAST Analysis..."
                Write-Host "====================================="

                $password = "1Q2w3e4r!"

                $command = @"
$password
"@

                $command | & $cli `
                    create analysis `
                    -s $env:SPARROW_SERVER `
                    -u $env:SPARROW_USER `
                    -k $env:SPARROW_PROJECT_KEY `
                    --type full `
                    --profile "$env:SPARROW_PROFILE" `
                    --target-type file `
                    --path "$env:WORKSPACE" `
                    --extension dart `
                    --tag "Jenkins"

                if ($LASTEXITCODE -ne 0) {
                    throw "Sparrow Scan Failed."
                }

                '''
            }
        }
    }

    post {
        success {
            echo '========================================'
            echo 'Pipeline SUCCESS'
            echo 'Flutter Build OK'
            echo 'Sparrow Scan Submitted'
            echo '========================================'
        }

        failure {
            echo '========================================'
            echo 'Pipeline FAILED'
            echo 'Check Console Output'
            echo '========================================'
        }

        always {
            cleanWs()
        }
    }
}
