- [x] create azure blob storage container for .tfstate file
- [x] create resource group using remote state file

- [x] create main.tf that creates vm

- [x] again manually create a vm using azure portal and compare to terraform's output
    - Is the NSG necessary?
        - No. Without the NSG you can send requests to any port on the vm. When the NSG is added, you can only connect to ports the NSG allows.
- [ ] clean up terraform file

- [ ] learn how to use vpn to connect to network, then ssh

- [ ] install docker, pull and run image
    - maybe do this with terraform then do it with ansible and see how they differ

- [ ] expose api to public internet on port 8080
- [ ] setup https
- [ ] open up api port to web

