provider "aws" {
    region = var.region
}

variable "region" {
    default = "us-east-1"
}


# Define a data source to fetch an existing Azure Public IP
data "yaniv_ip" "lab" {
    filter{
        name = "tag:Name"
        values = ["yaniv-vm"]
    }
}

# Reference the IP address later in the configuration
output "public_ip_address" {
    value = data.yaniv_ip.public_ip
}


variable "nullvar" {
    default="sap"
}

resource "null_resource" "step_1" {
    provisioner "local-exec" {
        command = <<EOT
        if [ -z "${var.nullvar}" ]; then
            echo "ERROR: Public IP address was not assigned." >&2
            exit 1
        fi
        EOT
    }

    depends_on = [aws_instance.vm]
}