provider "google" {
  credentials = "${file("../credential/gcp/credentials.json")}"
  project     = "${var.gcp["default.project_id"]}"
  region      = "${var.gcp["default.region"]}"
}

provider "aws" {
  access_key = "${var.aws["default.aws_access_key"]}"
  secret_key = "${var.aws["default.aws_secret_key"]}"
  region     = "${var.aws["default.region"]}"
}

