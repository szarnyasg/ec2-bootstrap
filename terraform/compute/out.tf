output "driver_public_ip" {
    value = aws_instance.driver.public_ip
}

output "driver_public_dns" {
    value = aws_instance.driver.public_dns
}

output "sut_public_ip" {
    value = aws_instance.sut.public_ip
}

output "sut_public_dns" {
    value = aws_instance.sut.public_dns
}
