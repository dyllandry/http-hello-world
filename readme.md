# Setup

1. Copy `.env.example` to `.env`.
2. Set values in `.env`.

Checkout hashicorp's azure tutorial for how to acquire values:
<https://developer.hashicorp.com/terraform/tutorials/azure-get-started/azure-build>

3. Run `source source-for-env.sh` to set values in `.env` as env vars available to terraform child process
4. Run `terraform init`

Now you can go on running terraform commands.

