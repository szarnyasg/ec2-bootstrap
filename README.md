# ec2-bootstrap

Script to bootstrap EC2 boxes for LDBC benchmark.
:warning: The script puts the public keys of me & a few collaborators on the machine.

Use the Amazon Linux AMI with Kernel 5.10.

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
