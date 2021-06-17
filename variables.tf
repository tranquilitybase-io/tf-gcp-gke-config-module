# Copyright 2021 The Tranquility Base Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

variable "project_id" {
  description = "Project ID to deploy into"
  type        = string
}

###
# Creation of config-management config sync file
###

variable "cluster_name" {
  description = "Cluster name"
  type = string
}

variable "sync_url" {
  description = "Repo sync url"
  type = string
}

variable "sync_branch" {
  description = "Sync branch"
  type = string
  default = "master"
}

variable "secret_type" {
  description = "Secret type for sync repo"
  type = string
  default = "none"
}

variable "root_manifest_folder_name" {
  description = "Root folder that holds manifests"
  type = string
}

variable "cluster_region" {
  description = "Region of gke cluster"
  type = string
}

variable "forward_proxy_name" {
  description = "Forward proxy instance name"
  type = string
}

variable "forward_proxy_zone" {
  description = "Forward proxy instance zone"
  type = string
}

variable "istio_version" {
  description = "input for istio_version"
  type = string
}

###
# Workload identity
###

variable "service_account_description" {
  description = "Service account descriptions used in workload identity"
  type        = string
  default     = "Service account used in workload identity"
}

variable "service_account_prefix" {
  description = "Prefix for service accounts used in workload identity"
  type        = string
  default     = "gke"
}

variable "workload_identity_service_account" {
  type = map(object({
    service_account_name = string
    namespace = string
  }))
  description = "Service account to create in gcp for workload identity"
  default = {}
}


/******************************************
  Org variables
 *****************************************/

variable "domains_to_allow" {
  description = ""
  type = list(string)
  default = ["example.com"]
}

variable "billing_data_users" {
  description = ""
  type = string
  default = "gcp-billing-admins@example.com"
}

variable "audit_data_users" {
  description = ""
  type = string
  default = "gcp-security-admins@example.com"
}

variable "org_id" {
  description = ""
  type = string
  default = "000000000000"
}

variable "billing_account" {
  description = ""
  type = string
  default = "000000-000000-000000"
}

variable "default_region" {
  description = ""
  type = string
  default = "europe-west2"
}

variable "scc_notification_name" {
  description = ""
  type = string
  default = "scc-notify"
}

variable "parent_folder" {
  description = ""
  type = string
  default = "01234567890"
}

variable "scc_notification_filter" {
  description = ""
  type = string
  default = "state=\\\"ACTIVE\\\""
}

variable "create_access_context_manager_access_policy" {
  description = ""
  type = bool
  default = false
}

variable "bootstrap_service_account" {
  description = ""
  type = string
  default = ""
}
