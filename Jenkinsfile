pipeline {
    agent any
    
    tools {
        // Define the tool versions
        jdk 'JDK11'
        git 'Default'
    }
    
    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/HanSolo-P/class-critique-2-8.git', branch: 'sprint2_professors_page'
            }
        }
        
        stage('Install Dependencies') {
            steps {
                sh 'flutter pub get'
            }
        }
        
        stage('Build APK') {
            steps {
                sh 'flutter build apk --release'
            }
        }
    }
    
    post {
        always {
            archiveArtifacts artifacts: 'build\\app\\outputs\\flutter-apk\\app-release.apk', allowEmptyArchive: true
        }
    }
}
