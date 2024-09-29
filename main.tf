# 1. Terraform Settings Block
# 2. Required Terraform Providers
# 3. Terraform Provider Block for AzureRM
# 4. Terraform Resource Block: Define a Random Pet Resource
# 5. Creating a SSH key

# 1. Terraform Settings Block
terraform {
  required_version = ">= 1.0"

  # 2. Required Terraform Providers
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

# 3. Terraform Provider Block for AzureRM
provider "azurerm" {
  features {
    # Updated as part of June2023 to delete "ContainerInsights Resources" when deleting the Resource Group
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

# 4. Terraform Resource Block: Define a Random Pet Resource
resource "random_pet" "aksrandom" {

}

# 5. Creating a SSH key
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

output "private_key" {
  value = tls_private_key.ssh_key.private_key_pem
  sensitive=true
}

output "public_key" {
  value = tls_private_key.ssh_key.public_key_openssh
  sensitive=true
}
