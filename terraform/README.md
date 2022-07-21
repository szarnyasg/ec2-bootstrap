# Terraform AWS Scripts

This folder contains Terraform scripts to deploy an AWS box and S3 storage.

## Prerequisites

To use this files, the following is required:

- Terraform: https://www.terraform.io/downloads
- AWS CLI: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
- Python: Used for Ansible
- Ansible: installed by using e.g. `python3 -m pip install --user ansible`
- Ansible.posix: Installed by using `ansible-galaxy collection install ansible.posix`

## Contents

- `terraform/compute`: scripts to start an EC2 instance of choice. Edit the `terraform.tfvars` to change the instance type and AMI. 
- `terraform/compute/playbooks`: Folder containing Ansible playbooks used to install packages
- `terraform/storage`: scripts to create a S3 bucket

## Terraform

### Configure Credentials

In order to use the scripts, we first need to login using the AWS CLI on the local computer where the Terraform scripts are used. In this command, we use a credentials CSV file containing an Access key and a Secret Access Key. To create this CSV file, follow the steps as shown in [Creating your first IAM admin user and user group](https://docs.aws.amazon.com/IAM/latest/UserGuide/getting-started_create-admin-group.html). Then run the following commands:

```bash
aws configure import --csv file://credentials.csv
aws configure set region us-east-1 --profile default
```

There are other ways of setting the credentials, which can be found [here](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html).

If importing of the CSV does not work, use `aws configure` and copy the contents.

In the example above `us-east-1` is used. A complete list of AWS regions can be found [here](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html).

### Configure Terraform for Compute

In `terraform.tfvars`, the values used for deployment can be found and changed if required. The list of values for deploying the **Compute with network** is:

- `aws_image`: The AMI image to use. For Ubuntu, one can locate the right AMI using https://cloud-images.ubuntu.com/locator/ec2/. For Fedora or other distributions, one can use the AWS CLI. E.g. with Fedora: `aws ec2 describe-images --region us-east-1 --owners 125523088429 --filters 'Name=name,Values=Fedora-Cloud-Base-36-*x86_64-hvm-*-gp2-*' --query 'sort_by(Images, &CreationDate)[-1].[ImageId,Name,CreationDate]' --output text`
- `aws_instance`: The AWS EC2 instance type to use. A list can be found at https://instances.vantage.sh
- `aws_region`: The region to deploy e.g. `us-east-1`. A complete list of AWS regions can be found [here](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html).
- `subnet_cidr_block`: The subnet to use for the EC2 instances.
- `aws_availability_zone`: The availability zone to deploy to, e.g. `us-east-1a`. Information about availability zones can be found [here](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html#concepts-availability-zones).
- `key_pair_name`: The name of the key-pair, e.g. `id_ed25519`
- `private_key_filepath`: The path to the private key. This is used to execute Ansible provisioner on the EC2 instance.
- `key_pair_public_key`: The public key associated with the above `key_pair_name`. This can be a SSH public key e.g.: `ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 email@example.com`.
- `remote_exec_username`: The remote username to use. In case of using an Ubuntu image the username is `ubuntu`.
- `create_raid_drives`: Create RAID drives (only set to true when the EC2 instance has multiple Nvme drives)

The `key_pair` is used to connect to the EC2 instance once it is deployed. More information about the `key-pair` can be found [here](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair).

### Deploy

To deploy the configuration, execute the following commands:

```bash
terraform init
terraform apply
```

Alternatively, if you have your own variables file, you can use that (e.g. dev.tfvars):
```bash
terraform apply -var-file dev.tfvars
```
as an example, a Ubuntu and Fedora tfvars is created, which can be used with:
```bash
terraform apply -var-file fedora.tfvars
```
or
```bash
terraform apply -var-file ubuntu.tfvars
```


It can take some time before everything is deployed. Once everything is deployed, the IP-address and public DNS of the EC2 instance is shown, e.g.:

```bash
box_public_dns = "ec2-10-111-11-194.compute-1.amazonaws.com"
box_public_ip = "10.111.11.194"
```

### Connect to EC2 instance

To connect, use the private key file of the used public key in the `terraform.tfvars`, e.g.:

```bash
ssh -i "~/.ssh/private_key" ubuntu@ec2-10-111-11-194.compute-1.amazonaws.com
```

Note that in this case the username is `ubuntu` since AMI-image `ami-0070c5311b7677678` corresponds to `ubuntu 20.04 LTS us-east-1`. When using other distributions, the username may be different.

