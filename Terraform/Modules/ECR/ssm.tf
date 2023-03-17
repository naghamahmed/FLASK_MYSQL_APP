resource "aws_ssm_parameter" "flask_image" {
  name        = "/dev/flask-image"
  description = "flask_image"
  type        = "StringList"
  value       = aws_ecr_repository.flask_repo.repository_url
}

resource "aws_ssm_parameter" "mysql_image" {
  name        = "/dev/mysql_image"
  description = "mysql_image"
  type        = "StringList"
  value       = aws_ecr_repository.mysql_repo.repository_url
}