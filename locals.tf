locals {
  shared_tags = map(
    "Name", "${var.teamid}-${var.prjid}",
    "team", var.teamid,
    "project", var.prjid
  )
  profile_to_use = var.profile_for_iam != null ? var.profile_for_iam : var.profile_to_use
}
