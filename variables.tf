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

#variable "databricks_account_id" {}

variable "databricks_account_id" {
  description = "External ID provided by third party."
  type        = string
}

/*
variable "cidr_block" {
  description = "VPC CIDR block"
  default     = "10.4.0.0/16"
  type        = string
}
*/

resource "random_string" "naming" {
  special = false
  upper   = false
  length  = 3
}

locals {
  suffix = random_string.naming.result
}
/*
variable "path" {
  description = "The path to the IAM Role."
  type        = string
  default     = "/"
}

variable "force_detach_policies" {
  description = "Forcibly detach the policy of the role."
  type        = bool
  default     = false
}

variable "policy_arn" {
  description = "Attaches the policies to the IAM Role."
  type        = list(any)
  default     = null
}

variable "policy_identifier" {
  description = "Policy Indentifier"
  default     = ["ec2.amazonaws.com"]
  type        = list(string)
}

variable "role_name" {
  description = "IAM role"
  default     = ""
  type        = string
}

variable "assume_role_policy" {
  description = "IAM assume role policy"
  default     = ""
  type        = string
}
*/
variable "profile_for_iam" {
  description = "profile to use for IAM"
  default     = null
  type        = string
}
