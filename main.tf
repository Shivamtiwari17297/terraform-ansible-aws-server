provider "aws" {
  region = "us-east-1"
}

# Variables for existing resources
variable "vpc_id" {
  description = "ID of the existing VPC"
  default     = "vpc-02d9ba865bd886310"  # Replace with your existing VPC ID
}

variable "subnet_a_id" {
  description = "ID of the existing subnet A"
  default     = "subnet-08624f3ea79a650c6"  # Replace with your existing subnet A ID
}

variable "subnet_b_id" {
  description = "ID of the existing subnet B"
  default     = "subnet-0c1d1e3c7f5d4e2df"  # Replace with your existing subnet B ID
}

variable "security_group_instance_id" {
  description = "ID of the existing Instance Security Group"
  default     = "sg-05003d578620a6517"  # Replace with your existing Instance Security Group ID
}

variable "igw_id" {
  description = "ID of the existing Internet Gateway"
  default     = "igw-0d341c342e1331e7f"  # Replace with your existing Internet Gateway ID
}

variable "route_table_id" {
  description = "ID of the existing Route Table"
  default     = "rtb-00caf7699da658465"  # Replace with your existing Route Table ID
}

variable "key_name" {
  description = "Name of the existing SSH key pair"
  default     = "an"  # Replace with your key pair name
}

# EC2 Instance
resource "aws_instance" "web" {
  ami           = "ami-0182f373e66f89c85"  # Replace with your desired AMI ID
  instance_type = "t3.medium"
  subnet_id     = var.subnet_a_id
  security_groups = [var.security_group_instance_id]
  key_name       = var.key_name  # Add this line
  tags = {
    Name = "web-instance"
  }
}

# EBS Volume
resource "aws_ebs_volume" "existing_volume" {
  availability_zone = "us-east-1"  # Ensure this matches the instance's AZ
  size              = 8  # Size in GB
  type              = "gp3"  # General Purpose SSD
}

# Volume Attachment
#resource "aws_volume_attachment" "existing_volume_attachment" {
 # device_name = "/dev/xvda"
  #volume_id   = "vol-05baf0527fb207ac7"  # Replace with your existing EBS volume                                                                              ID
  #instance_id = aws_instance.web.id
#}

# Route Table Associations
resource "aws_route_table_association" "rta_a" {
  subnet_id      = var.subnet_a_id  # Use the existing subnet ID
  route_table_id = var.route_table_id  # Use the existing Route Table ID
}

resource "aws_route_table_association" "rta_b" {
  subnet_id      = var.subnet_b_id  # Use the existing subnet ID
  route_table_id = var.route_table_id  # Use the existing Route Table ID
}
