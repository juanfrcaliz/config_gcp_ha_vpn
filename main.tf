# Configure the Google Cloud Provider
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
    random = {
        source = "hashicorp/random"
        version = "~> 3.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region1  # Primary region
}

resource "random_password" "tunnel0_shared_secret" {
  length = 32
  special = true
  upper = true
  lower = true
  numeric = true
}

resource "random_password" "tunnel1_shared_secret" {
  length = 32
  special = true
  upper = true
  lower = true
  numeric = true
}

module "network" {
  source = "./modules/network"

  project_id = var.project_id
  region1    = var.region1
  region2    = var.region2

  tunnel0_shared_secret = random_password.tunnel0_shared_secret.result
  tunnel1_shared_secret = random_password.tunnel1_shared_secret.result
}

module "compute" {
  source = "./modules/compute"
  
  zone1 = var.zone1
  zone2 = var.zone2

  compute_instance_image        = var.compute_instance_image
  compute_instance_machine_type = var.compute_instance_machine_type

  vpc_cloud_network_id  = module.network.vpc_cloud_network_id
  vpc_onprem_network_id = module.network.vpc_onprem_network_id
  cloud_subnet1_id      = module.network.cloud_subnet1_id
  cloud_subnet2_id      = module.network.cloud_subnet2_id
  onprem_subnet1_id     = module.network.onprem_subnet1_id
}
