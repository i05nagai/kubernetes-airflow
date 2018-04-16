#
# VPN connection
#
resource "google_compute_vpn_gateway" "network_vpn_gateway" {
  name    = "${var.gcp["network.vpn.gateway.name"]}"
  network = "${var.gcp["network.name"]}"
  region = "${var.gcp["region"]}"
}

resource "google_compute_address" "network_vpn_gateway_ip" {
  name    = "${var.gcp["network.vpn.gateway.ip.name"]}"
  region = "${var.gcp["region"]}"
}

#
# Cloud router
#
resource "google_compute_router" "network_vpn_router" {
  name    = "${var.gcp["network.vpn.router.name"]}"
  region = "${var.gcp["region"]}"
  network = "${var.gcp["network.name"]}"
  bgp {
    asn = "${aws_customer_gateway.network_vpn_customer_gateway.bgp_asn}"
  }
}

# forwarding rules
resource "google_compute_forwarding_rule" "network_vpn_router_forwarding_rule_esp" {
  name        = "${var.gcp["network.vpn.router.forwarding_rule.esp.name"]}"
  ip_protocol = "ESP"
  ip_address  = "${google_compute_address.network_vpn_gateway_ip.address}"
  target      = "${google_compute_vpn_gateway.network_vpn_gateway.self_link}"
}

resource "google_compute_forwarding_rule" "network_vpn_router_forwarding_rule_udp500" {
  name        = "${var.gcp["network.vpn.router.forwarding_rule.udp500.name"]}"
  ip_protocol = "UDP"
  port_range  = "500-500"
  ip_address  = "${google_compute_address.network_vpn_gateway_ip.address}"
  target      = "${google_compute_vpn_gateway.network_vpn_gateway.self_link}"
}

resource "google_compute_forwarding_rule" "network_vpn_router_forwarding_rule_udp4500" {
  name        = "${var.gcp["network.vpn.router.forwarding_rule.udp4500.name"]}"
  ip_protocol = "UDP"
  port_range  = "4500-4500"
  ip_address  = "${google_compute_address.network_vpn_gateway_ip.address}"
  target      = "${google_compute_vpn_gateway.network_vpn_gateway.self_link}"
}

# peer for tunnel 1
resource "google_compute_router_peer" "network_vpn_router_peer_1" {
  name        = "${var.gcp["network.vpn.router.peer.1.name"]}"
  router  = "${google_compute_router.network_vpn_router.name}"
  region  = "${google_compute_router.network_vpn_router.region}"
  peer_ip_address = "${aws_vpn_connection.network_vpn_connection_1.tunnel1_vgw_inside_address}"
  peer_asn = "${aws_vpn_connection.network_vpn_connection_1.tunnel1_bgp_asn}"
  interface = "${google_compute_router_interface.network_vpn_router_interface_1.name}"
  advertised_route_priority = 1000
}

resource "google_compute_router_interface" "network_vpn_router_interface_1" {
  name        = "${var.gcp["network.vpn.router.interface.1.name"]}"
  router  = "${google_compute_router.network_vpn_router.name}"
  region  = "${google_compute_router.network_vpn_router.region}"
  ip_range = "${aws_vpn_connection.network_vpn_connection_1.tunnel1_cgw_inside_address}/30"
  vpn_tunnel = "${google_compute_vpn_tunnel.network_vpn_tunnel_1.name}"
}

# peer for tunnel 2
resource "google_compute_router_peer" "network_vpn_router_peer_2" {
  name        = "${var.gcp["network.vpn.router.peer.2.name"]}"
  router  = "${google_compute_router.network_vpn_router.name}"
  region  = "${google_compute_router.network_vpn_router.region}"
  peer_ip_address = "${aws_vpn_connection.network_vpn_connection_1.tunnel2_vgw_inside_address}"
  peer_asn = "${aws_vpn_connection.network_vpn_connection_1.tunnel2_bgp_asn}"
  interface = "${google_compute_router_interface.network_vpn_router_interface_2.name}"
  advertised_route_priority = 1000
}

resource "google_compute_router_interface" "network_vpn_router_interface_2" {
  name        = "${var.gcp["network.vpn.router.interface.2.name"]}"
  router  = "${google_compute_router.network_vpn_router.name}"
  region  = "${google_compute_router.network_vpn_router.region}"
  ip_range = "${aws_vpn_connection.network_vpn_connection_1.tunnel2_cgw_inside_address}/30"
  vpn_tunnel = "${google_compute_vpn_tunnel.network_vpn_tunnel_2.name}"
}

#
# VPN Tunnel 1
#
resource "google_compute_vpn_tunnel" "network_vpn_tunnel_1" {
  name        = "${var.gcp["network.vpn.tunnel.1.name"]}"
  peer_ip       = "${aws_vpn_connection.network_vpn_connection_1.tunnel1_address}"
  shared_secret = "${aws_vpn_connection.network_vpn_connection_1.tunnel1_preshared_key}"
  ike_version   = 1
  target_vpn_gateway = "${google_compute_vpn_gateway.network_vpn_gateway.self_link}"

  router = "${google_compute_router.network_vpn_router.name}"

  depends_on = [
    "google_compute_forwarding_rule.network_vpn_router_forwarding_rule_esp",
    "google_compute_forwarding_rule.network_vpn_router_forwarding_rule_udp500",
    "google_compute_forwarding_rule.network_vpn_router_forwarding_rule_udp4500",
  ]
}

#
# VPN Tunnel 2
#
resource "google_compute_vpn_tunnel" "network_vpn_tunnel_2" {
  name        = "${var.gcp["network.vpn.tunnel.2.name"]}"
  peer_ip       = "${aws_vpn_connection.network_vpn_connection_1.tunnel2_address}"
  shared_secret = "${aws_vpn_connection.network_vpn_connection_1.tunnel2_preshared_key}"
  ike_version   = 1
  target_vpn_gateway = "${google_compute_vpn_gateway.network_vpn_gateway.self_link}"


  router = "${google_compute_router.network_vpn_router.name}"

  depends_on = [
    "google_compute_forwarding_rule.network_vpn_router_forwarding_rule_esp",
    "google_compute_forwarding_rule.network_vpn_router_forwarding_rule_udp500",
    "google_compute_forwarding_rule.network_vpn_router_forwarding_rule_udp4500",
  ]
}
