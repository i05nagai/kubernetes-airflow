variable "network" {
  type = "string"
  description = "gcp network name"
}

variable "subnetworks" {
  type = "list"
  description = "gcp default subnetworks"
  default = [
    {
      name = "us-central1"
      region = "us-central1"
      ip_cidr_range = "10.128.0.0/20"
    },
    {
      name = "europe-west1"
      region = "europe-west1"
      ip_cidr_range = "10.132.0.0/20"
    },
    {
      name = "us-west1"
      region = "us-west1"
      ip_cidr_range = "10.138.0.0/20"
    },
    {
      name = "asia-east1"
      region = "asia-east1"
      ip_cidr_range = "10.140.0.0/20"
    },
    {
      name = "us-east1"
      region = "us-east1"
      ip_cidr_range = "10.142.0.0/20"
    },
    {
      name = "asia-northeast1"
      region = "asia-northeast1"
      ip_cidr_range = "10.146.0.0/20"
    },
    {
      name = "asia-southeast1"
      region = "asia-southeast1"
      ip_cidr_range = "10.148.0.0/20"
    },
    {
      name = "us-east4"
      region = "us-east4"
      ip_cidr_range = "10.150.0.0/20"
    },
    {
      name = "australia-southeast1"
      region = "australia-southeast1"
      ip_cidr_range = "10.152.0.0/20"
    },
    {
      name = "europe-west2"
      region = "europe-west2"
      ip_cidr_range = "10.154.0.0/20"
    },
    {
      name = "europe-west3"
      region = "europe-west3"
      ip_cidr_range = "10.156.0.0/20"
    },
    {
      name = "southamerica-east1"
      region = "southamerica-east1"
      ip_cidr_range = "10.158.0.0/20"
    },
    {
      name = "asia-south1"
      region = "asia-south1"
      ip_cidr_range = "10.160.0.0/20"
    },
    {
      name = "northamerica-northeast1"
      region = "northamerica-northeast1"
      ip_cidr_range = "10.162.0.0/20"
    },
    {
      name = "europe-west4"
      region = "europe-west4"
      ip_cidr_range = "10.164.0.0/20"
    }
  ]
}
