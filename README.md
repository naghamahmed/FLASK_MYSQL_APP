# MySQL-and-Flask

Mysql and Flask app deployed on AWS using  EKs Cluster using ECR private repositary, using terraform and ansible to provision the infastrusture and configure the EC2 to be configured as Jenkins Master and deploying eth app, 
Deployed the App through jenkins pipeline by
- bulding mysql and flask images.
- pushing images to ECr repositaries. 
- apply k8s mainfest.
- Triggering jenkins pipleline using github-webhook

# AWS Infrastructure 

- using default VPC 
- EKS with 2 worker nodes
- 2 private REPO ECR
- EC2 with SG and IAM role to allow jenkins deploying on ECR and EKS

# Kubernetes Mainfest
- Deployment for flask-app image with readiness and liveness
- ClusterIP service selects the deployment's pod
- Statefulset for mysql image with (pv and pvs)
- ClusterIP service selects the statefulset's pod
- Ingress using nginx-controller

# Convert the app into dockerized application

The app is copied from the tutorial http://code.tutsplus.com/tutorials/creating-a-web-app-from-scratch-using-python-flask-and-mysql--cms-22972

build Flask image and mysql image with database table 
run 
```
docker-compose up --build
```
to test the app local but the url in the Browser
```
localhost:5002
```
![Screenshot from 2023-03-20 17-02-43](https://user-images.githubusercontent.com/110065223/226381379-887c4895-f1b0-400c-8c76-dcab1ec4ed95.png)


# Terraform and Ansible (IAC)

- using Bash Script to apply Terraform and Ansible 

```
sudo chmod +x bash.sh
```

- Ansible will appear msg with jenkins password

![Screenshot from 2023-03-20 16-55-40](https://user-images.githubusercontent.com/110065223/226382091-7c62f0a7-4432-4a5f-b1b8-b0ba1405cfb8.png)

- Put jenkins-ec2-public-IP:8080 in the Browser and login the password

![Screenshot from 2023-03-20 15-20-12](https://user-images.githubusercontent.com/110065223/226382661-3c2c8412-67eb-48e0-aedd-f8d54010be5a.png)

# Configuring Jenkins Pipeline

- Installing suggusted Plugins and Creating user from the browser when loggin in

- Adding AWS credentials in secret text 

- Adding Github credentials with github-token

  **Dashboard > Manage Jenkins > Credentials > system > Global credentials (unrestricted) + Add Credentials**
  
  ![Screenshot from 2023-03-20 15-28-31](https://user-images.githubusercontent.com/110065223/226387487-06627794-9707-4668-b13b-a8b7b706c2b2.png)
  
  - Configure the pipeline using SCM and Build Triggers 

![Screenshot from 2023-03-20 17-58-48](https://user-images.githubusercontent.com/110065223/226398091-657f6b51-1f3a-4135-aa4e-8f9ea5be79f9.png)
![Screenshot from 2023-03-20 17-58-57](https://user-images.githubusercontent.com/110065223/226398101-a236007f-b04b-409a-9c87-3bc6e631c73d.png)

# Using Github Webhook to trigger jenkins

from repo"s settings adding webhoob with jenkins's

![Screenshot from 2023-03-20 15-33-03](https://user-images.githubusercontent.com/110065223/226398814-68eeac01-60b2-44ad-bb54-0eb2d8994fc6.png)

# Commit to the repo by uploading Jenkinisfile

the pipeline will be triggered and Build
jenkinsfile stages
- Build images (flask and mysql)
- Login to ECR
- Push images to ECR
- Get kubeconfig
- Installing nginx-controller for AWS
- Apply K8S Mainfest
- Output the App URL in the console output

![Screenshot from 2023-03-20 18-29-46](https://user-images.githubusercontent.com/110065223/226406587-e0048b4a-51ec-470d-91d8-e1ed8959b71d.png)


![Screenshot from 2023-03-20 15-55-19](https://user-images.githubusercontent.com/110065223/226399249-50cd2193-8940-41c8-86cf-bc15024bf034.png)

# Accessing the app URL

![Screenshot from 2023-03-20 15-57-09](https://user-images.githubusercontent.com/110065223/226400367-9d789aa5-fadd-43ee-bb30-bf768865c083.png)
![Screenshot from 2023-03-20 15-56-41](https://user-images.githubusercontent.com/110065223/226401687-1efda1aa-a6fa-4995-8c54-f58d4f2ffc14.png)


# Checking the app liveness and readiness

![Screenshot from 2023-03-20 15-54-42](https://user-images.githubusercontent.com/110065223/226400531-08d5baa3-9377-4c4c-9549-5f52e6c6dddd.png)




