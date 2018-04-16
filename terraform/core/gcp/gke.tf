resource "google_container_cluster" "default" {
  name = "${local.common["prefix"]}default"
  zone = "${var.gcp["gke.cluster.zone"]}"

  min_master_version = "1.9.7-gke.1"
  node_version       = "1.9.7-gke.1"

  master_auth {
    username = "${var.gcp["gke.cluster.master.auth.username"]}"
    password = "${var.gcp["gke.cluster.master.auth.password"]}"
  }

  node_pool = {
    name       = "${local.common["prefix"]}node-pool-lpc"
    node_count = 1

    autoscaling {
      min_node_count = 1
      max_node_count = 4
    }

    management {
      auto_repair  = true
      auto_upgrade = false
    }

    node_config {
      oauth_scopes = "${local.gcp_list["gke.cluster.oauth_scopes"]}"

      labels {
        name  = "${local.common["prefix"]}node-pool-lpc"
      }

      disk_size_gb = 200
      machine_type = "n1-standard-2"

      tags = "${var.gcp_list["gke.cluster.node.tags"]}"
    }
  }

  network           = "${google_compute_network.default.name}"
  subnetwork        = "${module.gcp_network_default.subnetworks[0]}"
  cluster_ipv4_cidr = "${var.gcp["network.cluster.cidr.ipv4"]}"

  network_policy {
    # enabled = true
  }

  addons_config {
    http_load_balancing {
      disabled = false
    }

    kubernetes_dashboard {
      disabled = false
    }
  }

  lifecycle {
    ignore_changes = [
      "node_pool",
      "master_auth.0.client_certificate",
      "master_auth.0.client_key",
      "master_auth.0.cluster_ca_certificate",
      "master_auth.0.password",
    ]
  }
}

# node pool for high-performace computing
resource "google_container_node_pool" "node_pool_highcpu" {
  name       = "${local.common["prefix"]}node-pool-highcpu"
  zone       = "${var.gcp["gke.cluster.zone"]}"
  cluster    = "${google_container_cluster.default.name}"
  node_count = 0

  autoscaling {
    min_node_count = 0
    max_node_count = 2
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    # preemptible  = true
    preemptible  = "${local.gcp["gke.node_pool.highcpu.preemptible"]}"
    machine_type = "${local.gcp["gke.node_pool.highcpu.machine_type"]}"

    oauth_scopes = "${local.gcp_list["gke.cluster.oauth_scopes"]}"

    labels {
      name  = "${local.common["prefix"]}node-pool-highcpu"
    }

    disk_size_gb = 200
  }

  lifecycle {
    ignore_changes = [
      "node_count",
    ]
  }
}
