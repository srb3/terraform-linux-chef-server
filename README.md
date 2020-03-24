# Overview
This terraform module will deploy chef server to one or more servers
Supported platform families:
 * Debian
 * SLES
 * RHEL

## Usage

```hcl

module "chef_server" {
  source               = "srb3/chef-server/linux"
  version              = "0.0.13"
  ips                  = ["172.16.0.23"]
  instance_count       = 1
  ssh_user_name        = "ec2-user"
  ssh_user_private_key = "~/.ssh/id_rsa"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
|ips|A list of ip addresses where the chef server will be installed|list|[]|no|
|instance_count|The number of instances being created| integer |0|no|
|ssh_user_name|The ssh user name used to access the ip addresses provided|string||yes|
|ssh_user_pass|The ssh user password used to access the ip addresses (either ssh_user_pass or ssh_user_private_key needs to be set)|string|""|no|
|ssh_user_private_key|The ssh user key used to access the ip addresses (either ssh_user_pass or ssh_user_private_key needs to be set)|string|""|no|
|channel|The install channel to use for the chef server package|string|stable|no|
|install_version|The version of chef server to install|string|12.19.31|no|
|accept_license|Shall we accept the chef product license|boolean|true|no|
|data_collector_url|The url to a data collector (automate) end point|string|""|no|
|data_collector_token|The token used to access the data collector end point|string|""|no|
|config|Extra config to be passed to a chef server|string|""|no|
|config_block|Extra config passed in the form of a map (used for chef ha cluster)|map|{}|no|
|addons|Any addons to be installed should be included in this map|map|{}|no|
|supermarket_url|Use this to configure the chef server to talk to a supermarket instance|string|""|no|
|fqdns|A list of fully qualified host names to apply to each chef server being created|list|[]|no|
|certs|A list of ssl certificates to apply to each chef server|list|[]|no|
|cert_keys|A list of ssl private keys to apply to each chef server|list|[]|no|
|users|A map of users to be added to the chef server and their details|map|{}|no|
|orgs|A map of organisations to be added to the chef server|map|{}|no|
|frontend_secrets|A list of secrets to apply to each frontend; for use in a HA cluster|list|[]|no|
|force_run|Set to anything other than default to force a rerun of provisioning on all chef servers|string|default|no|

## Map Variable examples

### config_block
#### for use with the chef-backend terraform module
```hcl
"config_block" = {
  "10.0.1.231" = {
    "use_chef_backend true\nchef_backend_members [\"10.0.1.135\", \"10.0.1.26\", \"10.0.1.150\"]\n"
  }
}
```

### addons

```hcl
addons = {
  "manage" = {
    "config" = "",
    "channel" = "stable",
    "version" = "2.5.16"
  }
}
```

### users
```hcl
users = {
  "jdoe" = {
    "serveradmin" = true, 
    "first_name"  = "Jane",
    "last_name"   = "Doe",
    "email"       = "jdoe@company.com"
    "password"    = "P@55w0rd1" 
  }
}
```

### orgs
```hcl
orgs = {
  "acmecorp" = {
    "admins" = ["jdoe"],
    "org_full_name" = "My Company"
  }
}

```

