module "gcp_firewall_default" {
  source = "../../modules/gcp-firewall-default"

  # inputs
  network         = "${google_compute_network.default.name}"
  target_tags     = "${var.gcp_list["network.tags"]}"
  subnetwork_cidr = ["${var.gcp["network.subnetwork.cidr"]}"]
  name_prefix     = "${local.common["prefix"]}"
}

resource "google_compute_firewall" "allow_aws" {
  name     = "${local.common["prefix"]}allow-aws"
  network  = "${google_compute_network.default.name}"
  priority = 1000

  allow {
    protocol = "all"
  }

  source_ranges = ["${var.aws["network.cidr"]}"]
}
