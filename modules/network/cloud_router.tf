# Cloud router definition
resource "google_compute_router" "vpc_demo_router1" {
  name    = "vpc-demo-router1"
  region  = var.region1
  network = google_compute_network.vpc_demo.id
  bgp {
    asn = var.cloud_router_asn
  }
}

# Router interfaces
resource "google_compute_router_interface" "if_tunnel0_to_on_prem" {
  name       = "if-tunnel0-to-on-prem"
  router     = google_compute_router.vpc_demo_router1.id
  ip_range   = "169.254.0.1/30"
  vpn_tunnel = google_compute_vpn_tunnel.vpc_demo_tunnel0.id
  region     = var.region1
}

resource "google_compute_router_interface" "if_tunnel1_to_on_prem" {
  name       = "if-tunnel1-to-on-prem"
  router     = google_compute_router.vpc_demo_router1.id
  ip_range   = "169.254.1.1/30"
  vpn_tunnel = google_compute_vpn_tunnel.vpc_demo_tunnel1.id
  region     = var.region1
}

# Router peer connections
resource "google_compute_router_peer" "bgp_on_prem_tunnel0" {
  name            = "bgp-on-prem-tunnel0"
  router          = google_compute_router.vpc_demo_router1.id
  interface       = google_compute_router_interface.if_tunnel0_to_on_prem.id
  peer_ip_address = "169.254.0.2"         # On-prem router interface IP for tunnel0
  peer_asn        = var.onprem_router_asn # On-prem router ASN
  region          = var.region1
}

resource "google_compute_router_peer" "bgp_on_prem_tunnel1" {
  name            = "bgp-on-prem-tunnel1"
  router          = google_compute_router.vpc_demo_router1.id
  interface       = google_compute_router_interface.if_tunnel1_to_on_prem.id
  peer_ip_address = "169.254.1.2"         # On-prem router interface IP for tunnel1
  peer_asn        = var.onprem_router_asn # On-prem router ASN
  region          = var.region1
}
