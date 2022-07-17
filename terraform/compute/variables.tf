variable "aws_image" {
    type = string
    description = "ID of the AWS image (AMI)"
}

variable "aws_instance" {
    type = string
    description = "EC2 instance"
}

variable "aws_region" {
    type = string
    description = "AWS Avaibility zone"
}

variable "aws_profile" {
    type = string
    description = "AWS Profile name matching the shared credentails"
}

variable "aws_credentials_file" {
    type = string
    description = "Path to the credentials file"
}

variable "key_pair_name" {
    type = string
    description = "The name for the key pair"
}

variable "key_pair_public_key" {
    type = string
    description = "The public key for the key pair (starts with ssh-key and ends with the email address for the public key)"
}
