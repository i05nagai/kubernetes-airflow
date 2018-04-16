resource "aws_internet_gateway" "network_vpc_internet_gateway" {
  vpc_id = "${var.aws["network.vpc.id"]}"

  tags {
    Name = "${var.aws["network.vpc.internet_gateway.name"]}"
  }

  lifecycle {
    prevent_destroy = true
  }
}

#
# VPN connection
#
resource "aws_vpn_connection" "network_vpn_connection_1" {
  vpn_gateway_id      = "${aws_vpn_gateway.network_vpn_gateway.id}"
  customer_gateway_id = "${aws_customer_gateway.network_vpn_customer_gateway.id}"
  type                = "ipsec.1"
  static_routes_only  = false

  tunnel1_preshared_key = "${var.aws["network.vpn.connection.1.tunnel.1.preshared_key"]}"
  tunnel2_preshared_key = "${var.aws["network.vpn.connection.1.tunnel.2.preshared_key"]}"

  tags {
    Name = "${var.aws["network.vpn.connection.1.name"]}"
  }

  lifecycle {
    prevent_destroy = false

    ignore_changes = [
      "tunnel1_preshared_key",
      "tunnel2_preshared_key",
    ]
  }
}

resource "aws_vpn_gateway" "network_vpn_gateway" {
  vpc_id = "${var.aws["network.vpc.id"]}"

  tags {
    Name = "${var.aws["network.vpn.gateway.name"]}"
  }

  lifecycle {
    prevent_destroy = true
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
    prevent_destroy = false

    ignore_changes = [
      "ip_address",
    ]
  }
}

