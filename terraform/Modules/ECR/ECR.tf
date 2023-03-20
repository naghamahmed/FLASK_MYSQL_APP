resource "aws_ecr_repository" "flask_repo" {
  name                 = "flask-app"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "mysql_repo" {
  name                 = "mysqldb"

  image_scanning_configuration {
    scan_on_push = true
  }
}