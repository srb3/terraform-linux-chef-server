################## connection #####################
variable "ip" {
  description = "The ip address where the chef server will be installed"
  type        = string
}

variable "ssh_user_name" {
  description = "The ssh user name used to access the ip addresses provided"
  type        = string
}

variable "ssh_user_pass" {
  description = "The ssh user password used to access the ip addresses (either ssh_user_pass or ssh_user_private_key needs to be set)"
  type        = string
  default     = ""
}

variable "ssh_user_private_key" {
  description = "The ssh user key used to access the ip addresses (either ssh_user_pass or ssh_user_private_key needs to be set)"
  type        = string
  default     = ""
}

variable "timeout" {
  description = "The timeout to wait for the connection to become available. Should be provided as a string like 30s or 5m. Defaults to 5 minutes."
  type        = string
  default     = "5m"
}

############ policyfile_module ##################

variable "cookbooks" {
  description = "the cookbooks used to deploy chef server"
  default = {
    "chef_server_wrapper" = "github: 'srb3/chef_server_wrapper', tag: 'v0.1.50'",
    "chef-ingredient"     = "github: 'chef-cookbooks/chef-ingredient', tag: 'v3.2.0'"
  }
}

variable "runlist" {
  description = "The chef run list used to deploy chef server"
  type        = list
  default     = ["chef_server_wrapper::default"]
}

variable "policyfile_name" {
  description = "The name to give the resulting policy file"
  type        = string
  default     = "chef_server"
}

################ attribute json ##################

variable "automate_module" {
  description = "The module output of the chef automate modeule "
  type        = string
  default     = ""
}

variable "channel" {
  description = "The install channel to use for the chef server"
  type        = string
  default     = "stable"
}

variable "install_version" {
  description = "The version of chef server to install"
  type        = string
  default     = "13.0.17"
}

variable "accept_license" {
  description = "Shall we accept the chef product license"
  type        = bool
  default     = true
}

variable "data_collector_url" {
  description = "The url to a data collector (automate) end point"
  type        = string
  default     = ""
}

variable "data_collector_token" {
  description = "The token used to access the data collector end point"
  type        = string
  default     = ""
}

variable "config" {
  description = "Extra config to be passed to a chef server"
  type        = string
  default     = ""
}

variable "config_block" {
  description = "Extra config passed in the form of a map (used for chef ha cluster)"
  type        = map
  default     = {}
}

variable "addons" {
  description = "Any addons to be installed should be included in this map"
  type        = map
  default     = {}
}

variable "supermarket_url" {
  description = "Use this to configure the chef server to talk to a supermarket instance"
  type        = string
  default     = ""
}

variable "fqdn" {
  description = "A fully qualified host name to apply to the chef server being created"
  type        = string
  default     = ""
}

variable "cert" {
  description = "An ssl certificates to apply to the chef server"
  type        = string
  default     = ""
}

variable "cert_key" {
  description = "An ssl private key to apply to the chef server"
  type        = string
  default     = ""
}

variable "users" {
  description = "A map of users to be added to the chef server and their details"
  type        = map(object({ serveradmin = bool, first_name = string, last_name = string, email = string, password = string }))
  default     = {}
}

variable "orgs" {
  description = "A map of organisations to be added to the chef server"
  type        = map(object({ admins = list(string), org_full_name = string }))
  default     = {}
}

variable "frontend_secrets" {
  description = "A list of secrets to apply to each frontend; for use in a HA cluster"
  type        = map
  default     = {}
}

variable "force_run" {
  description = "Set to anything other than default to force a rerun of provisioning on all servers"
  type        = string
  default     = "default"
}

variable "tmp_path" {
  description = "The file path to use for staging install scripts and artifacts"
  type        = string
  default     = "/var/tmp"
}

############ consul settings #####################

variable "consul_datacenter" {
  description = "The name of the datacenter to use for consul"
  type        = string
  default     = "dc1"
}

variable "consul_port" {
  description = "The port number to use for consul"
  type        = string
  default     = "8500"
}

variable "consul_log_level" {
  description = "The log level to run the consul service as"
  type        = string
  default     = "info"
}
