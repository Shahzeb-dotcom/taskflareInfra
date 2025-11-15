module "rg" {
  source      = "../../Module/az_rg"
  rgs         = var.rgs
  common_tags = var.common_tags
}
# module "stgs" {
#   depends_on  = [module.rg]
#   source      = "../../Module/az_stg"
#   stgs        = var.stgs
#   common_tags = var.common_tags

# }
module "vnetsubnets" {
  depends_on  = [module.rg]
  source      = "../../Module/az_vnetsubnet"
  vnets       = var.vnetsubnets
  common_tags = var.common_tags

}
module "vms" {
  depends_on  = [module.rg, module.vnetsubnets]
  source      = "../../Module/az_linuxvm&nic"
  vms         = var.vms
  common_tags = var.common_tags

}
# module "key_vault" {
#   depends_on = [ module.rg ]
#   source = "../../Module/az_kv"
#   kv = var.kvs
#   common_tags = var.common_tags

# }
# module "sqls" {
#   depends_on = [module.rg]
#   source     = "../../Module/az_sql_database"
#   sql        = var.sqls
# }

module "pips" {
  depends_on  = [module.rg]
  source      = "../../Module/az_pip"
  pips        = var.pips
  common_tags = var.common_tags
}


# module "bastion" {
#   depends_on = [module.rg, module.vnetsubnets, module.pips]
#   source     = "../../Module/az_bastion"
#   bastion    = var.bastions

# }
module "nsgs" {
  depends_on = [module.rg]
  source     = "../../Module/az_nsg"
  nsg        = var.nsgs
}
module "app_gateways" {
  depends_on = [module.rg, module.pips]
  source     = "../../Module/az_appgateway"
  appgws     = var.app_gateways

}
# module "ilb" {
#   depends_on = [module.rg, module.vnetsubnets, module.vms]
#   source     = "../../Module/ILB"
#   ilbs       = var.ilbs
# }
# module "acr" {
#   depends_on = [module.rg]
#   source     = "../../Module/az-acr"
#   acr        = var.acr

# }
module "workspace" {
  depends_on = [module.rg]
  source     = "../../Module/az_log_analytc_wrkspace"
  workspace  = var.workspace
}
module "vpn_gateway" {
  depends_on = [module.rg, module.vnetsubnets,module.pips]
  source     = "../../Module/az_vpn_gateway"
  vpns2s     = var.vpns2s
}

module "firewall" {
  depends_on = [module.rg, module.vnetsubnets, module.pips]
  source     = "../../Module/az_firewall"
  firewall   = var.firewall
}