module "lab"{
    source = "./modules/ec2"
    ami = "ami-0c02fb55956c7d316"
    ingress_ports = [22, 80, 443, 8080]
}

output "printthings"{
    value = module.lab
}