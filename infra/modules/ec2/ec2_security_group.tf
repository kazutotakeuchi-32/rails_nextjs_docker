/* 
  ec2のセキュリティグループを作成する
  インバウンドルール
  -----------------------------
  HTTP TCP  80 Ipv4 0.0.0.0/0
  SSH  TCP  22 Ipv4 0.0.0.0/0
  icmp ALL ALL Ipv4
  -----------------------------

  アウトバウンドルール
  -----------------------------
  80: HTTP Ipv4 0.0.0.0./0
  443: HTTPS Ipv4 0.0.0.0/0
  ICMP ALL ALL Ipv4
  -----------------------------
 */

resource "aws_security_group" "this" {

  depends_on  = [var.vpc_id, var.public_subnet_a_id]
  name        = var.ec2_security_group_name
  description = "security group for terraform-ec2"

  vpc_id = var.vpc_id

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["0::/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   ingress {
    description = "ICMP"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
   }


  egress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["0::/0"]
  }

  egress {
    description = "ICMP"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }


}
