module "lab"{
    source = "./modules/ec2"
    ami = "ami-0c02fb55956c7d316"
    #region = "west"
}

output "printthings"{
    value = module.lab
}