<p align="center">
    <a href="https://github.com/tomarv2/terraform-databricks-aws-workspace/actions/workflows/pre-commit.yml" alt="Precommit">
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

# Terraform module for [Databricks AWS Workspace E2 (Part 1)](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/guides/aws-workspace)

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

## Versions

- Module tested for Terraform 0.14.
- `databrickslabs/databricks` provider version [0.3.1](https://registry.terraform.io/providers/databrickslabs/databricks/latest)
- AWS provider version [3.29.0](https://registry.terraform.io/providers/hashicorp/aws/latest)
- `main` branch: Provider versions not pinned to keep up with Terraform releases
- `tags` releases: Tags are pinned with versions (use <a href="https://github.com/tomarv2/terraform-databricks-aws-workspace/tags" alt="GitHub tag">
        <img src="https://img.shields.io/github/v/tag/tomarv2/terraform-databricks-aws-workspace" /></a> in your releases)

**NOTE:**

- Read more on [tfremote](https://github.com/tomarv2/tfremote)

## Usage

Recommended method:

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

- Updated `examples` directory to required values.

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

> ❗️ **Important** - Two variables are required for using `tf` package:
>
> - teamid
> - prjid
>
> These variables are required to set backend path in the remote storage.
> Variables can be defined using:
>
> - As `inline variables` e.g.: `-var='teamid=demo-team' -var='prjid=demo-project'`
> - Inside `.tfvars` file e.g.: `-var-file=<tfvars file location> `
>
> For more information refer to [Terraform documentation](https://www.terraform.io/docs/language/values/variables.html)

```
module "databricks_workspace" {
  source = "git::git@github.com:tomarv2/terraform-databricks-aws-workspace.git?ref=v0.0.1"

  profile_for_iam             = "iam-admin"
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
