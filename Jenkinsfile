pipeline {
    agent any

    environment {
        AWS_ACCOUNT_ID = credentials('AWS_ACCOUNT_ID')
        AWS_REGION = credentials('AWS_REGION')
    }

    stages {
        stage('Init') {
            steps {
                echo 'Initializing..'
                echo "Running ${env.BUILD_ID} on ${env.JENKINS_URL}"
                echo "Current branch: ${env.BRANCH_NAME}"
                sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com'
            }
        }
        stage('Build') {
            steps {
                echo 'Building..'
                echo 'Running docker build -t mypythonapp:latest .'
                sh 'docker build -t mypythonapp:latest .'
            }
        }
        stage('Publish') {
            steps {
                echo 'Publishing..'
                echo 'Running docker push..'
                echo 'Publishing image to ECR...'
                sh 'docker tag mypythonapp:latest $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/mypythonapp-repo'
                sh 'docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/mypythonapp-repo'
            }
        }
        stage('Deployment') {
            steps {
                echo 'Create pod on EKS...'
                sh 'kubectl run python-app --image=$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/mypythonapp-repo:latest'
                echo 'Expose pod to port 443...'
                sh 'kubectl expose pod python-app --port 443'
            }
        }
        stage('Cleanup') {
            steps {
                echo 'Cleaning..'
                echo 'Running docker rmi..'
                echo 'Removing unused docker images..'
                // keep intermediate images as cache, only delete the final image
                sh 'docker images -q | xargs --no-run-if-empty docker rmi'
            }
        }
    }
}
