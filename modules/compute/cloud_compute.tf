locals {
  compute_instances = tomap({
    instance1 = {
      name   = "vpc-demo-instance1"
      subnet = var.cloud_subnet1_id
      zone   = var.zone1
    },
    instance2 = {
      name   = "vpc-demo-instance2"
      subnet = var.cloud_subnet2_id
      zone   = var.zone2
    }
  })
}

resource "google_compute_instance" "vpc_demo_instance" {
  for_each     = local.compute_instances
  name         = each.value["name"]
  machine_type = var.compute_instance_machine_type
  zone         = each.value["zone"]
  boot_disk {
    initialize_params {
      image = var.compute_instance_image
    }
  }
  network_interface {
    network    = var.vpc_cloud_network_id
    subnetwork = each.value["subnet"]
  }
}
