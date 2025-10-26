terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

module "shared_vars" {
  source = "../../shared"
}

module "gcp_ha_vpn" {
  source     = "../.."
  project_id = var.project_id
}