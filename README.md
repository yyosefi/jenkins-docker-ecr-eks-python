# jenkins-docker-ecr-eks-python
Jenkins pipeline to creae a docker image of a Python app and publish it to ECR and deploy it to EKS

## How it works

The pipeline assumes the following prerequisites:
- AWS_ACCOUNT_ID credential (secret) is created in Jenkins with the value of the AWS Account ID
- AWS_REGION credential (secret) is created in Jenkins with the value of the region of the AWS ECR repo
- AWS cli is installed on the Jenkins master and or on the agents running the pipeline
- kubectl is installed and configured to communicate with the EKS cluster
- ECR repository name is mypythonapp-repo
- EKS cluster / EC2 nodes can access ECR repository or using a ServiceAccount with imagePullSecrets entry that reference to a secret with AWS ECR credentials 
