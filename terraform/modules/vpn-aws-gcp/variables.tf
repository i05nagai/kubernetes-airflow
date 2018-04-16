variable "gcp" {
  type = "map"
  description = "description"
  # region
  # network.name
  # network.vpn.asn
  # network.vpn.customer_gateway.1.cidr
  # network.vpn.customer_gateway.1.ip
  # network.vpn.customer_gateway.2.cidr
  # network.vpn.customer_gateway.2.ip
  # network.vpn.gateway.ip.name
  # network.vpn.gateway.name
  # network.vpn.router.forwarding_rule.esp.name
  # network.vpn.router.forwarding_rule.udp4500.name
  # network.vpn.router.forwarding_rule.udp500.name
  # network.vpn.router.interface.1.name
  # network.vpn.router.interface.2.name
  # network.vpn.router.name
  # network.vpn.router.peer.1.name
  # network.vpn.router.peer.2.name
  # network.vpn.tunnel.1.name
  # network.vpn.tunnel.2.name
}

variable "aws" {
  type = "map"
  description = "description"
  # network.vpc.cidr_block = ""
  # network.vpc.internet_gateway.name =
  # network.vpc.name = ""
  # network.vpc.subnet.cidr_block =
  # network.vpc.subnet.name =
  # network.vpn.connection.1.name =
  # network.vpn.customer_gateway.name =
  # network.vpn.gateway.name
}

variable "aws_list" {
  type = "map"
  description = "description"
}


