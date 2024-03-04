pipeline{
    agent any
    stages{
        stage("Checkout"){
            steps{
                git 'https://github.com/mmohei24/BMI.git'
            }
        }
        stage("Build The App"){
            steps{
                sh 'mvn clean package'
            }
        }
        stage('JUnit Tests'){
                steps {
                    junit '**/target/surefire-reports/TEST-*.xml'
                    archiveArtifacts 'target/*.jar'
                }
        }
        stage("Build Docker Image"){
            steps{
                sh 'docker build -t mmohei24/study:$BUILD_NUMBER .'
            }
        }
        stage('Login To Dockerhub'){
            steps{
                withCredentials([usernamePassword(credentialsId:'dockerhub-credintial', usernameVariable:'USERNAME', passwordVariable: 'PASSWORD')]){
                sh'echo $PASSWORD | docker login -u $USERNAME --password-stdin'
                }
            }
        }
        stage("Push Docker Image"){
            steps{
                sh 'docker push mmohei24/study:$BUILD_NUMBER'
            }
        }
    }
    post{
        always{
            sh 'docker logout'
        }
    }
}
