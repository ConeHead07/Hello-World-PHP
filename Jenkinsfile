pipeline {
    agent any

    stages {
        stage('Build and Test') {
            steps {
                script {
                    def workspacePath = env.WORKSPACE.replace('\\', '/')
                    if (workspacePath.startsWith('C:/')) {
                        workspacePath = '/c/' + workspacePath.substring(3)
                    }
                    def containerId = bat(returnStdout: true, script: "MSYS_NO_PATHCONV=1 docker run -d -v ${workspacePath}:/app -w /app php:8.2-fpm tail -f /dev/null").trim()
                    try {
                        echo 'Start der Build- und Test-Phase im Docker-Container...'

                        // 1. Abhängigkeiten installieren
                        bat "docker exec ${containerId} sh -c 'set -x; composer install || { echo \"Fehler bei der Composer-Installation!\"; exit 1; }'"

                        // 2. Unit-Tests ausführen
                        bat "docker exec ${containerId} sh -c 'set -x; ./vendor/bin/phpunit || { echo \"Fehler bei der Ausführung der Unit-Tests!\"; exit 1; }'"
                    } finally {
                        bat "docker stop ${containerId}"
                        bat "docker rm ${containerId}"
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