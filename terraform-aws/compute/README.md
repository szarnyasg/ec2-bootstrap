# Terraform and Ansible EC2 Compute

This folder contains the Terraform code to deploy an EC2 instance and provision it using Ansible. Under `playbooks`, the Ansible-playbooks are stored. By default, the following playbooks are executed:

- `playbooks/bootstrap.yml`: Installs required packages and configuration
- `playbooks/contributor-keys.yml`: Adds public keys from contributors
- `playbooks/create-disks.yml`: Creates the `/data` folder on a RAID volume if the option is set to `true`, otherwise only the `/data` folder is created on the existing drive
- `playbooks/init-ldbc-interactive.yml`: Clone interactive repository
- `playbooks/init-ldbc-bi.yml:` Clone BI repository
- `playbooks/init-ldbc-datagen.yml`: Clone and build Spark Datagen repository

To remove a playbook, comment the playbook out from `main.yml`:

```yaml
---
- import_playbook: bootstrap.yml
- import_playbook: contributor-keys.yml
- import_playbook: create-disks.yml

- import_playbook: init-ldbc-interactive.yml
- import_playbook: init-ldbc-bi.yml
- import_playbook: init-ldbc-datagen.yml
```

