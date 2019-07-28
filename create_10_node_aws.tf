# declaring the provider with the region

provider "aws" {
  region = "us-west-2"
}

# In AWS EC2, IAM, VPC and etc all are resource
# ami- is the EC2 AMI, you can get it from AWS console
# count- number of instance, you want to create
# instance_type-type of the instance

resource "aws_instance" "example" {
  count = 0
  ami = "ami-0f2176987ee50226e"
  instance_type = "t2.micro"
}
