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
    description = "AWS Region"
}

variable "aws_availability_zone" {
    type = string
    description = "AWS Avaibility zone"
}

variable "aws_profile" {
    type = string
    default = "default"
    description = "AWS Profile name matching the shared credentails"
}

variable "key_pair_name" {
    type = string
    description = "The name for the key pair"
}

variable "key_pair_public_key" {
    type = string
    description = "The public key for the key pair (starts with ssh-key and ends with the email address for the public key)"
}

variable "private_key_filepath" {
    type = string
    description = "The path to the private key file used to connect to the ec2 instance"
}

variable "subnet_cidr_block" {
    type = string
    description = "The CIDR subnet block to associate with the VPC"
}

variable "remote_exec_username" {
    type = string
    description = "The remote username, e.g. Ubuntu when a ubuntu AMI is used."
}

variable "create_raid_drives" {
    type = bool
    description = "Whether the EC2 instance has NVMe drives that needs to be a RAID volume"
}