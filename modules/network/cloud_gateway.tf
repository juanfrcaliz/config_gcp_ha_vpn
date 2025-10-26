# VPN Gateway
resource "google_compute_vpn_gateway" "vpc_demo_vpn_gw1" {
  name    = "vpc-demo-vpn-gw1"
  network = google_compute_network.vpc_demo.id
  region  = var.region1
}

# VPN Gateway Tunnels
resource "google_compute_vpn_tunnel" "vpc_demo_tunnel0" {
  name                  = "vpc-demo-tunnel0"
  router                = google_compute_router.vpc_demo_router1.id
  vpn_gateway           = google_compute_vpn_gateway.vpc_demo_vpn_gw1.id
  vpn_gateway_interface = 0
  peer_gcp_gateway      = google_compute_vpn_gateway.on_prem_vpn_gw1.id
  region                = var.region1
  ike_version           = 2
  shared_secret         = var.tunnel0_shared_secret
}

resource "google_compute_vpn_tunnel" "vpc_demo_tunnel1" {
  name                  = "vpc-demo-tunnel1"
  router                = google_compute_router.vpc_demo_router1.id
  vpn_gateway           = google_compute_vpn_gateway.vpc_demo_vpn_gw1.id
  vpn_gateway_interface = 1
  peer_gcp_gateway      = google_compute_vpn_gateway.on_prem_vpn_gw1.id
  region                = var.region2
  ike_version           = 2
  shared_secret         = var.tunnel1_shared_secret
}
