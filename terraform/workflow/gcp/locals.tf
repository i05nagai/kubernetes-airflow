locals {
  common_map {
    labels = {
      owner = "me"
    }
  }

  common = {
    prefix = "${var.common["env"]}-workflow-"
  }
}
