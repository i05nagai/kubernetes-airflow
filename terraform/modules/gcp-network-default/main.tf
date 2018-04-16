resource "google_compute_network" "default" {
  name                    = "${var.network}"
  description = "network for ${var.network}"
  auto_create_subnetworks = false
}

module "default" {
  source        = "./modules/default"
  network = "${google_compute_network.default.name}"
}
