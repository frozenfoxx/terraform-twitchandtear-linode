# terraform-twitchandtear-linode

Deploy a twitchandtear server in Linode

# Requirements

* a Linode account.
* the `linode_sshkey` resource is handled elsewhere.

# Usage

To use this module, in your `main.tf` TerraForm code for a deployment insert the following:

``` code
module "twitchandtear" {
  source = "github.com/frozenfoxx/terraform-twitchandtear-linode"

  authorized_keys          = ["${linode_sshkey.terraform.ssh_key}"]
  image                    = var.image
  name                     = "twitchandtear"
  private_key              = chomp(file(var.private_ssh_key))
  region                   = var.region
  channels                 = var.channels
  client_id                = var.client_id
  client_secret            = var.client_secret
  stream_key               = var.stream_key
  target_host              = var.target_host
  type                     = var.type
  wads_upload_dir          = var.wads_upload_dir
}
```

# Server Control

Scripts and files on disk are provided for ease of control of the TwitchandTear server.

* **Control script**: `/usr/local/bin/twitchandtear_server.sh`
* **Configuration file**: `/data/config`
* **Data files**: `/data/wads`