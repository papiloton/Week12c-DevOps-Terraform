# Generates a secure private k ey and encodes it as PEM
resource "tls_private_key" "lightsail_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}
# Create aws key pair comment in aws
resource "aws_key_pair" "ec2_key" {
  key_name = var.key_name
  public_key = tls_private_key.lightsail_key.public_key_openssh
}
# Save my key pair file to current working directory
resource "local_file" "ssh_key" {
  filename = "${aws_key_pair.ec2_key.key_name}.pem"
  content  = tls_private_key.lightsail_key.private_key_pem
}


