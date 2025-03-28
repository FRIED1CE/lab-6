pipeline {
  agent any

  stages {
    stage('deploy') {
      steps {
        sh 'chmod +x ./deploy.sh'
        sh 'deploy.sh'
      }
    }
    stage('check deployment'){
      steps{
        sh 'docker ps -a'
      }
    }
  }
}
