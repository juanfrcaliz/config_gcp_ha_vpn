# Network definition
resource "google_compute_network" "vpc_demo" {
  project                 = var.project_id
  name                    = "vpc-demo"
  auto_create_subnetworks = false
  routing_mode            = "GLOBAL"
}

# Subnetworks
resource "google_compute_subnetwork" "vpc_demo_subnet1" {
  name          = "vpc-demo-subnet1"
  network       = google_compute_network.vpc_demo.id
  ip_cidr_range = "10.1.1.0/24"
  region        = var.region1
}

resource "google_compute_subnetwork" "vpc_demo_subnet2" {
  name          = "vpc-demo-subnet2"
  network       = google_compute_network.vpc_demo.id
  ip_cidr_range = "10.2.1.0/24"
  region        = var.region2
}

# Firewall rules
resource "google_compute_firewall" "vpc_demo_allow_custom" {
  name    = "vpc-demo-allow-custom"
  network = google_compute_network.vpc_demo.id
  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "icmp"
  }
  source_ranges = ["10.0.0.0/8"] # Self network
}

resource "google_compute_firewall" "vpc_demo_allow_ssh_icmp" {
  name    = "vpc-demo-allow-ssh-icmp"
  network = google_compute_network.vpc_demo.id
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  allow {
    protocol = "icmp"
  }
  source_ranges = ["0.0.0.0/0"] # Default value, internet access
}

resource "google_compute_firewall" "vpc_demo_allow_subnets_from_on_prem" {
  name    = "vpc-demo-allow-subnets-from-on-prem"
  network = google_compute_network.vpc_demo.id
  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "icmp"
  }
  source_ranges = ["192.168.1.0/24"] # On-prem subnetwork
}
