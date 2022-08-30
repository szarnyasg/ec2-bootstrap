aws_image                 = "ami-0e081ed4ce61c1fb2"  #fedora: "ami-09e08e82e8f927ba4" #"ami-086c1d77a774201ee" "ami-0070c5311b7677678"
aws_instance              = "t2.micro"
aws_region                = "us-east-1"
key_pair_name             = "id_github_gladap"
key_pair_public_key       = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILovUxkvgeNBNGutbGAKNSHmNCTWK41DkVFbdd80oaoR dpuroja@outlook.com"
private_key_filepath      = "/home/gladap/.ssh/id_github_gladap"
subnet_cidr_block         = "10.0.1.0/24"
aws_availability_zone     = "us-east-1a"

remote_exec_username      = "ubuntu"
create_raid_drives        = false
