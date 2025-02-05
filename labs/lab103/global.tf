provider "aws" {
 region = var.region
}

variable "region" {
 default = "us-east-1"
}

data "aws_ami" "my-privateami"{
    owners = [ "self" ]
    filter{
        name = "name"
        values = "terraform-workshop-image-do-not-delete"
    }
}

output "yanivami"{
    value = data.aws_ami.my-privateami.id
}

variable "ami" {
 default = "ami-0ecc0e0d5986a576d"
}

variable "vm_name" {
 default = "vm-avi"
}

variable "admin_username" {
 default = "admin-user"
}

variable "admin_password" {
 default = "Password123!"
}

variable "vm_size" {
 default = "t2.micro"
}

