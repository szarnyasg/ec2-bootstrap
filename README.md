# LDBC Cloud Bootstrap

Script to bootstrap compute instances in AWS EC2 or Azure Compute.

:warning: The script puts the public keys of me & a few collaborators on the machine.

## Instance types

### AWS EC2

For `r5d` instances, use the following Fedora 34 Amazon image: `ami-086c1d77a774201ee`.

For `r6id` instances, use the following Fedora 36 Amazon image:
`Fedora-Cloud-Base-36-1.5.x86_64-hvm-us-east-2-standard-0` (`ami-0ade0d6d051ddc27b`)

### Azure Compute

More information can be found in the [README ](terraform-azure/README.md) within the `terraform-azure` folder.

## Terraform & Ansible

The EC2 instance or Azure Compute instance can be deployed using Terraform and Ansible provisioning:

- `terraform-aws` provides Terraform scripts and Ansible playbooks to deploy S3 and EC2
- `terraform-azure` provides Terraform scripts and Ansible playbooks to deploy Azure compute instances and Azure Storage Accounts.

More information can be found in the READMEs in the respective folders.

## Setup AWS

```bash
curl -s https://raw.githubusercontent.com/szarnyasg/ec2-bootstrap/main/bootstrap.sh | bash && \
    ~/ec2-bootstrap/init.sh
```

The script will install the required packages, set up Docker and open a `tmux` session with additional installation/compilation jobs.

### Manual steps

You need to perform the following manual steps.

#### Making Docker work

You need to log out and log in again to activate membership to the `docker` group.

#### Log in to AWS CLI

```bash
aws configure
```

#### Rebooting

After rebooting, mount disks by running:

```bash
./mount-disks.sh
```

