pipeline {
  agent {

    dockerfile {
        filename 'Dockerfile1'
        registryCredentialsId 'd4f1a006-c286-4e5b-a55d-a390cbd58862'
        registryUrl 'https://hub.docker.com/repository/docker/svetlanaershova/myimage'
      }
    }
  }

  stages {

    stage('Copy source') {
      steps {
        sh 'ssh-keyscan -H $DEMO1 >> ~/.ssh/known_hosts'
        git 'https://github.com/svetlanaershova27/newboxfuse.git'

      }
    }


    stage('Make docker image') {
      steps {
        sh 'docker build -t mywebapp17:1.0 .'
        sh 'docker image tag mywebapp17:1.0 svetlanaershova/mywebapp17:1.0'
        sh 'docker push svetlanaershova/mywebapp17:1.0'
      }
    }

    stage('Run docker on DEMO2') {
      steps {

        sh '''ssh-keyscan -H $DEMO2 >> ~/.ssh/known_hosts'
 && docker pull svetlanaershova/mywebapp17:1.0'''
        sh 'docker run -d -p 8080:8080 mywebapp17:1.0'


      }
    }
  }


}