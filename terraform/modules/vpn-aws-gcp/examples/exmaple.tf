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
  name        = "core-default-gateway"
  dest_range  = "0.0.0.0/0"
  network     = "network-name"
  next_hop_gateway = "default-internet-gateway"
  priority    = 99
}

#
# vpn settings
#
module "vpn_aws_gcp" {
  source        = "../vpn-aws-gcp"
  # inputs
  gcp = {
    network.vpn.gateway.ip.name = "vpn-gateway-ip-${var.common["env"]}"
    network.vpn.gateway.name = "vpn-cloud-router-aws-${var.common["env"]}-bgp"
    network.vpn.router.forwarding_rule.esp.name = "vpn-cloud-router-aws-${var.common["env"]}-bgp-rule-esp"
    network.vpn.router.forwarding_rule.udp4500.name = "vpn-cloud-router-aws-${var.common["env"]}-bgp-rule-udp4500"
    network.vpn.router.forwarding_rule.udp500.name = "vpn-cloud-router-aws-${var.common["env"]}-bgp-rule-udp500"
    network.vpn.router.interface.1.name = "if-vpn-cloud-router-${var.common["env"]}-tunnel-1"
    network.vpn.router.interface.2.name = "if-vpn-cloud-router-${var.common["env"]}-tunnel-2"
    network.vpn.router.name = "${var.common["env"]}-aws-gcp"
    network.vpn.router.peer.1.name = "vpn-cloud-router-${var.common["env"]}-tunnel-1"
    network.vpn.router.peer.2.name = "vpn-cloud-router-${var.common["env"]}-tunnel-2"
    network.vpn.tunnel.1.name = "vpn-cloud-router-aws-${var.common["env"]}-bgp-tunnel-1"
    network.vpn.tunnel.2.name = "vpn-cloud-router-aws-${var.common["env"]}-bgp-tunnel-2"
    network.name = "network-name"
    region = "${var.gcp["region"]}"
  }

  aws = {
    network.vpc.name = "network-vpc-${var.common["env"]}"
    network.vpc.cidr_block = "${var.aws["network.vpc.cidr_block"]}"
    network.vpc.internet_gateway.name = "${var.common["env"]}"
    network.vpn.gateway.name = "network-vpn-${var.common["env"]}"
    network.vpn.customer_gateway.name = "${var.common["env"]}-vpc-gcp"
    network.vpn.connection.1.name = "network-vpn-${var.common["env"]}-gcp"
    network.vpc.route_table.name = "network-vpn-${var.common["env"]}"
  }
  aws_list = {
    # list of destination CIDR blocks
    network.vpc.route_table.cidr_blocks = [
      {
        cidr_block = "0.0.0.0/0"
      },
      {
        cidr_block = "10.64.0.0/20"
      },
    ]
  }
}
