resource "google_bigquery_dataset" "default" {
  dataset_id    = "${var.gcp["bigquery.dataset.id"]}"
  friendly_name = "${var.gcp["bigquery.dataset.name"]}"
}
