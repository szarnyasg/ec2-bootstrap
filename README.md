# ec2-bootstrap

Fedora 35 x86_64 AMI: `ami-0133ad8c5d900ddef`

```bash
curl -s https://raw.githubusercontent.com/szarnyasg/ec2-bootstrap/main/bootstrap.sh | bash
```

The script will be placed to `~/ec2-bootstrap`. So, run:

```bash
cd ~/ec2-bootstrap
./mount-disk.sh
./init-ldbc.sh
```

While these run, in another `tmux` pane, you can start building the Umbra container.

```bash
./build-umbra-container.sh ${UMBRA_URL}
```
