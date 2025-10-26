# VPN Gateway
resource "google_compute_vpn_gateway" "on_prem_vpn_gw1" {
  name    = "on-prem-vpn-gw1"
  network = google_compute_network.on_prem.id
  region  = var.region1
}

# VPN Gateway Tunnels
resource "google_compute_vpn_tunnel" "on_prem_tunnel0" {
  name                  = "on-prem-tunnel0"
  router                = google_compute_router.on_prem_router1.id
  vpn_gateway           = google_compute_vpn_gateway.on_prem_vpn_gw1.id
  vpn_gateway_interface = 0
  peer_gcp_gateway      = google_compute_vpn_gateway.vpc_demo_vpn_gw1.id
  region                = var.region1
  ike_version           = 2
  shared_secret         = var.tunnel0_shared_secret
}

resource "google_compute_vpn_tunnel" "on_prem_tunnel1" {
  name                  = "on-prem-tunnel1"
  router                = google_compute_router.on_prem_router1.id
  vpn_gateway           = google_compute_vpn_gateway.on_prem_vpn_gw1.id
  vpn_gateway_interface = 1
  peer_gcp_gateway      = google_compute_vpn_gateway.vpc_demo_vpn_gw1.id
  region                = var.region1
  ike_version           = 2
  shared_secret         = var.tunnel1_shared_secret
}
