resource "aws_security_group" "instance" {
  name = "terraform-example-instance"
  ingress {
    from_port = var.server_port
    protocol = "tcp"
    to_port = var.server_port
    cidr_blocks = [
      "0.0.0.0/0"]
  }
  tags = {
    Name = "instance_security"
  }
}
resource "aws_instance" "single_server" {
  ami = "ami-40d28157"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]
  user_data = <<-EOF
              #!/bin/bash
              echo "Hello World" > index.html
              nohup busybox httpd -f -p "${var.server_port}" &
              EOF

  //add a name of the instance
  tags = {
    Name = "terraform_single_server"
  }
}