// Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-internet-gateway"
  }
}

// Virtual Private Network
resource "aws_vpc" "main" {
    cidr_block           = var.subnet_cidr_block
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = {
        Name = "main-vpc"
    }
}

// Subnets
resource "aws_subnet" "main" {
    cidr_block        = "${cidrsubnet(aws_vpc.main.cidr_block, 3, 1)}"
    vpc_id            = "${aws_vpc.main.id}"

    availability_zone = var.aws_availability_zone
}

// Route
resource "aws_route_table" "main" {
    vpc_id = "${aws_vpc.main.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.main.id}"
    }
    tags = {
        Name = "main-route-table"
    }
}

resource "aws_route_table_association" "subnet-association" {
  subnet_id      = "${aws_subnet.main.id}"
  route_table_id = "${aws_route_table.main.id}"
}

// Security Group
resource "aws_security_group" "ingress-ssh" {
    name            = "allow-all-sg"
    vpc_id          = "${aws_vpc.main.id}"
    ingress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
    }

    // Terraform removes the default rule
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "ingress-https" {
    name            = "allow-all-sg"
    vpc_id          = "${aws_vpc.main.id}"
    ingress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
    }

    // Terraform removes the default rule
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "ingress-tugraph-1" {
    name            = "allow-tugraph-1"
    vpc_id          = "${aws_vpc.main.id}"
    ingress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
        from_port   = 9091
        to_port     = 9095
        protocol    = "tcp"
    }

    // Terraform removes the default rule
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "ingress-tugraph-2" {
    name            = "allow-tugraph-2"
    vpc_id          = "${aws_vpc.main.id}"
    ingress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
        from_port   = 7071
        to_port     = 7075
        protocol    = "tcp"
    }

    // Terraform removes the default rule
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}