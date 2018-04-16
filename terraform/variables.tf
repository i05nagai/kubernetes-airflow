variable "common" {
  type = "map"
  default = {}
}

variable "aws" {
  type = "map"
  description = "description"
  default = {
    default.aws_access_key = ""
    default.aws_secret_key = ""
    default.region = "us-east-1"
  }
}

variable "gcp" {
  type = "map"
  default = {
    default.credentials = ""
    default.master_auth.username = "kubernetes"
    default.master_auth.password = ""
    default.region = "asia-northeast1"
    default.project_id = "projectid"
  }
}
