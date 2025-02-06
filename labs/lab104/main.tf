variable "create_vpc" {
  type    = bool
  default = false
}

variable "create_ec2" {
  type    = bool
  default = true
}

variable "YOURNAME" {
  default = "Avi"
}

resource "aws_vpc" "custom_vpc" {
  count = var.create_vpc ? 1 : 0

  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "${var.YOURNAME}-vpc"
  }
}

resource "aws_subnet" "custom_subnet" {
  count = var.create_vpc ? 1 : 0

  vpc_id                  = aws_vpc.custom_vpc[0].id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true # Ensures instances get a public IP automatically

  tags = {
    Name = "${var.YOURNAME}-subnet"
  }
}

data "aws_subnet" "default" {
  filter {
    name   = "default-for-az"
    values = ["true"]
  }
  filter {
    name   = "availability-zone"
    values = ["us-east-1a"]
  }
}

resource "aws_instance" "example" {
  count = var.create_ec2 ? 1 : 0

  ami           = "ami-0c02fb55956c7d316" # Ubuntu AMI
  instance_type = "t2.micro"

  subnet_id = var.create_vpc ? aws_subnet.custom_subnet[0].id : data.aws_subnet.default.id

  associate_public_ip_address = true # 

  tags = {
    Name = "${var.YOURNAME}-ec2"
  }

  depends_on = [aws_vpc.custom_vpc]
}

# OUTPUTS
output "public_ip" {
  value = var.create_ec2 ? aws_instance.example[0].public_ip : "EC2 has no public IP"
}

output "network_info" {
  value = "The following is your VPC ID: ${var.create_vpc ? aws_vpc.custom_vpc[0].id : "default-vpc"} and Subnet ID: ${var.create_vpc ? aws_subnet.custom_subnet[0].id : data.aws_subnet.default.id}"
}
