# Network definition
resource "google_compute_network" "on-prem" {
  name = "on-prem"
  auto_create_subnetworks = false
}

# Subnetworks
resource "google_compute_subnetwork" "on-prem-subnet1" {
  name = "on-prem-subnet1"
  network = google_compute_network.on-prem.id
  ip_cidr_range = "192.168.1.0/24"
  region = var.region1
}

# Firewall rules
resource "google_compute_firewall" "on-prem-allow-custom" {
  name = "on-prem-allow-custom"
  network = google_compute_network.on-prem.id
  allow {
    protocol = "tcp"
    ports = ["0-65535"]
  }
  allow {
    protocol = "udp"
    ports = ["0-65535"]
  }
  allow {
    protocol = "icmp"
  }
  source_ranges = ["192.168.0.0/16"] # Self network
}

resource "google_compute_firewall" "on-prem-allow-ssh-icmp" {
  name = "on-prem-allow-ssh-icmp"
  network = google_compute_network.on-prem.id
  allow {
    protocol = "tcp"
    ports = ["22"]
  }
  allow {
    protocol = "icmp"
  }
}

resource "google_compute_firewall" "on-prem-allow-subnets-from-vpc-demo" {
  name = "on-prem-allow-subnets-from-vpc-demo"
  network = google_compute_network.on-prem.id
  allow {
    protocol = "tcp"
  }
  allow {
    protocol = "udp"
  }
  allow {
    protocol = "icmp"
  }
  source_ranges = ["10.1.1.0/24", "10.2.1.0/24"] # Cloud subnetworks
}
