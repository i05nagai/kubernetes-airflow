resource "google_compute_disk" "default" {
  name = "${var.common["prefix"]}default"
  type = "pd-standard"
  zone = "${var.gcp["zone"]}"
  size = "200"

  labels {
  }
}

resource "google_compute_disk" "docker" {
  name = "${var.common["prefix"]}docker"
  type = "pd-standard"
  zone = "${var.gcp["zone"]}"
  size = "200"

  labels {
  }
}

