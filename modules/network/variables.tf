variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region1" {
  description = "Region for Cloud and On-prem subnets 1"
  type        = string
  default     = "us-central1"
}

variable "region2" {
  description = "Region for Cloud subnet 2"
  type        = string
  default     = "us-east1"
}

variable "cloud_router_asn" {
  description = "Value for the Autonomous System Number (ASN) for the cloud router"
  type        = number
  default     = 65001
}

variable "onprem_router_asn" {
  description = "Value for the Autonomous System Number (ASN) for the on-prem router"
  type        = number
  default     = 65002
}

variable "tunnel0_shared_secret" {
  description = "Secret for VPN Gateway Tunnel 0"
  type        = string
  sensitive   = true
}

variable "tunnel1_shared_secret" {
  description = "Secret for VPN Gateway Tunnel 1"
  type        = string
  sensitive   = true
}
