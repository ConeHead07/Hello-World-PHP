pipeline {
    agent any

    stages {
        stage('Build and Test') {
            steps {
                script {
                    docker.image('php:8.2-fpm').inside("-v ${env.WORKSPACE}:/app -w /app") {
                        echo 'Start der Build- und Test-Phase...'

                        // 1. Abhängigkeiten installieren
                        sh 'set -x; composer install || { echo "Fehler bei der Composer-Installation!"; exit 1; }'

                        // 2. Unit-Tests ausführen
                        sh 'set -x; ./vendor/bin/phpunit || { echo "Fehler bei der Ausführung der Unit-Tests!"; exit 1; }'
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