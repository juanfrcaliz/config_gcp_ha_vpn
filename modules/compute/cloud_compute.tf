locals {
  compute_instances = tomap({
    instance1 = {
        name   = "vpc-demo-instance1"
        subnet = var.cloud_subnet1_id
    },
    instance2 = {
        name   = "vpc-demo-instance2"
        subnet = var.cloud_subnet2_id
    }
  })
}

resource "google_compute_instance" "vpc-demo-instance" {
  for_each = local.compute_instances
  name = each.value["name"]
  machine_type = var.compute_instance_machine_type
  zone = var.zone1
  boot_disk {
    initialize_params {
      image = var.compute_instance_image
    }
  }
  network_interface {
    network = google_compute_network.vpc-demo.id
    subnetwork = each.value["subnet"]
  }
}
