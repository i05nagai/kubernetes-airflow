module "default" {
  source        = "./modules/default"
  network = "${var.network}"
   target_tags = "${var.target_tags}"
  network_range = "${var.network_range}"
}
