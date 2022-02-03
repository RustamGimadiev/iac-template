resource "aws_dynamodb_table" "locks" {
  name           = "${var.alias}-terragrunt-states-lock-${var.aws_region}"
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_s3_bucket" "states" {
  bucket = "${var.alias}-terragrunt-states-${var.aws_region}"
  acl    = "private"
}
