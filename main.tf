module "vpc" {
  source = "git::git@github.com:tomarv2/terraform-aws-vpc.git?ref=v0.0.4"

  aws_region             = var.aws_region
  enable_dns_hostnames   = true
  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false
  create_igw             = true
  default_security_group_egress = [{
    cidr_blocks = "0.0.0.0/0"
  }]

  default_security_group_ingress = [{
    description = "Allow all internal TCP and UDP"
    self        = true
  }]

  public_subnets = [cidrsubnet(var.cidr_block, 3, 0)]
  private_subnets = [cidrsubnet(var.cidr_block, 3, 1),
  cidrsubnet(var.cidr_block, 3, 2)]
  #------------------------------------------
  # Do not change the teamid, prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}

module "iam_role" {
  source = "git::git@github.com:tomarv2/terraform-aws-iam-role.git//modules/iam_role_external?ref=v0.0.7"

  count = var.existing_role_name == null ? 1 : 0

  assume_role_policy = data.databricks_aws_assume_role_policy.this.json
  # -----------------------------------------
  # Do not change the teamid, prjid once set.
  teamid = var.teamid
  prjid  = "${var.prjid}-${local.suffix}"

  providers = {
    aws = aws.iam-management
  }
}

module "iam_policies" {
  source = "git::git@github.com:tomarv2/terraform-aws-iam-policies.git?ref=v0.0.4"

  count = var.existing_role_name == null ? 1 : 0

  role_name     = join("", module.iam_role.*.iam_role_name)
  policy        = data.databricks_aws_crossaccount_policy.cross_account_iam_policy.json
  inline_policy = true
  # -----------------------------------------
  # Do not change the teamid, prjid once set.
  teamid = var.teamid
  prjid  = "${var.prjid}-${local.suffix}"

  providers = {
    aws = aws.iam-management
  }
}

module "s3" {
  source = "git::git@github.com:tomarv2/terraform-aws-s3.git?ref=v0.0.7"

  # -----------------------------------------
  # Do not change the teamid, prjid once set.
  teamid = var.teamid
  prjid  = "${var.prjid}-${local.suffix}"
}
