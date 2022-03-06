# ec2-bootstrap

Fedora 35 x86_64 AMI: `ami-0133ad8c5d900ddef`

```bash
cd && curl -s https://raw.githubusercontent.com/szarnyasg/ec2-bootstrap/main/bootstrap.sh | bash && ~/ec2-bootstrap/init.sh
```

The script will install the required packages, set up Docker and open a `tmux` session with additional installation/compilation jobs.
