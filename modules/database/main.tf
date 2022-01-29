resource "aws_db_instance" "db" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  name                 = var.db_name
  username             = "admin"
  password             = random_password.db.result
  parameter_group_name = var.parameter_group_name
  skip_final_snapshot  = true
}

resource "random_password" "db" {
  length = 16
}
