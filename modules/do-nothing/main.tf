resource "null_resource" "this" {
  provisioner "local-exec" {
    command = "echo 'Hello Terraform!'"
  }
}

resource "local_file" "this" {
  filename = "${path.root}/empty.json"
  content  = jsonencode({})
}
