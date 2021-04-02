variable "teamid" {
  description = "(Required) Name of the team/group e.g. devops, dataengineering. Should not be changed after running 'tf apply'"
}

variable "prjid" {
  description = "(Required) Name of the project/stack e.g: mystack, nifieks, demoaci. Should not be changed after running 'tf apply'"
}

variable "profile_to_use" {
  description = "Getting values from ~/.aws/credentials"
  default     = "default"
}

variable "aws_region" {
  default = "us-west-2"
}

variable "databricks_account_username" {}
variable "databricks_account_password" {}
//variable "databricks_account_id" {}



variable "databricks_account_id" {
  description = "External ID provided by third party."
}

variable "cidr_block" {
  default = "10.4.0.0/16"
}

resource "random_string" "naming" {
  special = false
  upper   = false
  length  = 3
}

locals {
  suffix = random_string.naming.result
}

variable "path" {
  description = "The path to the IAM Role."
  type        = string
  default     = "/"
}

//variable "description" {
//  description = "The description of the IAM Role."
//  default     = null
//}

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
  default = ["ec2.amazonaws.com"]
}

variable "role_name" {
  default = ""
}

variable "assume_role_policy" {
  default = ""
}

variable "profile_for_iam" {
  default = null
}