# VPN Gateway
resource "google_compute_vpn_gateway" "on-prem-vpn-gw1" {
  name = "on-prem-vpn-gw1"
  network = google_compute_network.on-prem.id
  region = var.region1
}

# VPN Gateway Tunnels
resource "google_compute_vpn_tunnel" "on-prem-tunnel0" {
  name = "on-prem-tunnel0"
  router = google_compute_router.on-prem-router1.id
  vpn_gateway = google_compute_vpn_gateway.on-prem-vpn-gw1.id
  vpn_gateway_interface = 0
  peer_gcp_gateway = google_compute_vpn_gateway.vpc-demo-vpn-gw1.id
  region = var.region1
  ike_version = 2
  shared_secret = "a secret message"
}

resource "google_compute_vpn_tunnel" "on-prem-tunnel1" {
  name = "on-prem-tunnel1"
  router = google_compute_router.on-prem-router1.id
  vpn_gateway = google_compute_vpn_gateway.on-prem-vpn-gw1.id
  vpn_gateway_interface = 1
  peer_gcp_gateway = google_compute_vpn_gateway.vpc-demo-vpn-gw1.id
  region = var.region1
  ike_version = 2
  shared_secret = "a secret message"
}
