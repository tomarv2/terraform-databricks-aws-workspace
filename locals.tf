locals {
  profile_to_use = var.profile_for_iam != null ? var.profile_for_iam : var.profile_to_use
}
