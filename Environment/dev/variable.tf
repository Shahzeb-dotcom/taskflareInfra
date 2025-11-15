variable "common_tags" {
  description = "Common tags to be applied to all resources"
  type        = map(string)
  default = {
    Environment = "dev"
    Project     = "MyProject"
    Owner       = "DevTeam"
  }

}
variable "rgs" {}
variable "stgs" {}
variable "vnetsubnets" {}
variable "vms" {}
variable "kvs" {}
variable "pips" {}
variable "sqls" {}
variable "bastions" {}
variable "nsgs" {}
variable "app_gateways" {}
variable "ilbs" {}
variable "acr" {}
variable "workspace" {}
variable "vpns2s" {}
variable "firewall" {}