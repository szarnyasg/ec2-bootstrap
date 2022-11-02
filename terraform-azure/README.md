# Azure Bootstrap

This folder contains Terraform scripts to deploy an Azure Compute and an Azure Storage Account.

## Prerequisites

To use this files, the following is required:

- Terraform: https://www.terraform.io/downloads
- Azure CLI: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli
- Python: Used for Ansible
- Ansible: installed by using e.g. `python3 -m pip install --user ansible`
- Ansible Azure extension: installed using `ansible-galaxy collection install azure.azcollection`
- Ansible General Community extension: installed using `ansible-galaxy collection install community.general`

## Contents

- `terraform-azure/compute-single-instance`: scripts to start an Azure Compute instance of choice. Edit the `terraform.tfvars` to change the instance type and Linux image.
- `terraform-azure/compute-single-instance/playbooks`: Folder containing Ansible playbooks used to install packages and setup some packages.
- `terraform-azure/storage`: scripts to create an Azure Storage account and Resource Group
- `terraform-azure/compute-two-instances`: Folder containing Terraform scripts to start two instances: one for the driver and one for the SUT, placed in a Azure Proximity Placement group within the same VPC.

## Terraform

### Configure Credentials

In order to use the scripts, we first need to login using the Azure CLI on the local computer where Terraform scripts are used. With the following command we can configure the credentials:

```bash
az login
```

This will open a browser or give a link to authenticate. Note that this sometimes can fail is 2FA is enabled. Then first login into your Azure account before using `az login`.

### Configure Terraform for Compute

In `terraform.tfvars` for the single instances, the values used for deployment can be found and changed if required. The list of values for deploying the **Compute with network** is:

- `driver_compute_instance`: The Azure Compute instance type to use. A list can be fetched using the Azure CLI with `az vm list-skus -l westus` where the last parameter should correspond to the region to deploy.
- `azure_region`: The region to deploy e.g. `westus`. A complete list of Azure regions can be found [here](https://docs.microsoft.com/en-us/azure/availability-zones/az-overview).
- `administrator_public_key_path`: The path to the private key. This is used to execute Ansible provisioner on the Azure Compute instance.
- `administrator_username`: The remote username to use. In case of using an Ubuntu image the username is `ubuntu`.

- The variables `linux_*` are gathered from the `az vm image list --output table` command. Examples are:

  To use Ubuntu 18.04-LTS, use the following image:

  ```yaml
  linux_publisher = "Canonical"
  linux_offer 	= "UbuntuServer"
  linux_sku       = "18.04-LTS"
  linux_version   = "latest"
  ```

  For Ubuntu 20.04-LTS:

  ```yaml
  linux_publisher = "Canonical"
  linux_offer     = "0001-com-ubuntu-server-focal"
  linux_sku       = "20_04-lts"
  linux_version   = "latest"
  ```

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

It can take some time before everything is deployed. Once everything is deployed, the public IP-address of the Azure Compute instance is shown, e.g.:

```bash
driver_public_ip = "10.111.11.194"
```

### Connect to Azure Compute instance

To connect, use the following command:

```bash
ssh -A ubuntu@10.111.11.194
```

Note that in this case the username is `ubuntu` since the Ubuntu image is used. When using other distributions, the username may be different.

