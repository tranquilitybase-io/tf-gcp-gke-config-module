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

###
# Workload identity
###

variable "service_account_description" {
  description = "Service account descriptions used in workload identity"
  type        = string
  default     = "service account used in workload identity"
}

variable "service_account_names" {
  description = "Service accounts to create for workload identity"
  type        = list(string)
}

variable "service_account_prefix" {
  description = "Prefix for service accounts used in workload identity"
  type        = string
  default     = "gke"
}

variable "kube_service_accounts" {
  description = "Kubernetes service accounts with namespaces"
  type        = list(string)
}