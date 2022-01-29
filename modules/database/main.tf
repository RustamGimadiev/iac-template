resource "aws_db_instance" "db" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  name                 = var.db_name
  username             = "admin"
  password             = random_password.db.result
  parameter_group_name = aws_db_parameter_group.db.name
  skip_final_snapshot  = true
}

resource "aws_db_parameter_group" "db" {
  name_prefix = "${var.db_name}-"
  family      = "mysql5.7"
}
resource "random_password" "db" {
  length = 16
}
