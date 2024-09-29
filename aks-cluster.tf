# Provision AKS Cluster
/*
1. Add Basic Cluster Settings
  - Get Latest Kubernetes Version from datasource (kubernetes_version)
  - Add Node Resource Group (node_resource_group)
2. Add Default Node Pool Settings
  - Name
  - Size
  - Node count
  - Disable Auto scaling
  - Node labels
  - Tags
3. Enable MSI
4. Admin Profiles
  - Linux Profile
5. Network Profile
6. Cluster Tags
*/

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "${azurerm_resource_group.aks_rg.name}-cluster"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix          = "${azurerm_resource_group.aks_rg.name}-cluster"
  node_resource_group = "${azurerm_resource_group.aks_rg.name}-nrg"

  default_node_pool {
    name                 = "systempool"
    vm_size              = "Standard_D2pls_v5"
    node_count           = 1
    enable_auto_scaling  = false
    vnet_subnet_id       = azurerm_subnet.aks_default.id

    node_labels = {
      "nodepool-type"    = "system"
      "environment"      = "${var.environment}"
      "nodepoolos"       = "linux"
      "app"              = "system-apps"
    }

   tags = {
      "nodepool-type"    = "system"
      "environment"      = "${var.environment}"
      "nodepoolos"       = "linux"
      "app"              = "system-apps"
   } 
  }

# Identity (System Assigned or Service Principal)
  identity {
    type = "SystemAssigned"
  }

# Linux Profile
  linux_profile {
    admin_username = "${var.vm_admin_username}"
    ssh_key {
      key_data = tls_private_key.ssh_key.public_key_openssh
    }
  }

# Network Profile
  network_profile {
    network_plugin = "azure"
    load_balancer_sku = "standard"
  }

  tags = {
    Environment = "${var.environment}"
  }
}
