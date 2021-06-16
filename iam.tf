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

//module "workload-identity" {
//  source    = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
//  version   = "14.1.0"
//
//  for_each            = var.workload_identity_service_account
//
//  annotate_k8s_sa     = false
//  use_existing_k8s_sa = true
//  name                = each.value["service_account_name"]
//  namespace           = each.value["namespace"]
//  project_id          = var.project_id
//}
