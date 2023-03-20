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
  
  - Configure the pipeline using SCM
  
  

  









