module "network" {
    source = "./modules/network"
}

module "instance" {
    source = "./modules/instance"
    subnet_id = module.network.subnet_id
    vpc_id = module.network.vpc_id
    cidr_ipv4 = module.network.cidr_ipv4
    private_ssh_key = var.private_ssh_key
}