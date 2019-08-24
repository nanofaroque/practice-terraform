provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami = "ami-40d28157"
  instance_type = "t2.micro"
  //add a name of the instance

  tags =  {
    Name = "terraform-example"
  }
}
