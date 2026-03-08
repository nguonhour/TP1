pipeline {
    agent {
        label 'laravel-agent'
    }

    options {
        skipDefaultCheckout(true)
        timestamps()
    }

    environment {
        APP_DIR = 'laravel-agent'
        COMPOSER_ALLOW_SUPERUSER = '1'
    }

    stages {
        stage('Prepare') {
            steps {
                echo 'Checking out code...'
                checkout scm
            }
        }

        stage('Install PHP & Node Dependencies') {
            steps {
                dir(env.APP_DIR) {
                    sh 'composer install --no-interaction --prefer-dist --optimize-autoloader'
                    sh 'npm ci'
                    sh 'cp .env.example .env'
                    sh 'php artisan key:generate --ansi'
                }
            }
        }

        stage('Build Frontend Assets') {
            steps {
                dir(env.APP_DIR) {
                    sh 'npm run build'
                }
            }
        }

        stage('Run Tests') {
            steps {
                dir(env.APP_DIR) {
                    echo 'Running Laravel tests...'
                    sh 'php artisan config:clear --ansi'
                    sh 'php artisan test --compact'
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished'
        }
        success {
            echo 'All tests passed'
        }
        failure {
            echo 'Some tests failed'
        }
    }
}