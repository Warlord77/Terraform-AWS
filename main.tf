resource "aws_instance" "my-test-instance" {
  ami             = "${data.aws_ami.ubuntu.id}"
  instance_type   = "t2.micro"

  tags = { 
    Name = "Test"
  }
}

resource "aws_vpc" "My_VPC" {
  cidr_block           = "${var.vpcCIDRblock}"
  instance_tenancy     = "${var.instanceTenancy}" 
  enable_dns_support   = "${var.dnsSupport}" 
  enable_dns_hostnames ="${var.dnsHostNames}"
  
  tags = {
    Name = "My VPC"
  }
} 

resource "aws_subnet" "My_VPC_Subnet" {
  vpc_id                  = "${aws_vpc.My_VPC.id}"
  cidr_block              = "${var.subnetCIDRblock}"
  map_public_ip_on_launch = "${var.mapPublicIP}" 
  availability_zone       = "${var.availabilityZone}"
  tags = {
   Name = "My VPC Subnet"
  }
}

resource "aws_security_group" "My_VPC_Security_Group" {
  vpc_id       = "${aws_vpc.My_VPC.id}"
  name         = "My VPC Security Group"
  description  = "My VPC Security Group"

ingress {
    cidr_blocks = "${var.ingressCIDRblock}"  
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
  tags = {
        Name = "My VPC Security Group"
  }
  
  }

resource "aws_network_acl" "My_VPC_Security_ACL" {
  vpc_id = "${aws_vpc.My_VPC.id}"
  subnet_ids = [ "${aws_subnet.My_VPC_Subnet.id}" ]

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "${var.destinationCIDRblock}" 
    from_port  = 80
    to_port    = 80
   }

  ingress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "${var.destinationCIDRblock}"
    from_port  = 1024
    to_port    = 65535
   }
  
   egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "${var.destinationCIDRblock}"
    from_port  = 1024
    to_port    = 65535
   }

  tags = {
    Name = "My VPC ACL"
  }
}