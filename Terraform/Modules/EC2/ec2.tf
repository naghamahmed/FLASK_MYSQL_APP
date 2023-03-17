resource "aws_instance" "jenkins" {
  ami                         = var.AMI
  instance_type               = "t2.micro"
  key_name                    = "key"
  vpc_security_group_ids      = ["${aws_security_group.sg.id}"]
  associate_public_ip_address = true
  availability_zone           = var.AZ
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name

  tags = {
    Name = "sprints"
  }

  depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_worker_node_policy_general,
    aws_iam_role_policy_attachment.amazon_eks_cni_policy_general,
    aws_iam_role_policy_attachment.amazon_ec2_container_registry_read_only,
  ]

  
  provisioner "local-exec" {
    command = "echo ${self.public_ip}"
  }
}