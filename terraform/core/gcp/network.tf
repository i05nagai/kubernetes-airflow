resource "google_compute_network" "default" {
  name                    = "${local.common["prefix"]}default"
  description = "network"
  auto_create_subnetworks = false
}

# generate default subnetowrks
module "gcp_network_default" {
  source        = "../../modules/gcp-network-default"
  # inputs
  network = "${google_compute_network.default.name}"
  subnetworks = [{
    name = "${local.common["prefix"]}${var.gcp["region"]}"
    region = "${var.gcp["region"]}"
    ip_cidr_range = "${var.gcp["network.subnetwork.cidr"]}"
  }]
}

#
# This seems very weird resource. In GCP, when we create VPN connection,
# GCP automatically generates routing rules to the customer gateway of AWS
# (i.e. the outside gateway).
# The rules consists of 3 rules:
#
# * rule1
#   * source: 0.0.0.0/0
#   * to: AWS gateway
#   * priority: 100
# * rule2
#   * source: subnetwork_mask
#   * to: AWS gateway
#   * priority: 100
# * rule3
#   * source: Other VPC
#   * to: AWS gateway
#   * priority: 100
# 
# Hence the rule1 forward all packets to AWS gateway
# but we want to communicate with the Internet in GCP network.
# This rule overrides rule1 with priority 99 to route our packet to the Internet.
resource "google_compute_route" "default_gateway" {
  name             = "${local.common["prefix"]}default-gateway"
  dest_range       = "0.0.0.0/0"
  network          = "${google_compute_network.default.name}"
  next_hop_gateway = "default-internet-gateway"
  priority         = 99
}
