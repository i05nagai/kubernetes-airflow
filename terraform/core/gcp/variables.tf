#
# common
#

variable "common" {
  type = "map"
  # env
}
#
# gcp
#
variable "gcp" {
  type = "map"

  # region

  # "network for which firewall applies"
  # network.name
  # network.subnetwork.cidr
  # network.cluster.cidr.ipv4
  # user name for kubernetes dashboard
  # gke.cluster.master.auth.username
  # gke.cluster.master.auth.password
  # gke.cluster.zone
}

variable "gcp_list" {
  type = "map"

  # network.tags
  # gke.cluster.node.tags
}

#
# aws
#
variable "aws" {
  type = "map"

  # AWS CIDR for production environment  
  # network.cidr
}
