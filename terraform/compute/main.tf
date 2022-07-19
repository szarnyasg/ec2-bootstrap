resource "aws_instance" "box" {
    ami             = var.aws_image
    instance_type   = var.aws_instance

    key_name        = aws_key_pair.deployer.key_name

    associate_public_ip_address = true

    availability_zone = var.aws_availability_zone
    security_groups = ["${aws_security_group.ingress-all-main.id}"]
    subnet_id       = "${aws_subnet.main.id}"

    tags = {
        Name = "Box"
    }

    depends_on = [aws_internet_gateway.main]
}

resource "aws_key_pair" "deployer" {
    key_name   = var.key_pair_name
    public_key = var.key_pair_public_key
}
