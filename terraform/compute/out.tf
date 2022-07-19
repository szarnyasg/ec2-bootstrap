output "box_public_ip" {
    value = aws_instance.box.public_ip
}

output "box_public_dns" {
    value = aws_instance.box.public_dns
}
