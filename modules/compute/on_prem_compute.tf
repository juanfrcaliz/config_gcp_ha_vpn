resource "google_compute_instance" "on-prem-instance1" {
  name = "on-prem-instance1"
  machine_type = var.compute_instance_machine_type
  zone = var.zone1
  network_interface {
    network = var.vpc_onprem_network_id
    subnetwork = var.onprem_subnet1_id
  }
  boot_disk {
    initialize_params {
      image = var.compute_instance_image
    }
  }
}
