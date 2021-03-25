pipeline {
    agent any
    stages {
		stage('Packer Build AMI') {
          steps {
            
            sh 'pwd'
            sh 'ls -al'
            sh 'packer build packer.json'
            }
        }
				
		stage('Deploy EC2 Server') {
          steps {
		        sh 'terraform init -backend=false'
            sh 'terraform plan'
            sh 'terraform apply --auto-approve'
            }
        }

        stage('Build Docker Image') {
          steps {
            sh 'docker build -t sreeharshav/devopsb15:${BUILD_NUMBER} .'
            }
        }

        stage('Push Image to Docker Hub') {
          steps {
           sh    'docker push sreeharshav/devopsb15:${BUILD_NUMBER}'
           }
        }

        stage('Deploy to Docker Host') {
          steps {
		    sh 'sleep 30s'
            sh    'docker -H tcp://10.1.1.111:2375 stop prodwebapp1 || true'
            sh    'docker -H tcp://10.1.1.111:2375 run --rm -dit --name prodwebapp1 --hostname prodwebapp1 -p 8000:80 sreeharshav/devopsb15:${BUILD_NUMBER}'
            }
        }

        stage('Check WebApp Rechability') {
          steps {
          sh 'sleep 10s'
          sh ' curl http://10.1.1.111:8000'
          }
        }

    }
}
