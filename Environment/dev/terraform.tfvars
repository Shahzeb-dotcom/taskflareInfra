rgs = {
  rg1 = {
    rgname     = "hub-rg"
    rglocation = "Central india"
  }
  rg2 = {
    rgname     = "spoketodo-rg"
    rglocation = "east us"
  }
  rg3 = {
    rgname     = "spokeincedo-rg"
    rglocation = "west us"
  }
  rg4 = {
    rgname     = "onprem-rg"
    rglocation = "West Europe"
  }
}
stgs = {
  stg1 = {
    stgname     = "devstg1"
    stglocation = "Central india"
    rgname      = "dev-rg1"
  }
}

vnetsubnets = {
  vnet1 = {
    vnetname      = "hub-vnet"
    address_space = ["10.0.0.0/16"]
    vnetlocation  = "Central india"
    rgname        = "hub-rg"

    subnets = {
      # subnet1 = {
      #   subnetname       = "frontend-subnet"
      #   address_prefixes = ["10.0.1.0/24"]
      # }
      # subnet2 = {
      #   subnetname       = "backend-subnet"
      #   address_prefixes = ["10.0.2.0/24"]
      # }
      subnet3 = {
        subnetname       = "AzureBastionSubnet"
        address_prefixes = ["10.0.3.0/24"]
      }
      subnet4 = {
        subnetname       = "AppGatewaySubnet"
        address_prefixes = ["10.0.4.0/24"]
      }
      subnet5 = {
        subnetname       = "GatewaySubnet"
        address_prefixes = ["10.0.5.0/24"]
      }
      subnet6 = {
        subnetname       = "AzureFirewallSubnet"
        address_prefixes = ["10.0.6.0/24"]
      }
      subnet7 = {
        subnetname       = "jumpserver-subnet"
        address_prefixes = ["10.0.7.0/24"]
      }
    }
  }
  vnet2 = {
    vnetname      = "spoketodo-vnet"
    address_space = ["172.16.0.0/16"]
    vnetlocation  = "east us"
    rgname        = "spoketodo-rg"
    subnets = {
      back01 = {
        subnetname       = "applicationtodo-subnet"
        address_prefixes = ["172.16.1.0/24"]
      }
    }
  }
  vnet3 = {
    vnetname      = "spokeincedo-vnet"
    address_space = ["192.168.0.0/16"]
    vnetlocation  = "west us"
    rgname        = "spokeincedo-rg"

    subnets = {
      subnet1 = {
        subnetname       = "applicationincedo-subnet"
        address_prefixes = ["192.168.1.0/24"]
      }
    }
  }


  vnet4 = {
    vnetname      = "onprem-vnet"
    address_space = ["30.0.0.0/16"]
    vnetlocation  = "West Europe"
    rgname        = "onprem-rg"
    subnets = {
      subnet1 = {
        subnetname       = "applicationonprem-subnet"
        address_prefixes = ["30.0.1.0/24"]
      }
    }
  }
}



vms = {
  vm1 = {
    vmname                  = "jumpserver_vm"
    vmlocation              = "Central india"
    rgname                  = "hub-rg"
    nicname                 = "nic-jumpvm"
    niclocation             = "Central india"
    ipconfig_name           = "ipconfig1"
    subnet_name             = "jumpserver-subnet"
    vnet_name               = "hub-vnet"
    vmsize                  = "Standard_B2s"
    image_publisher         = "Canonical"
    image_offer             = "0001-com-ubuntu-server-jammy"
    image_sku               = "22_04-lts-gen2"
    image_version           = "latest"
    osdisk_name             = "osdisk-devvm1"
    osprofile_computername  = "jumpvm1"
    osprofile_adminusername = "azureuser"
    osprofile_adminpassword = "P@ssw0rd1234!"
  }
  vm2 = {
    vmname                  = "todoapp_vm"
    vmlocation              = "east us"
    rgname                  = "spoketodo-rg"
    nicname                 = "nic-todovm"
    niclocation             = "east us"
    ipconfig_name           = "ipconfig2"
    subnet_name             = "applicationtodo-subnet"
    vnet_name               = "spoketodo-vnet"
    vmsize                  = "Standard_B2s"
    image_publisher         = "Canonical"
    image_offer             = "0001-com-ubuntu-server-jammy"
    image_sku               = "22_04-lts-gen2"
    image_version           = "latest"
    osdisk_name             = "osdisk-todovm1"
    osprofile_computername  = "todovm"
    osprofile_adminusername = "azureuser"
    osprofile_adminpassword = "P@ssw0rd1234!"
  }
  vm3 = {
    vmname                  = "incedo-vm"
    vmlocation              = "west us"
    rgname                  = "spokeincedo-rg"
    nicname                 = "nic-incedo-vm"
    niclocation             = "west us"
    ipconfig_name           = "ipconfig3"
    subnet_name             = "applicationincedo-subnet"
    vnet_name               = "spokeincedo-vnet"
    vmsize                  = "Standard_B2s"
    image_publisher         = "Canonical"
    image_offer             = "0001-com-ubuntu-server-focal"
    image_sku               = "20_04-lts"
    image_version           = "latest"
    osdisk_name             = "osdisk-incedo-vm"
    osprofile_computername  = "incedo-vm"
    osprofile_adminusername = "azureuser"
    osprofile_adminpassword = "P@ssw0rd1234!"
  }
  vm4 = {
    vmname                  = "onprem-vm"
    vmlocation              = "West Europe"
    rgname                  = "onprem-rg"
    nicname                 = "nic-onprem-vm"
    niclocation             = "West Europe"
    ipconfig_name           = "ipconfig4"
    subnet_name             = "applicationonprem-subnet"
    vnet_name               = "onprem-vnet"
    vmsize                  = "Standard_B2s"
    image_publisher         = "Canonical"
    image_offer             = "0001-com-ubuntu-server-focal"
    image_sku               = "20_04-lts"
    image_version           = "latest"
    osdisk_name             = "osdisk-onprem-vm"
    osprofile_computername  = "onprem-vm"
    osprofile_adminusername = "azureuser"
    osprofile_adminpassword = "P@ssw0rd1234!"
  }
}


kvs = {
  kv1 = {
    kvname     = "devkv1689"
    kvlocation = "Central india"
    rgname     = "dev-rg1"
  }
}
sqls = {
  sql1 = {
    sqlname          = "genomic-sql"
    sqldbname        = "genomicdb"
    sqllocation      = "centralus"
    rgname           = "hub-rg"
    sqladminlogin    = "sqladmin"
    sqladminpassword = "P@ssw0rd1234!"
  }

}

pips = {
  pip1 = {
    pipname     = "pip-appgw"
    piplocation = "Central india"
    rgname      = "hub-rg"
  }
  # pip2 = {
  #   pipname     = "pip-hub-bastion"
  #   piplocation = "Central india"
  #   rgname      = "dev-rg1"
  # }
  # pip3 = {
  #   pipname     = "pip-hub-vm"
  #   piplocation = "Central india"
  #   rgname      = "hub-rg"
  # }
  # pip4 = {
  #   pipname     = "pip-spoketodo-vm"
  #   piplocation = "east us"
  #   rgname      = "spoketodo-rg"
  # }
  # pip5 = {
  #   pipname     = "pip-onprem-vm"
  #   piplocation = "West Europe"
  #   rgname      = "onprem-rg"
  # }
  # pip6 = {
  #   pipname     = "pip-spokeincedo-vm"
  #   piplocation = "west us"
  #   rgname      = "spokeincedo-rg"
  # }
  pip6 = {
    pipname     = "pip-vpn-gateway"
    piplocation = "Central india"
    rgname      = "hub-rg"
  }
  pip7 = {
    pipname     = "pip-firewall"
    piplocation = "Central india"
    rgname      = "hub-rg"
  }
}


bastions = {
  bastion1 = {
    bastionname     = "dev-bastion1"
    bastionlocation = "Central india"
    rgname          = "dev-rg1"
    subnet_name     = "AzureBastionSubnet"
    vnet_name       = "Genomic-vnet"
    pipname         = "pip-genomic-bastion"
  }
}

nsgs = {
  nsg1 = {
    nsgname     = "nsg-genomic-app"
    nsglocation = "Central india"
    rgname      = "hub-rg"
    rules = {
      rule1 = {
        name                       = "AllowSSH"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_ranges    = ["22"]
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    }
  }
}
app_gateways = {
  appgw1 = {
    subnet_name = "AppGatewaySubnet"
    vnet_name   = "hub-vnet"
    pip_name    = "pip-appgw"

    appgwname = "genomic-appgw"
    location  = "Central india"
    rgname    = "hub-rg"

    skuname     = "Standard_v2"
    skutier     = "Standard_v2"
    skucapacity = 2

    gateway_ip_config_name = "appGatewayIpConfig"

    frontend_portname = "frontendPort"
    frontend_port     = 80

    frontend_ip_name = "appGatewayFrontendIP"


    backend_pool_name    = "appGatewayBackendPool"
    backend_ip_addresses = ["172.16.0.5", "172.16.0.6"] # backend VM IPs

    backend_http_setting_name                  = "appGatewayBackendHttpSettings"
    backend_http_settingscookie_based_affinity = "Disabled"
    backend_http_settingsport                  = 80
    backend_http_settingsprotocol              = "Http"
    backend_http_settingsrequest_timeout       = 20

    http_listenername                           = "appGatewayHttpListener"
    http_listenerfrontend_ip_configuration_name = "appGatewayFrontendIP"
    http_listenerfrontend_port_name             = "frontendPort"
    http_listenerprotocol                       = "Http"

    request_routing_rulename                       = "rule1"
    request_routing_rulerule_type                  = "Basic"
    request_routing_rulehttp_listener_name         = "appGatewayHttpListener"
    request_routing_rulebackend_address_pool_name  = "appGatewayBackendPool"
    request_routing_rulebackend_http_settings_name = "appGatewayBackendHttpSettings"
    request_routing_rulepriority                   = 100
  }
}

ilbs = {
  backend-ilb = {
    name                  = "ilb-backend"
    location              = "Central India"
    rgname                = "dev-rg1"
    vnet_name             = "Genomic-vnet"
    subnet_name           = "backend-subnet"
    private_ip_allocation = "Dynamic"
    lb_sku                = "Standard"
    frontend_name         = "frontend-ip-ilb"
    backend_pool_name     = "backend-pool-ilb"
    probe_name            = "probe-80"
    probe_port            = 80
    lb_rule_name          = "rule-ilb-http"
    protocol              = "Tcp"
    frontend_port         = 80
    backend_port          = 8000
    ipconfig_name         = "ipconfig3"
    nic_name              = "nic-genomic-backend-03"
  }
}
acr = {
  acr1 = {
    acrname  = "genomicacr"
    location = "Central india"
    rgname   = "hub-rg"
  }
}

workspace = {
  workspace1 = {
    name     = "genomic-log-analytics"
    location = "Central india"
    rgname   = "hub-rg"
  }
}

vpns2s = {
  vpn1 = {
    local_network_name = "onpremise"
    location           = "Central india"
    rgname             = "hub-rg"
    pip_name           = "pip-vpn-gateway"
    subnet_name        = "GatewaySubnet"
    vnet_name          = "hub-vnet"
    vpn_gw_name        = "hub-vpn-gateway"
    connection_name    = "vpn-connection"

  }
}

firewall = {
  firewall1 = {
    firewall_name  = "testfirewall"
    location       = "Central india"
    rgname         = "hub-rg"
    subnet_name    = "AzureFirewallSubnet"
    vnet_name      = "hub-vnet"
    public_ip_name = "pip-firewall"
  }
}
