provider "aws" {
    region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "sreeterraformbucket"
    key    = "pipeline.tfstate"
    region = "us-east-1"
  }
}

data "aws_ami" "my_ami" {
     most_recent      = true
     #name_regex       = "^mavrick"
     owners           = ["721834156908"]
}


resource "aws_instance" "web-1" {
    ami = "${data.aws_ami.my_ami.id}"
    #ami = "ami-0d857ff0f5fc4e03b"
    availability_zone = "us-east-1a"
    instance_type = "t2.micro"
    key_name = "LaptopKey"
    subnet_id = "subnet-0596d277b10eedf7f"
	private_ip = "10.1.1.111"
    vpc_security_group_ids = ["sg-08944ea9f10aa4121"]
    associate_public_ip_address = true	
    tags = {
        Name = "Server-1"
        Env = "Prod"
        Owner = "Sree"
    }
}
