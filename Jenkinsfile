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
                    bat "docker run -d -v ${workspacePath}:/app -w /app php:8.2-fpm tail -f /dev/null > cid.txt"
                    def containerId = readFile('cid.txt').readLines()[0].trim()
                    // def containerId = readFile('cid.txt').trim()
                    // def containerId = bat(returnStdout: true, script: "docker run -d -v ${workspacePath}:/app -w /app php:8.2-fpm tail -f /dev/null").trim()
                    echo "Docker-Container gestartet: ${containerId}"
                    try {
                        echo 'Start der Build- und Test-Phase im Docker-Container...'

                        // 1. Fehlende Tools installieren (vor Composer!)
                        bat "docker exec ${containerId} sh -c \"apt-get update && apt-get install -y unzip git\""

                        // 2. Composer installieren
                        bat "docker exec ${containerId} sh -c \"php -r \\\"copy('https://getcomposer.org/installer', 'composer-setup.php');\\\" && php composer-setup.php --install-dir=/usr/local/bin --filename=composer && rm composer-setup.php\""

                        // 3. Abhängigkeiten installieren
                        bat "docker exec ${containerId} sh -c \"set -x; composer install || { echo 'Fehler bei der Composer-Installation!'; exit 1; }\""

                        // // 1. Abhängigkeiten installieren
                        // bat "docker exec ${containerId} sh -c \"apt-get update && apt-get install -y unzip git\""
                        // bat "docker exec ${containerId} sh -c \"php -r \\\"copy('https://getcomposer.org/installer', 'composer-setup.php');\\\" && php composer-setup.php --install-dir=/usr/local/bin --filename=composer && rm composer-setup.php\""
                        // bat "docker exec ${containerId} sh -c \"set -x; composer install || { echo 'Fehler bei der Composer-Installation!'; exit 1; }\""

                        // 2. Unit-Tests ausführen
                        bat "docker exec ${containerId} sh -c \"set -x; ./vendor/bin/phpunit --log-junit junit.xml || { echo 'Fehler bei der Ausführung der Unit-Tests!'; exit 1; }\""
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