output "tunnel1_cgw_inside_address" {
  value = "${aws_vpn_connection.network_vpn_connection_1.tunnel1_address}"
}

