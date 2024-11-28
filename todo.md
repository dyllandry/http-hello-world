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

- [x] create main.tf that creates vm

- [ ] again manually create a vm using azure portal and compare to terraform's output
    - Is the NSG necessary?
    - My notes above say one was created. But I wonder if it had the same settings.

- [ ] clean up terraform file

- [ ] install docker, pull and run image
    - maybe do this with terraform then do it with ansible and see how they differ

- [ ] expose api to public internet on port 8080
- [ ] setup https
- [ ] open up api port to web

