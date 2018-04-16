output "airflow_ip" {
  value = "${google_compute_global_address.airflow_ip.address}"
}
