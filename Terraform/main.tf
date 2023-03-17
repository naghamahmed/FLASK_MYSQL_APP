module "EKS" {
    source = "./Modules/EKS"
    SUBNET_1 = var.SUBNET_1
    SUBNET_2 = var.SUBNET_2
}

module "EC2" {
    source = "./Modules/EC2"
    AZ     = var.AZ
    AMI    = var.AMI
}

module "ECR" {
    source = "./Modules/ECR"
}