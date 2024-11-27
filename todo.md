Keep track of important steps involved in setting up each azure component. It might be good to know for using terraform with it.

- [x] create azure subscription

azureuser, rsa ssh format "http-hello-world_key", port 22 open

- [x] create VM

The deployment created:
- VM
- Network Interface Card
- Public IP
- Virtual Network + Subnet
- Network Security Group

- [x] connect with ssh

`ssh -i <private key> <user>@<ip>`

I'm not sure how terraform would handle this ssh key. I'd want it after terraform is done so I can ssh on if I need to.

- [x] install docker on VM

Terraform would have to do these steps: `https://docs.docker.com/engine/install/ubuntu/`

There are post install steps to allow running docker without sudo: `https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user`

- [x] run api on VM

- [ ] create azure blob storage container for .tfstate file
- [ ] create main.tf that creates vm
    - how do I get ssh private key from that?

- [ ] expose api to public internet on port 8080
- [ ] setup https
- [ ] open up api port to web

