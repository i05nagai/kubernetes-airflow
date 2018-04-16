resource "aws_route53_zone" "hoge" {
  name          = "hoge.com."
  comment       = ""
  force_destroy = "true"

}

resource "aws_route53_record" "hoge_ns" {
  zone_id         = "${aws_route53_zone.hoge.zone_id}"
  name            = "hoge.com."
  type            = "NS"
  ttl             = "300"
  allow_overwrite = "true"

  records = [
    "${aws_route53_zone.hoge.name_servers.0}",
    "${aws_route53_zone.hoge.name_servers.1}",
    "${aws_route53_zone.hoge.name_servers.2}",
    "${aws_route53_zone.hoge.name_servers.3}",
  ]
}

resource "aws_route53_record" "hoge_soa" {
  zone_id         = "${aws_route53_zone.hoge.zone_id}"
  name            = "hoge.com."
  type            = "SOA"
  ttl             = "900"
  allow_overwrite = "true"

  records = [
  ]
}

resource "aws_route53_record" "hoge_fuga_ns" {
  zone_id         = "${var.aws["route53.hoge.zone_id"]}"
  name            = "fuga.hoge.com."
  type            = "NS"
  ttl             = "300"
  allow_overwrite = "true"

  records = [
    "${aws_route53_zone.hoge.name_servers.0}",
    "${aws_route53_zone.hoge.name_servers.1}",
    "${aws_route53_zone.hoge.name_servers.2}",
    "${aws_route53_zone.hoge.name_servers.3}",
  ]
}

