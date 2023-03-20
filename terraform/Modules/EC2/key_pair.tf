resource "tls_private_key" "pk" {
     algorithm = "RSA"
     rsa_bits = 4096
 }

 resource "aws_key_pair" "key" {
   key_name   = "key_pair"
   public_key = tls_private_key.pk.public_key_openssh

   provisioner "local-exec" {
     command = "echo '${tls_private_key.pk.private_key_pem}' > ../Ansible/key_pair.pem"
   }
 }

# resource "aws_secretsmanager_secret" "private_key" {
#   name = "private_key"
# }

# resource "aws_secretsmanager_secret" "public_key" {
#   name = "public_key"
# }

# resource "aws_secretsmanager_secret_version" "private_key_value" {
#   secret_id     = aws_secretsmanager_secret.private_key.id
#   secret_string = tls_private_key.pk.private_key_pem
# }

# resource "aws_secretsmanager_secret_version" "public_key_value" {
#   secret_id     = aws_secretsmanager_secret.public_key.id
#   secret_string = aws_key_pair.key.public_key
# }