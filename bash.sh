#! /bin/bash
cd terraform
terraform init
terraform apply --var-file variables.tfvars --auto-approve
cd ../Ansible
chmod 400 key_pair.pem
ansible-playbook -i inventory main.yml
