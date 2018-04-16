resource "google_storage_bucket" "airflow_log" {
  name          = "${local.common["prefix"]}airflow-log"
  location      = "asia"
  force_destroy = true

}

