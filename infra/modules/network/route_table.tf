/* 
  public_aのroute tableを作成
  -----------------------------
  0.0.0.0./0 to internet gateway
  200.0.0.0/16 to local
  -----------------------------
 */

resource "aws_route_table" "public_a" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name ="${var.public_route_table_a["name"]}-rt"
  }
}

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public_a.id
}
