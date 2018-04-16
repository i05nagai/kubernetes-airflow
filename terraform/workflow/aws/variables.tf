variable "gcp" {
  type    = "map"
  # list of key-values are listed below
  # ingress.ip "IP address of ingress for workflow"
}

variable "aws" {
  type    = "map"
  # description = "string variables related to AWS"
  # list of key-values are listed below
  # region = ""
  # reoute53.zone_id = ""
}

variable "common" {
  type = "map"
  # env
}

#variable "aws_list" {
#  type    = "map"
#  # description = "string variables related to AWS"
#  # list of key-values are listed below
#  # route53.name_servers
#}
