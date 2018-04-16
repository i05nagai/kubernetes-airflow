resource "aws_route53_record" "workflow" {
  zone_id = "${var.aws["route53.zone_id"]}"
  name    = "workflow.hoge.com."
  type    = "A"
  ttl     = "300"
  records = [
      "${var.gcp["ingress.ip"]}"
  ]
}

resource "aws_route53_record" "workflow_all" {
  zone_id = "${var.aws["route53.zone_id"]}"
  name    = "*.workflow.hoge.com."
  type    = "CNAME"
  ttl     = "300"
  records = [
      "workflow.hoge.com."
  ]
}

