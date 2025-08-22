pipeline {
    agent any

    stages {
        stage('Build and Test') {
            steps {
                script {
                    docker.image('php:8.2-fpm').inside {
                        echo 'Start der Build- und Test-Phase...'

                        // 1. Abhängigkeiten installieren
                        sh 'composer install'

                        // 2. Unit-Tests ausführen
                        sh './vendor/bin/phpunit'
                    }
                }
            }
            post {
                always {
                    junit 'junit.xml'
                }
                success {
                    echo 'Alle Tests wurden erfolgreich ausgeführt.'
                }
                failure {
                    echo 'Die Tests sind fehlgeschlagen. Pipeline wird gestoppt.'
                }
            }
        }

        stage('Deploy') {
            steps {
                echo 'Beginne mit der Bereitstellung...'
                echo 'Bereitstellung erfolgreich!'
            }
        }
    }
}