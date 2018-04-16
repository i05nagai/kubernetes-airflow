resource "google_compute_subnetwork" "default" {
  count = "${length(var.subnetworks)}"

  name          = "default-${lookup(var.subnetworks[count.index], "name")}"
  ip_cidr_range = "${lookup(var.subnetworks[count.index], "ip_cidr_range")}"
  network       = "${var.network}"
  region        = "${lookup(var.subnetworks[count.index], "region")}"
}
