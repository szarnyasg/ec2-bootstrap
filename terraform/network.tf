// Virtual Private Network
resource "aws_vpc" "box-env" {
    cidr_block           = "10.0.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support   = true
    tags {
        Name = "box-env"
    }
}

resource "aws_eip" "ip-box-env" {
    instance = "${aws_instance.box.id}"
    vpc      = true
}

// Subnets
resource "aws_subnet" "subnet-box" {
    cidr_block        = "${cidrsubnet(aws_vpc.box-env.cidr_block, 3, 1)}"
    vpc_id            = "${aws_vpc.box-env.id}"
    availability_zone = var.region
}

// Security Group
resource "aws_security_group" "ingress-all-box" {
    name            = "allow-all-sg"
    vpc_id          = "${aws_vpc.box-env.id}"
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
