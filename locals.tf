locals {
  repo_name   = var.name == null ? "sudo-ci-${random_string.random_name[0].result}" : var.name
  init_script = var.init_script == null ? "${path.module}/scripts/init-ecr-repo.sh" : var.init_script

  # One lifecycle rule per prefix. tagPrefixList is an AND match across its
  # entries, not OR, so a single rule listing both prefixes would only match
  # images carrying both. distinct() handles the case where default_tag is "v".
  lifecycle_tag_prefixes = distinct(concat([var.default_tag], ["v"]))
}

resource "random_string" "random_name" {
  count   = var.name == null ? 1 : 0
  length  = 8
  special = false
  upper   = false
}
