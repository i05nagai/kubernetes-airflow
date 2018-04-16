locals {
  aws_map = {
    network.vpc.route_table.route_base_map = {
      gateway_id = "${aws_internet_gateway.network_vpc_internet_gateway.id}"
    }
  }
}

