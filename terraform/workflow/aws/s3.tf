resource "aws_s3_bucket" "default" {
  bucket = "${local.common["prefix"]}-default"
  acl    = "private"
  region = "${var.aws["region"]}"
  force_destroy = true

  versioning {
    enabled = true
  }
}

