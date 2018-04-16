#
# do not use `if` statement in each resource files.
# It hard to maintain the variblaes since the dependencies of the variables become unclear.
#
locals {
}

locals {
  common = {
    prefix = "${var.common["env"]}-home-"
  }
}
