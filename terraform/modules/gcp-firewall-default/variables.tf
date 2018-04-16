variable "subnetworks" {
  type = "list"
  description = "gcp default subnetworks"
  default = [
    {
      name = "us-central1"
      region = "us-central1"
      ip_cidr_range = "10.128.0.0/20"
    }
  ]
}

