
module "ec2" {
  source = "./modules/ec2"

  # EC2インスタンスの設定   
  ec2 = {
    "name"          = "${var.env}-${var.prefix}-ec2"
    "ami"           = "ami-0dfa284c9d7b2adad"
    "instance_type" = "t2.micro"
  }

  # セキュリティグループの設定   
  ec2_security_group_name = "${var.env}-${var.prefix}-ec2-sg"

  # ネットワークの設定 
  vpc_id             = module.network.vpc_id
  public_subnet_a_id = module.network.public_subnet_a_id
}



module "network" {
  source = "./modules/network"
  vpc = {
    "name"       = "${var.env}-${var.prefix}-vpc"
    "cidr_block" = "200.0.0.0/16"
  }

  public_subnet_a = {
    name       = "${var.env}-${var.prefix}-public-subnet-a"
    cidr_block = "200.0.1.0/24"
  }

  igw_name = "${var.env}-${var.prefix}-igw"

  public_route_table_a = {
    name = "${var.env}-${var.prefix}-public-route-table-a"
  }

}


