pipeline {
    agent {
        docker {
            image 'php:8.2-fpm'
        }
    }

    stages {
        stage('Build and Test') {
            steps {
                echo 'Start der Build- und Test-Phase...'

                // 1. Abhängigkeiten installieren
                sh 'composer install'

                // 2. Unit-Tests ausführen
                // PHPUnit muss über Composer installiert sein
                sh './vendor/bin/phpunit'
            }
            post {
                always {
                    // Test-Bericht im Jenkins-Dashboard anzeigen
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
                // Simulation einer Bereitstellung
                // Hier können Befehle wie "rsync" oder "scp" verwendet werden
                // sh 'cp -r . /var/www/html/helloworld-app'
                echo 'Bereitstellung erfolgreich!'
            }
        }
    }
}