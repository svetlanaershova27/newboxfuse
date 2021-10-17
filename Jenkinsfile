pipeline {
  agent {

    docker {
      image 'svetlanaershova/jenkins-agent'
    }

  }

  stages {

    stage('Copy source') {
      steps {
        sh 'ssh-keyscan -H $DEMO1 >> ~/.ssh/known_hosts'
        git 'https://github.com/svetlanaershova27/newboxfuse.git'

      }
    }

    stage('Build war DEMO1') {
      steps {
        sh 'mvn clean package'
      }
    }
    stage ('deploy DEMO1') {
                steps {
                    deploy adapters: [tomcat9(credentialsId: '4acf9d09-3b65-4bfa-ae09-91d4fccea140', path: '', url: 'http://178.154.222.38:8080')], contextPath: 'mywebapp17', war: '**/*.war'
                }
            }
    stage('Make docker image') {
      steps {
        sh 'docker build -t mywebapp17:1.0'
        sh 'docker image tag mywebapp17:1.0 svetlanaershova/mywebapp17:1.0'
        sh '''docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD && docker push svetlanaershova/mywebapp17:1.0'''
      }
    }

    stage('Run docker on DEMO2') {
      steps {
        sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD'
        sh '''ssh-keyscan -H $DEMO2 >> ~/.ssh/known_hosts'
 && docker pull svetlanaershova/mywebapp17:1.0'''
        sh 'docker run -d -p 8080:8080 mywebapp17:1.0'

      }
    }
  }


}