resource "aws_vpc" "network_vpc" {
  cidr_block = "${var.aws["network.vpc.cidr_block"]}"
  tags {
    Name = "${var.aws["network.vpc.name"]}"
  }
}

resource "aws_subnet" "network_vpc_subnet" {
  vpc_id            = "${aws_vpc.network_vpc.id}"
  cidr_block        = "${var.aws["network.vpc.subnet.cidr_block"]}"

  tags {
    Name = "${var.aws["network.vpc.subnet.name"]}"
  }
}

resource "aws_internet_gateway" "network_vpc_internet_gateway" {
  vpc_id = "${aws_vpc.network_vpc.id}"

  tags {
    Name = "${var.aws["network.vpc.internet_gateway.name"]}"
  }
}

resource "aws_default_route_table" "network_vpc_route_table" {
  default_route_table_id = "${aws_vpc.network_vpc.default_route_table_id}"
  # route {
  #   cidr_block  = "0.0.0.0/0"
  #   gateway_id = "${aws_internet_gateway.network_vpc_internet_gateway.id}"
  # }
  route = "${data.null_data_source.routes.*.outputs}"
  propagating_vgws = [
    "${aws_vpn_gateway.network_vpn_gateway.id}"
  ]
  tags {
    Name = "${var.aws["network.vpc.route_table.name"]}"
  }
}

data "null_data_source" "routes" {
  count = "${length(var.aws_list["network.vpc.route_table.cidr_blocks"])}"
  # refer as "${data.null_data_source.values.outputs["key"]}"
  inputs = "${merge(var.aws_list["network.vpc.route_table.cidr_blocks"], local.aws_map["network.vpc.route_table.route_base_map"])}"
}

#
# VPN connection
#
resource "aws_vpn_connection" "network_vpn_connection_1" {
  vpn_gateway_id      = "${aws_vpn_gateway.network_vpn_gateway.id}"
  customer_gateway_id = "${aws_customer_gateway.network_vpn_customer_gateway.id}"
  type                = "ipsec.1"
  static_routes_only  = false

  tunnel1_preshared_key  = "${var.aws["network.vpn.connection.1.tunnel.1.preshared_key"]}"
  tunnel2_preshared_key  = "${var.aws["network.vpn.connection.1.tunnel.2.preshared_key"]}"
  tags {
    Name = "${var.aws["network.vpn.connection.1.name"]}"
  }

  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      "tunnel1_preshared_key",
      "tunnel2_preshared_key",
    ]
  }
}

resource "aws_vpn_gateway" "network_vpn_gateway" {
  vpc_id = "${aws_vpc.network_vpc.id}"

  tags {
    Name = "${var.aws["network.vpn.gateway.name"]}"
  }
}

resource "aws_customer_gateway" "network_vpn_customer_gateway" {
  bgp_asn    = 65000
  ip_address = "${google_compute_address.network_vpn_gateway_ip.address}"
  type       = "ipsec.1"
  tags {
    Name = "${var.aws["network.vpn.customer_gateway.name"]}"
  }


  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      "ip_address",
    ]
  }
}
