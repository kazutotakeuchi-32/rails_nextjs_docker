# EC2インスタンスの作成
resource "aws_instance" "this" {
  ami           = var.ec2["ami"]
  instance_type = var.ec2["instance_type"]
  subnet_id     = var.public_subnet_a_id
  vpc_security_group_ids = [
    aws_security_group.this.id
  ]

  tags = {
    Name = var.ec2["name"]
  }

  # ssh接続用のキーを指定   
  key_name = aws_key_pair.this.key_name
}

# キーペアの作成
resource "aws_key_pair" "this" {
  key_name   = var.key_name
  public_key = file("${var.key_name}.pub")
}

resource "aws_eip" "this" {
  instance = aws_instance.this.id
}

resource "aws_route53_record" "this" {
  zone_id = "Z0211538IASZO386CCKR"
  name    = "ec2-test.${var.domain_name}"
  type    = "A"
  ttl     = "300"
  records = [aws_eip.this.public_ip]
}

