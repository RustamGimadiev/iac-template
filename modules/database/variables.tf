variable "db_name" {
  type        = string
  description = "A name of the database"
}

variable "parameter_group_name" {
  type    = string
  default = "default.mysql5.7"
}
