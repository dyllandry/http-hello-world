Creating a VM also created this stuff:
- VM
    - azureuser, rsa ssh format "http-hello-world_key", port 22 open
- Network Interface Card
- Public IP
- Virtual Network + Subnet
- Network Security Group

ssh command to VM:

`ssh -i <private key> <user>@<ip>`

- [x] create azure blob storage container for .tfstate file
- [x] create resource group using remote state file

- [ ] create main.tf that creates vm
    - checkout azurerm docs for creating a vm
    - how do I get ssh private key from that?

- [ ] expose api to public internet on port 8080
- [ ] setup https
- [ ] open up api port to web

