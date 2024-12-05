- [x] create azure blob storage container for .tfstate file
- [x] create resource group using remote state file
- [x] create main.tf that creates vm
- [x] again manually create a vm using azure portal and compare to terraform's output
    - Is the NSG necessary?
        - No. Without the NSG you can send requests to any port on the vm. When the NSG is added, you can only connect to ports the NSG allows.
- [canceled] learn how to use vpn to connect to network
    - The only Azure VPN Gateway SKU that isn't being retired in 2025 is like $200/month
- [x] clean up terraform file

- [ ] install docker, pull and run image
    - Which to use? Terraform or Ansible?
- [ ] expose api to public internet on port 8080
- [ ] setup https
- [ ] open up api port to web

