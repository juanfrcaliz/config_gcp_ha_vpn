variable "region1" {
  description = "The first GCP region for subnet1"
  type        = string
  default     = "us-central1"
}

variable "region2" {
  description = "The second GCP region for subnet2 (for HA)"
  type        = string
  default     = "us-east1"
}

variable "zone1" {
  description = "AZ for first compute instance"
  type        = string
  default     = "us-east1-a"
}

variable "zone2" {
  description = "AZ for second compute instance"
  type        = string
  default     = "us-central1-a"
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
