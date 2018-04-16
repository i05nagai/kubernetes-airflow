# use gcs as backend
terraform {
  backend "gcs" {
    bucket = "terraform"
    prefix = "core"
  }
}
