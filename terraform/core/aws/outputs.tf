output "zone_id" {
  value = "${aws_route53_zone.hoge.zone_id}"
}

output "name_servers" {
  value = [
    "${aws_route53_zone.hoge.name_servers.0}",
    "${aws_route53_zone.hoge.name_servers.1}",
    "${aws_route53_zone.hoge.name_servers.2}",
    "${aws_route53_zone.hoge.name_servers.3}",
  ]
}

