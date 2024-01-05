/* 
  パブリックサブネット
  CIDRブロック: 200.0.1.0/24
 */

resource "aws_subnet" "public_subnet_a" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_a["cidr_block"]
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = var.public_subnet_a["name"]
  }
}
