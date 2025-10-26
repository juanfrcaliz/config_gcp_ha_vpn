output "vpc_cloud_network_id" {
  description = "VPC cloud network ID"
  value = google_compute_network.vpc-demo.id
}

output "cloud_subnet1_id"{
  description = "Cloud subnet 1 ID"
  value = google_compute_subnetwork.vpc-demo-subnet1.id
}

output "cloud_subnet2_id" {
  description = "Cloud subnet 2 ID"
  value = google_compute_subnetwork.vpc-demo-subnet2.id
}

output "vpc_onprem_network_id" {
  description = "VPC on-prem network ID"
  value = google_compute_network.on-prem.id
}

output "onprem_subnet1_id"{
    description = "On-prem subnet 1 ID"
    value = google_compute_subnetwork.on-prem-subnet1.id
}
