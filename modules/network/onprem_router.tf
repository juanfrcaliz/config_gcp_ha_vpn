# On-prem router definition
resource "google_compute_router" "on_prem_router1" {
  name    = "on-prem-router1"
  region  = var.region1
  network = google_compute_network.on_prem.id
  bgp {
    asn = var.onprem_router_asn
  }
}

# Router interfaces
resource "google_compute_router_interface" "if_tunnel0_to_vpc_demo" {
  name       = "if-tunnel0-to-vpc-demo"
  router     = google_compute_router.on_prem_router1.id
  ip_range   = "169.254.0.2/30"
  vpn_tunnel = google_compute_vpn_tunnel.on_prem_tunnel0.id
  region     = var.region1
}

resource "google_compute_router_interface" "if_tunnel1_to_vpc_demo" {
  name       = "if-tunnel1-to-vpc-demo"
  router     = google_compute_router.on_prem_router1.id
  ip_range   = "169.254.1.2/30"
  vpn_tunnel = google_compute_vpn_tunnel.on_prem_tunnel1.id
  region     = var.region1
}

# Router peer connections
resource "google_compute_router_peer" "bgp_vpc_demo_tunnel0" {
  name            = "bgp-vpc-demo-tunnel0"
  router          = google_compute_router.on_prem_router1.id
  interface       = google_compute_router_interface.if_tunnel0_to_vpc_demo.id
  peer_ip_address = "169.254.0.1"        # Cloud router interface IP for tunnel0
  peer_asn        = var.cloud_router_asn # Cloud router ASN
  region          = var.region1
}

resource "google_compute_router_peer" "bgp_vpc_demo_tunnel1" {
  name            = "bgp-vpc-demo-tunnel1"
  router          = google_compute_router.on_prem_router1.id
  interface       = google_compute_router_interface.if_tunnel1_to_vpc_demo.id
  peer_ip_address = "169.254.1.1"        # Cloud router interface IP for tunnel1
  peer_asn        = var.cloud_router_asn # Cloud router ASN
  region          = var.region1
}
