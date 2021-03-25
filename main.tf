provider "aws" {
    region = "us-east-1"
}

/*terraform {
  backend "s3" {
    bucket = "sreeterraformbucket"
    key    = "pipeline.tfstate"
    region = "us-east-1"
  }
}*/

data "aws_ami" "my_ami" {
     most_recent      = true
     #name_regex       = "Arundevlops"
     owners           = ["605806863122"]
}


resource "aws_instance" "web-1" {
    ami = "${data.aws_ami.my_ami.id}"
    #ami = "ami-0d857ff0f5fc4e03b"
    availability_zone = "us-east-1a"
    instance_type = "t2.micro"
    key_name = "key"
    subnet_id = "subnet-0c35462810597f8a7"
	private_ip = "10.0.0.11"
    vpc_security_group_ids = ["sg-081d874143b1e7d59"]
    associate_public_ip_address = true	
    tags = {
        Name = "Server-1"
        Env = "Prod"
        Owner = "Sree"
    }
}
