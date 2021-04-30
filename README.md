<p align="center">
    <a href="https://github.com/tomarv2/terraform-databricks-aws-workspace/actions/workflows/pre-commit.yml" alt="Pre Commit">
        <img src="https://github.com/tomarv2/terraform-databricks-aws-workspace/actions/workflows/pre-commit.yml/badge.svg?branch=main" /></a>
    <a href="https://www.apache.org/licenses/LICENSE-2.0" alt="license">
        <img src="https://img.shields.io/github/license/tomarv2/terraform-databricks-aws-workspace" /></a>
    <a href="https://github.com/tomarv2/terraform-databricks-aws-workspace/tags" alt="GitHub tag">
        <img src="https://img.shields.io/github/v/tag/tomarv2/terraform-databricks-aws-workspace" /></a>
    <a href="https://github.com/tomarv2/terraform-databricks-aws-workspace/pulse" alt="Activity">
        <img src="https://img.shields.io/github/commit-activity/m/tomarv2/terraform-databricks-aws-workspace" /></a>
    <a href="https://stackoverflow.com/users/6679867/tomarv2" alt="Stack Exchange reputation">
        <img src="https://img.shields.io/stackexchange/stackoverflow/r/6679867"></a>
    <a href="https://discord.gg/XH975bzN" alt="chat on Discord">
        <img src="https://img.shields.io/discord/813961944443912223?logo=discord"></a>
    <a href="https://twitter.com/intent/follow?screen_name=varuntomar2019" alt="follow on Twitter">
        <img src="https://img.shields.io/twitter/follow/varuntomar2019?style=social&logo=twitter"></a>
</p>

## Terraform module for [Databricks AWS Workspace E2 (Part 1)](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/guides/aws-workspace)

> ❗️ **Important**
>
> :point_right: This Terraform module assumes you have, access to: [https://accounts.cloud.databricks.com](https://accounts.cloud.databricks.com)
>
> :point_right: Databricks account username: `databricks_account_username`
>
> :point_right: Databricks account password: `databricks_account_password`
>
> :point_right: Databricks account id, `databricks_account_id` can be found on the top right corner of the page, once you're logged in.
>
> :point_right: Part 2: Terraform module for [Databricks Workspace management](https://github.com/tomarv2/terraform-databricks-workspace-management)

---
![Databricks deployment](https://github.com/tomarv2/terraform-databricks-aws-workspace/raw/main/docs/images/databricks_deployment.png)
---

## Versions

- Module tested for Terraform 0.14.
- `databrickslabs/databricks` provider version [0.3.3](https://registry.terraform.io/providers/databrickslabs/databricks/latest)
- AWS provider version [3.30](https://registry.terraform.io/providers/hashicorp/aws/latest)
- `main` branch: Provider versions not pinned to keep up with Terraform releases
- `tags` releases: Tags are pinned with versions (use <a href="https://github.com/tomarv2/terraform-databricks-aws-workspace/tags" alt="GitHub tag">
        <img src="https://img.shields.io/github/v/tag/tomarv2/terraform-databricks-aws-workspace" /></a> in your releases)

---
## Usage

### Option 1:

```
terrafrom init
terraform plan -var='teamid=tryme' -var='prjid=project1'
terraform apply -var='teamid=tryme' -var='prjid=project1'
terraform destroy -var='teamid=tryme' -var='prjid=project1'
```
**Note:** With this option please take care of remote state storage

### Option 2:

#### Recommended method (store remote state in S3 using prjid and teamid to create directory structure):

- Create python 3.6+ virtual environment
```
python3 -m venv <venv name>
```

- Install package:
```
pip install tfremote
```

- Set below environment variables:
```
export TF_AWS_BUCKET=<remote state bucket name>
export TF_AWS_PROFILE=default
export TF_AWS_BUCKET_REGION=us-west-2
```

- Updated `examples` directory with required values.

- Run and verify the output before deploying:
```
tf -cloud aws plan -var='teamid=foo' -var='prjid=bar'
```

- Run below to deploy:
```
tf -cloud aws apply -var='teamid=foo' -var='prjid=bar'
```

- Run below to destroy:
```
tf -cloud aws destroy -var='teamid=foo' -var='prjid=bar'
```

**NOTE:**

- Read more on [tfremote](https://github.com/tomarv2/tfremote)

```
module "databricks_workspace" {
  source = "git::git@github.com:tomarv2/terraform-databricks-aws-workspace.git"

  profile_for_iam             = "iam-admin"
  aws_region                  = "us-east-2"
  databricks_account_username = "example@example.com"
  databricks_account_password = "sample123!"
  databricks_account_id       = "1234567-1234-1234-1234-1234567"
  # -----------------------------------------
  # Do not change the teamid, prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}
```

Please refer to examples directory [link](examples) for references.

## Coming up:

- **Use** [**Customer Managed VPC**](https://docs.databricks.com/administration-guide/cloud-configurations/aws/customer-managed-vpc.html)

## Troubleshooting:

### IAM policy error

If you notice below error:

```
Error: MALFORMED_REQUEST: Failed credentials validation checks: Spot Cancellation, Create Placement Group, Delete Tags, Describe Availability Zones, Describe instances, Describe Instance Status, Describe Placement Group, Describe Route Tables, Describe Security Groups, Describe Spot Instances, Describe Spot Price History, Describe Subnets, Describe Volumes, Describe Vpcs, Request Spot Instances
```

- Try creating workspace from UI:

![create_workspace_error](https://github.com/tomarv2/terraform-databricks-aws-workspace/raw/main/docs/images/create_workspace_error.png)

- Verify if the role and policy exists (assume role should allow external id)

![iam_role_trust_error](https://github.com/tomarv2/terraform-databricks-aws-workspace/raw/main/docs/images/iam_role_trust_error.png)
