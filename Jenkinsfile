pipeline {
    agent any
    
    environment { 
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_KEY_ID')
        FLASK_IMAGE           = '$(aws ssm get-parameter --name /dev/flask-image --query "Parameter.Value" --output text)'
        MYSQL_IMAGE           = '$(aws ssm get-parameter --name /dev/mysql_image --query "Parameter.Value" --output text)'
        REGISTRY_ID           = '$(aws ssm get-parameter --name /dev/registry_id --query "Parameter.Value" --output text)'
        REGION                = "eu-central-1"
        CLUSTER_NAME          = "sprints-eks"
    }
    
    stages{
        stage('Build flask image'){
            steps {
                sh "docker build -t ${FLASK_IMAGE}:latest FlaskApp/."
            }
        }
        
        stage('Build mysql image') {
            steps {
                sh "docker build -t ${MYSQL_IMAGE}:latest db/."
            }
        }
        
        stage('ECR Login') {
            steps {
                sh "aws ecr get-login-password --region ${REGION} | docker login --username AWS --password-stdin ${REGISTRY_ID}.dkr.ecr.${REGION}.amazonaws.com"
            }
        }

        stage('Pushing images to ECR') {
            steps {
                sh "docker push ${FLASK_IMAGE}:latest"
                sh "docker push ${MYSQL_IMAGE}:latest"
            }
        }

        stage('EKS kubeconfig') {
            steps {
                sh "aws eks --region ${REGION} update-kubeconfig --name ${CLUSTER_NAME}"
            }
        }
        
        stage('Updating k8s mainfest'){
            steps {
                echo 'replacing old images with the new one'
                sh "sed -i \"s|image:*|image: ${FLASK_IMAGE}:latest|g\" k8s/deployment.yml"
                sh "sed -i \"s|image:*|image: ${MYSQL_IMAGE}:latest|g\" k8s/statefulset.yml"
            }
        }
        
        stage('Deploy k8s mainfest') {
            steps{
                sh'kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.6.4/deploy/static/provider/aws/deploy.yaml'
                sh'sleep 30'
                sh'kubectl apply -f k8s/.'
                
            }
        }
        
        stage('Getting Service Ip'){
            steps{
                sh """#!/bin/bash
                    kubectl -n ingress-nginx -ojson get service ingress-nginx-controller > sv.json
                    jq '.status.loadBalancer.ingress[0].hostname' sv.json > url.txt
                    sed -i 's/^./http:\\/\\//;s/.\$//' url.txt
                    cat url.txt
                    """
            }
        }    
    }
}
