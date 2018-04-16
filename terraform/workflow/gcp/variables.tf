variable "gcp" {
  type = "map"

  # zone

  # "network for which firewall applies"
  # network.name
  # bigquery.dataset.id
  # bigquery.dataset.name
}

variable "gcp_list" {
  type = "map"
  # network.tags
  # network.subnetwork.cidrs
}

variable "common" {
  type = "map"
  # office.ip
  # office.cidr
  # env
}
