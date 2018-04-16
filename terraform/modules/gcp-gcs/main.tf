resource "google_storage_bucket" "workflow_airflow_log" {
  name          = "workflow-airflow-log"
  location      = "US"
  force_destroy = true

  # shoud write lifecycle rules
  labels {
  }
}
