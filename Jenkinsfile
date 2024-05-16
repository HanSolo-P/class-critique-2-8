pipeline {
    agent any
    
    tools {
        // Define the tool versions
        jdk 'JDK11'
        git 'Default'
    }
    
    environment {
        // Define environment variables
        FLUTTER_HOME = 'C:\\fluttersdk\\flutter'
        PATH = "$FLUTTER_HOME\\bin:$PATH"
    }
    
    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/HanSolo-P/class-critique-2-8.git', branch: 'sprint2_professors_page'
            }
        }
        
        stage('Install Dependencies') {
            steps {
                bat 'flutter pub get'
            }
        }
        
        stage('Run Tests') {
            steps {
                bat 'flutter test'
            }
        }
        
        stage('Build APK') {
            steps {
                bat 'flutter build apk --release'
            }
        }
    }
    
    post {
        always {
            archiveArtifacts artifacts: 'build\\app\\outputs\\flutter-apk\\app-release.apk', allowEmptyArchive: true
        }
    }
}
