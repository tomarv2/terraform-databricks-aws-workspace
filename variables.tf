variable "teamid" {
  description = "(Required) Name of the team/group e.g. devops, dataengineering. Should not be changed after running 'tf apply'"
  type        = string
}

variable "prjid" {
  description = "(Required) Name of the project/stack e.g: mystack, nifieks, demoaci. Should not be changed after running 'tf apply'"
  type        = string
}

variable "profile_to_use" {
  description = "Getting values from ~/.aws/credentials"
  type        = string
  default     = "default"
}

variable "aws_region" {
  description = "default aws region"
  type        = string
  default     = "us-west-2"
}

variable "databricks_account_username" {
  description = "databricks account username"
  type        = string
}
variable "databricks_account_password" {
  description = "databricks account password"
  type        = string
}

variable "databricks_account_id" {
  description = "External ID provided by third party."
  type        = string
}

resource "random_string" "naming" {
  special = false
  upper   = false
  length  = 3
}

locals {
  suffix = random_string.naming.result
}

variable "profile_for_iam" {
  description = "profile to use for IAM"
  default     = null
  type        = string
}
