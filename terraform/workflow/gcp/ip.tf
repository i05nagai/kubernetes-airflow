resource "google_compute_global_address" "airflow_ip" {
  name = "${local.common["prefix"]}airflow-ip"
}

