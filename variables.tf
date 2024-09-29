# Define Input Variables
# 1. Azure Location (East US)
# 2. Azure Resource Group Name 
# 3. Azure AKS Environment Name (Dev, UAT, Prod)

# Azure Location
variable "location" {
  type = string
  description = "Azure Region where all these resources will be provisioned"
  default = "East US"
}

# Azure Resource Group Name
variable "resource_group_name" {
  type = string
  description = "This variable defines the Resource Group"
  default = "hai-azure-resource-grp"
}

# Azure AKS Environment Name
variable "environment" {
  type = string
  description = "This variable defines the Environment"
  default = "dev"
}

# AKS Input Variables
# ...

# VM Admin Username
variable "vm_admin_username" {
  type = string
  default = "ubuntu"
  description = "This variable defines the VM admin username"
}
