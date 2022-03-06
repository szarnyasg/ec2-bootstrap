# ec2-bootstrap

Fedora 35 x86_64 AMI: `ami-0133ad8c5d900ddef`

```bash
curl -s https://raw.githubusercontent.com/szarnyasg/ec2-bootstrap/main/bootstrap.sh | bash
```

The script will be placed to `~/ec2-bootstrap`, then, run:

```bash
./mount-disk.sh
./init-ldbc.sh
```

```bash
./build-umbra-container.sh ${UMBRA_URL}
```
