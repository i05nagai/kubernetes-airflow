#
# Do not use ${var.} directly.
#

terraform {
  required_version = "= 0.11.7"
}

#
# core
#
module "core_aws" {
  source = "./core/aws"

  # inputs
  aws = {
  }
}

module "core_gcp" {
  source = "./core/gcp"

  # inputs
  gcp = {
    region = "${local.gcp["region"]}"

    network.subnetwork.cidr   = "${local.gcp["network.subnetwork.cidr"]}"
    network.cluster.cidr.ipv4 = "${local.gcp["network.cluster.cidr.ipv4"]}"

    gke.cluster.master.auth.username = "${local.gcp["gke.cluster.master.auth.username"]}"
    gke.cluster.master.auth.password = "${local.gcp["gke.cluster.master.auth.password"]}"
    gke.cluster.zone                 = "${local.gcp["zone"]}"
  }

  gcp_list = {
    network.tags = ["${local.gcp["network.tag"]}"]
    gke.cluster.node.tags = ["${local.gcp["network.tag"]}"]
  }

  aws = {
    network.cidr = "${local.aws["network.cidr"]}"
  }

  common = {
    env = "${local.common["env"]}"
  }
}

# core vpn
module "core_vpn_aws_gcp" {
  source        = "./core/vpn-aws-gcp"
  # inputs
  common = {
    env = "${local.common["env"]}"
  }
  gcp = {
    network.vpn.gateway.ip.name = "vpn-gateway-ip-${local.common["env"]}"
    network.vpn.gateway.name = "vpn-cloud-router-aws-${local.common["env"]}-bgp"
    network.vpn.router.forwarding_rule.esp.name = "vpn-cloud-router-aws-${local.common["env"]}-bgp-rule-esp"
    network.vpn.router.forwarding_rule.udp4500.name = "vpn-cloud-router-aws-${local.common["env"]}-bgp-rule-udp4500"
    network.vpn.router.forwarding_rule.udp500.name = "vpn-cloud-router-aws-${local.common["env"]}-bgp-rule-udp500"
    network.vpn.router.interface.1.name = "if-vpn-cloud-router-${local.common["env"]}-tunnel-1"
    network.vpn.router.interface.2.name = "if-vpn-cloud-router-${local.common["env"]}-tunnel-2"
    network.vpn.router.name = "${local.common["env"]}-aws-gcp"
    network.vpn.router.peer.1.name = "vpn-cloud-router-${local.common["env"]}-tunnel-1"
    network.vpn.router.peer.2.name = "vpn-cloud-router-${local.common["env"]}-tunnel-2"
    network.vpn.tunnel.1.name = "vpn-cloud-router-aws-${local.common["env"]}-bgp-tunnel-1"
    network.vpn.tunnel.2.name = "vpn-cloud-router-aws-${local.common["env"]}-bgp-tunnel-2"
    network.name = "${module.core_gcp.network_name}"
    region = "${local.gcp["region"]}"
  }

  aws = {
    network.vpc.id = ""
    network.vpc.default_route_table_id = ""
    network.vpc.internet_gateway.name = "${local.aws["network.vpc.internet_gateway.name"]}"
    network.vpn.gateway.name = ""
    network.vpn.customer_gateway.name = ""
    network.vpn.connection.1.name = ""
    network.vpc.route_table.name = ""
    network.vpn.connection.1.tunnel.1.preshared_key = ""
    network.vpn.connection.1.tunnel.2.preshared_key = ""
  }
}

#
# workflow
#
module "workflow_aws" {
  source = "./workflow/aws"

  # inputs
  gcp = {
    ingress.ip = "${module.workflow_gcp.airflow_ip}"
  }

  aws = {
    region               = "${local.aws["region"]}"
    route53.zone_id      = "${module.core_aws.zone_id}"
  }

  common = "${local.common}"

  # aws_list = {
  #   route53.name_servers = "${module.core_aws.name_servers}"
  # }
}

module "workflow_gcp" {
  source = "./workflow/gcp"

  # inputs
  gcp = {
    zone = "${local.gcp["zone"]}"
    network.name = "${module.core_gcp.network_name}"
    bigquery.dataset.id = "${local.gcp["bigquery.dataset.id"]}"
    bigquery.dataset.name = "${local.gcp["bigquery.dataset.name"]}"
  }

  gcp_list = {
    network.tags = ["${local.gcp["network.tag"]}"]
    network.subnetwork.cidrs = ["${local.gcp["network.subnetwork.cidr"]}"]
  }

  common = "${local.common}"
}

#
# home
#
module "home_gcp" {
  source = "./home/gcp"

  # inputs
  common = {
    env = "${local.common["env"]}"
  }

  gcp = {
    zone = "${local.gcp["zone"]}"
  }
}

#
# immutables
#
module "immutables" {
  source = "./immutables"

  # inputs
  aws = {
    network.vpc.cidr = "${local.aws["network.vpc.cidr"]}"
  }

  common = {
    env = "${local.common["env"]}"
  }
}

