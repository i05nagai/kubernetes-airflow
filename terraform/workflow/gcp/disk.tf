resource "google_compute_disk" "redis" {
  name = "${local.common["prefix"]}redis"
  type = "pd-standard"
  zone = "${var.gcp["zone"]}"
  size = "10"

  labels = "${
    merge(${local.common_map["label"]},
    map(
      "disk", "redis"
    ))}"

resource "google_compute_disk" "mysql" {
  name = "${local.common["prefix"]}mysql"
  type = "pd-standard"
  zone = "${var.gcp["zone"]}"
  size = "10"

  labels = "${
    merge(${local.common_map["label"]},
    map(
      "disk", "mysql"
    ))}"
}

resource "google_compute_disk" "docker" {
  name = "${local.common["prefix"]}docker"
  type = "pd-standard"
  zone = "${var.gcp["zone"]}"
  size = "200"

  labels = "${
    merge(${local.common_map["label"]},
    map(
      "disk", "docker"
    ))}"
}
