pipeline {
    agent any

    stages {
        stage('Build and Test') {
            steps {
                script {
                    def containerId = sh(returnStdout: true, script: "docker run -d -v ${env.WORKSPACE}:/app -w /app php:8.2-fpm tail -f /dev/null").trim()
                    try {
                        echo 'Start der Build- und Test-Phase im Docker-Container...'

                        // 1. Abhängigkeiten installieren
                        sh "docker exec ${containerId} sh -c 'set -x; composer install || { echo \"Fehler bei der Composer-Installation!\"; exit 1; }'"

                        // 2. Unit-Tests ausführen
                        sh "docker exec ${containerId} sh -c 'set -x; ./vendor/bin/phpunit || { echo \"Fehler bei der Ausführung der Unit-Tests!\"; exit 1; }'"
                    } finally {
                        sh "docker stop ${containerId}"
                        sh "docker rm ${containerId}"
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