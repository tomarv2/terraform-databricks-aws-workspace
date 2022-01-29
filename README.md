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
> :point_right: This Terraform module assumes you have access to: [https://accounts.cloud.databricks.com](https://accounts.cloud.databricks.com)
>
> :point_right: Databricks account username: `databricks_account_username`
>
> :point_right: Databricks account password: `databricks_account_password`
>
> :point_right: Databricks account id, `databricks_account_id` can be found on the bottom left corner of the page, once you're logged in.
>
> :point_right: Part 2: Terraform module for [Databricks Workspace management](https://github.com/tomarv2/terraform-databricks-workspace-management)

---
![Databricks deployment](https://github.com/tomarv2/terraform-databricks-aws-workspace/raw/main/docs/images/databricks_deployment.png)
---

## Versions

- Module tested for Terraform 1.0.1.
- `databrickslabs/databricks` provider version [0.4.7](https://registry.terraform.io/providers/databrickslabs/databricks/latest)
- AWS provider version [3.47](https://registry.terraform.io/providers/hashicorp/aws/latest).
- `main` branch: Provider versions not pinned to keep up with Terraform releases.
- `tags` releases: Tags are pinned with versions (use <a href="https://github.com/tomarv2/terraform-databricks-aws-workspace/tags" alt="GitHub tag">
        <img src="https://img.shields.io/github/v/tag/tomarv2/terraform-databricks-aws-workspace" /></a>).

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

#### Recommended method (stores remote state in S3 using `prjid` and `teamid` to create directory structure):

- Create python 3.6+ virtual environment
```
python3 -m venv <venv name>
```

- Install package:
```
pip install tfremote --upgrade
```

- Set below environment variables:
```
export TF_AWS_BUCKET=<remote state bucket name>
export TF_AWS_BUCKET_REGION=us-west-2
export TF_AWS_PROFILE=<profile from ~/.ws/credentials>
```

or

- Set below environment variables:
```
export TF_AWS_BUCKET=<remote state bucket name>
export TF_AWS_BUCKET_REGION=us-west-2
export AWS_ACCESS_KEY_ID=<aws_access_key_id>
export AWS_SECRET_ACCESS_KEY=<aws_secret_access_key>
```

- Update [main.tf](examples/sample/main.tf) file with required values.

- Run and verify the output before deploying:
```
tf -c=aws plan -var='teamid=foo' -var='prjid=bar'
```

- Run below to deploy:
```
tf -c=aws apply -var='teamid=foo' -var='prjid=bar'
```

- Run below to destroy:
```
tf -c=aws destroy -var='teamid=foo' -var='prjid=bar'
```

**NOTE:**

- Read more on [tfremote](https://github.com/tomarv2/tfremote)

### Databricks workspace creation with new role
```
module "databricks_workspace" {
  source = "git::git@github.com:tomarv2/terraform-databricks-aws-workspace.git"

  # NOTE: One of the below is required:
  # - 'profile_for_iam' - for IAM creation (if none is provided 'default' is used)
  # - 'existing_role_name'
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

### Databricks workspace creation with existing role
```
module "databricks_workspace" {
  source = "git::git@github.com:tomarv2/terraform-databricks-aws-workspace.git"

  # NOTE: One of the below is required:
  # - 'profile_for_iam' - for IAM creation (if none is provided 'default' is used)
  # - 'existing_role_name'
  existing_role_arn          = "arn:aws:iam::123456789012:role/demo-role"
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

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.47 |
| <a name="requirement_databricks"></a> [databricks](#requirement\_databricks) | 0.3.5 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.1 |
| <a name="requirement_time"></a> [time](#requirement\_time) | ~> 0.7 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.38.0 |
| <a name="provider_databricks"></a> [databricks](#provider\_databricks) | 0.3.3 |
| <a name="provider_databricks.mws"></a> [databricks.mws](#provider\_databricks.mws) | 0.3.3 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.1.0 |
| <a name="provider_time"></a> [time](#provider\_time) | 0.7.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_iam_policies"></a> [iam\_policies](#module\_iam\_policies) | git::git@github.com:tomarv2/terraform-aws-iam-policies.git | v0.0.4 |
| <a name="module_iam_role"></a> [iam\_role](#module\_iam\_role) | git::git@github.com:tomarv2/terraform-aws-iam-role.git//modules/iam_role_external | v0.0.4 |
| <a name="module_s3"></a> [s3](#module\_s3) | git::git@github.com:tomarv2/terraform-aws-s3.git | v0.0.3 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | git::git@github.com:tomarv2/terraform-aws-vpc.git | v0.0.4 |

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket_policy.root_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [databricks_mws_credentials.this](https://registry.terraform.io/providers/databrickslabs/databricks/0.3.5/docs/resources/mws_credentials) | resource |
| [databricks_mws_networks.this](https://registry.terraform.io/providers/databrickslabs/databricks/0.3.5/docs/resources/mws_networks) | resource |
| [databricks_mws_storage_configurations.this](https://registry.terraform.io/providers/databrickslabs/databricks/0.3.5/docs/resources/mws_storage_configurations) | resource |
| [databricks_mws_workspaces.this](https://registry.terraform.io/providers/databrickslabs/databricks/0.3.5/docs/resources/mws_workspaces) | resource |
| [random_string.naming](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [time_sleep.wait](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [databricks_aws_assume_role_policy.this](https://registry.terraform.io/providers/databrickslabs/databricks/0.3.5/docs/data-sources/aws_assume_role_policy) | data source |
| [databricks_aws_bucket_policy.this](https://registry.terraform.io/providers/databrickslabs/databricks/0.3.5/docs/data-sources/aws_bucket_policy) | data source |
| [databricks_aws_crossaccount_policy.cross_account_iam_policy](https://registry.terraform.io/providers/databrickslabs/databricks/0.3.5/docs/data-sources/aws_crossaccount_policy) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | default aws region | `string` | `"us-west-2"` | no |
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | The CIDR block for the VPC | `string` | `"10.4.0.0/16"` | no |
| <a name="input_databricks_account_id"></a> [databricks\_account\_id](#input\_databricks\_account\_id) | External ID provided by third party. | `string` | n/a | yes |
| <a name="input_databricks_account_password"></a> [databricks\_account\_password](#input\_databricks\_account\_password) | databricks account password | `string` | n/a | yes |
| <a name="input_databricks_account_username"></a> [databricks\_account\_username](#input\_databricks\_account\_username) | databricks account username | `string` | n/a | yes |
| <a name="input_existing_role_name"></a> [existing\_role\_name](#input\_existing\_role\_name) | If you want to use existing role name, else a new role will be created | `string` | `null` | no |
| <a name="input_prjid"></a> [prjid](#input\_prjid) | (Required) Name of the project/stack e.g: mystack, nifieks, demoaci. Should not be changed after running 'tf apply' | `string` | n/a | yes |
| <a name="input_profile_for_iam"></a> [profile\_for\_iam](#input\_profile\_for\_iam) | profile to use for IAM | `string` | `null` | no |
| <a name="input_profile_to_use"></a> [profile\_to\_use](#input\_profile\_to\_use) | Getting values from ~/.aws/credentials | `string` | `"default"` | no |
| <a name="input_teamid"></a> [teamid](#input\_teamid) | (Required) Name of the team/group e.g. devops, dataengineering. Should not be changed after running 'tf apply' | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_databricks_credentials_id"></a> [databricks\_credentials\_id](#output\_databricks\_credentials\_id) | databricks credentials id |
| <a name="output_databricks_deployment_name"></a> [databricks\_deployment\_name](#output\_databricks\_deployment\_name) | databricks deployment name |
| <a name="output_databricks_host"></a> [databricks\_host](#output\_databricks\_host) | databricks hostname |
| <a name="output_databricks_mws_credentials_id"></a> [databricks\_mws\_credentials\_id](#output\_databricks\_mws\_credentials\_id) | databricks mws credentials id |
| <a name="output_databricks_mws_network_id"></a> [databricks\_mws\_network\_id](#output\_databricks\_mws\_network\_id) | databricks mws network id |
| <a name="output_databricks_mws_storage_bucket_name"></a> [databricks\_mws\_storage\_bucket\_name](#output\_databricks\_mws\_storage\_bucket\_name) | databricks mws storage bucket name |
| <a name="output_databricks_mws_storage_id"></a> [databricks\_mws\_storage\_id](#output\_databricks\_mws\_storage\_id) | databricks mws storage id |
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | iam role arn |
| <a name="output_inline_policy_id"></a> [inline\_policy\_id](#output\_inline\_policy\_id) | inline policy id |
| <a name="output_s3_bucket_arn"></a> [s3\_bucket\_arn](#output\_s3\_bucket\_arn) | s3 bucket arn |
| <a name="output_s3_bucket_id"></a> [s3\_bucket\_id](#output\_s3\_bucket\_id) | s3 bucket id |
| <a name="output_s3_bucket_name"></a> [s3\_bucket\_name](#output\_s3\_bucket\_name) | s3 bucket name |
| <a name="output_storage_configuration_id"></a> [storage\_configuration\_id](#output\_storage\_configuration\_id) | databricks storage configuration id |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | vpc id |
| <a name="output_vpc_route_table_ids"></a> [vpc\_route\_table\_ids](#output\_vpc\_route\_table\_ids) | list of VPC route tables IDs |
| <a name="output_vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#output\_vpc\_security\_group\_ids) | list of VPC security group IDs |
| <a name="output_vpc_subnet_ids"></a> [vpc\_subnet\_ids](#output\_vpc\_subnet\_ids) | list of subnet ids within VPC |
| <a name="output_workspace_url"></a> [workspace\_url](#output\_workspace\_url) | databricks workspace url |
