#
# do not use `if` statement in each resource files.
# It hard to maintain the variblaes since the dependencies of the variables become unclear.
#
locals {
  gcp = {
    gke.node_pool.highcpu.preemptible = "${var.common["env"] == "prod" ? false : true}"
    gke.node_pool.highcpu.machine_type = "${var.common["env"] == "prod" ? "n1-highcpu-16" : "n1-highcpu-16"}"
  }

  gcp_list = {
    gke.cluster.oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/devstorage.full_control",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/trace.append",
    ]
  }
}

locals {
  common = {
    prefix = "${var.common["env"]}-core-"
  }

  flag = {
    env_dev = "${var.common["env"] == "dev" ? 1 : 0}"
    env_stg = "${var.common["env"] == "stg" ? 1 : 0}"
    env_prod = "${var.common["env"] == "prod" ? 1 : 0}"
  }
}
