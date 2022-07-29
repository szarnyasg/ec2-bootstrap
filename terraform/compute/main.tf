resource "aws_instance" "driver" {
    ami             = var.aws_image
    instance_type   = var.aws_instance

    key_name        = aws_key_pair.deployer.key_name

    associate_public_ip_address = true

    availability_zone = var.aws_availability_zone
    security_groups   = ["${aws_security_group.ingress-all-main.id}"]
    subnet_id         = "${aws_subnet.main.id}"

    tags = {
        Name        = "LDBC Driver"
        Environment = "LDBC"
    }

    connection {
        type        = "ssh"
        private_key = "${file(var.private_key_filepath)}"
        user        = var.remote_exec_username
        host        = "${self.public_ip}"
    }

    provisioner "local-exec" {
        command = <<EOT
            sleep 30;
            >ldbc.ini;
            echo "[ldbc]" | tee -a ldbc.ini;
            echo "${self.public_ip} ansible_user=${var.remote_exec_username} ansible_ssh_private_key_file=${var.private_key_filepath}" | tee -a ldbc.ini;
            export ANSIBLE_HOST_KEY_CHECKING=False;
            ansible-playbook -u ${var.remote_exec_username} --private-key ${var.private_key_filepath} --extra-vars="raid_nvme=${var.create_raid_drives}" -i ldbc.ini playbooks/main.yml
            EOT
    }

    depends_on = [aws_internet_gateway.main]
}

resource "aws_instance" "sut" {
    ami             = var.aws_image
    instance_type   = var.aws_instance

    key_name        = aws_key_pair.deployer.key_name

    associate_public_ip_address = true

    availability_zone = var.aws_availability_zone
    security_groups   = ["${aws_security_group.ingress-all-main.id}"]
    subnet_id         = "${aws_subnet.main.id}"

    tags = {
        Name        = "LDBC SUT"
        Environment = "LDBC"
    }

    connection {
        type        = "ssh"
        private_key = "${file(var.private_key_filepath)}"
        user        = var.remote_exec_username
        host        = "${self.public_ip}"
    }

    provisioner "local-exec" {
        command = <<EOT
            sleep 30;
            >ldbc_sut.ini;
            echo "[ldbc]" | tee -a ldbc_sut.ini;
            echo "${self.public_ip} ansible_user=${var.remote_exec_username} ansible_ssh_private_key_file=${var.private_key_filepath}" | tee -a ldbc_sut.ini;
            export ANSIBLE_HOST_KEY_CHECKING=False;
            ansible-playbook -u ${var.remote_exec_username} --private-key ${var.private_key_filepath} --extra-vars="raid_nvme=${var.create_raid_drives}" -i ldbc_sut.ini playbooks/main.yml
            EOT
    }

    depends_on = [aws_internet_gateway.main]
}

resource "aws_key_pair" "deployer" {
    key_name   = var.key_pair_name
    public_key = var.key_pair_public_key
}
