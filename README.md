# ec2-bootstrap

Script to bootstrap EC2 boxes for LDBC benchmark.
:warning: The script puts the public keys of me & a few collaborators on the machine.

## Instance type

For `r5d` instances, use the following Fedora 34 Amazon image: `ami-086c1d77a774201ee`.

For `r6id` insteances, use the following Fedora 36 Amazon image:
`Fedora-Cloud-Base-36-1.5.x86_64-hvm-us-east-2-standard-0` (`ami-0ade0d6d051ddc27b`)

## Setup

```bash
curl -s https://raw.githubusercontent.com/szarnyasg/ec2-bootstrap/main/bootstrap.sh | bash && \
    ~/ec2-bootstrap/init.sh
```

The script will install the required packages, set up Docker and open a `tmux` session with additional installation/compilation jobs.

## Manual steps

You need to perform the following manual steps.

### Making Docker work

You need to log out and log in again to activate membership to the `docker` group.

### Log in to AWS CLI

```bash
aws configure
```

### Rebooting

After rebooting, mount disks by running:

```bash
./mount-disks.sh
```

## Terraform & Ansible

Alternatively, the EC2 instance can be deployed using Terraform and Ansible provisioning. See the `terraform` folder for the usage details.
