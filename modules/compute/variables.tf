variable "zone1" {
  description = "AZ for first compute instance"
  type        = string
  default     = "us-centra1-a"
}

variable "zone2" {
  description = "AZ for second compute instance"
  type        = string
  default     = "us-east1-a"
}

variable "compute_instance_image" {
  description = "Image to initialize compute instances"
  type        = string
  default     = "debian-cloud/debian-11"
}

variable "compute_instance_machine_type" {
  description = "Machine type for compute instances"
  type        = string
  default     = "e2-medium"
}

variable "vpc_cloud_network_id" {
  description = "Cloud network ID"
  type        = string
}

variable "cloud_subnet1_id" {
  description = "Cloud subnet 1 ID"
  type        = string
}

variable "cloud_subnet2_id" {
  description = "Cloud subnet 2 ID"
  type        = string
}

variable "vpc_onprem_network_id" {
  description = "VPC on-prem network ID"
  type        = string
}

variable "onprem_subnet1_id" {
  description = "On-prem subnet 1 ID"
  type        = string
}
