- [x] create azure blob storage container for .tfstate file
- [x] create resource group using remote state file

- [x] create main.tf that creates vm

- [x] again manually create a vm using azure portal and compare to terraform's output
    - Is the NSG necessary?
        - No. Without the NSG you can send requests to any port on the vm. When the NSG is added, you can only connect to ports the NSG allows.

- [x] learn how to use vpn to connect to network
    - to create the cheapest vpn SKU "Basic" you can't use the portal
    - I want to create a point-to-site vpn
    - The vpn is made up of two VMs on their own issolated subnet.
    - I'll have to pick between three authentication types when creating
        - <https://learn.microsoft.com/en-us/azure/vpn-gateway/point-to-site-about#authentication>
        - Certificate
            - Must generate a trusted root certificate (root CA public key) and give to VPN gateway. Then any clients that want to connect need to use a client certificate generated from the trusted root certificate.
        - Microsoft Entra ID
            - Uses microsoft azure VPN client.
            - Allows for MFA.
            - Workflow:
                - <https://learn.microsoft.com/en-us/azure/vpn-gateway/point-to-site-about#microsoft-entra-id-authentication-workflow>
        - RADIUS and Active Directory Domain Server

- [ ] try setting up VPN gateway manually using certificate
- [ ] try setting up VPN gateway manually using microsoft entra ID

- [ ] clean up terraform file

- [ ] install docker, pull and run image
    - maybe do this with terraform then do it with ansible and see how they differ

- [ ] expose api to public internet on port 8080
- [ ] setup https
- [ ] open up api port to web

