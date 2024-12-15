# Setup

To set this up you'll need:
- An existing storage account to store the tfstate file.
- An existing Service principal for terraform to act on your behalf.

Steps:

1. Copy `.env.example` to `.env`.
2. Set values in `.env`.
    - To acquire these values you will need to create a service principal that can perform actions on your behalf. Instructions on how to do this are in Terraform's [Azure tutorial](https://developer.hashicorp.com/terraform/tutorials/azure-get-started/azure-build#create-a-service-principal).
3. Run `source source-for-env.sh` to set values in `.env` as env vars available to terraform child process
4. Run `terraform init`

Now you can go on running terraform commands.

# Create Infra

TODO: talk about creating rsa ssh key: https://www.cyberciti.biz/faq/linux-generating-rsa-keys/

# Connect

ssh command to VM:

`ssh -i <private key> <user>@<ip>`
