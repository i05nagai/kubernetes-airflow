resource "google_container_cluster" "airflow" {
  name = "airflow"
  zone = "${var.zone}"

  # min_master_version = "1.8.7-gke.0"
  # node_version = "1.8.7-gke.0"

  master_auth {
    username = "${lookup(var.master_auth, "username")}"
    password = "${lookup(var.master_auth, "password")}"
  }
  node_pool = {
    name       = "airflow-node-pool"
    node_count = 3

    autoscaling {
      min_node_count = 0
      max_node_count = 4
    }

    management {
      auto_repair = true
    }

    node_config {
      oauth_scopes = [
        "https://www.googleapis.com/auth/compute",
        "https://www.googleapis.com/auth/logging.write",
        "https://www.googleapis.com/auth/monitoring",
        "https://www.googleapis.com/auth/devstorage.full_control",
      ]

      disk_size_gb = 10
      machine_type = "n1-standard-1"

      tags = ["${var.node_tag}"]
    }
  }
  network_policy {
    enabled = true
    # provider = "PROVIDER_UNSPECIFIED"
  }
  addons_config {
    http_load_balancing {
      disabled = false
    }

    kubernetes_dashboard {
      disabled = false
    }
  }
}

