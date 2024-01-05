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

  key_name = aws_key_pair.this.key_name
}

resource "aws_key_pair" "this" {
  key_name   = var.key_name
  public_key = file("${var.key_name}.pub")
}
