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

module "gke-config" {
  source = "../.."

  cluster_name                      = var.cluster_name
  cluster_region                    = var.cluster_region
  forward_proxy_name                = var.forward_proxy_name
  forward_proxy_zone                = var.forward_proxy_zone
  project_id                        = var.project_id
  root_manifest_folder_name         = var.root_manifest_folder_name
  sync_url                          = var.sync_url
  workload_identity_service_account = var.workload_identity_service_account
  secret_data                       = var.secret_data
  istio_version                     = var.istio_version
}
