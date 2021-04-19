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

module "workload_identity_service_accounts" {
  source        = "terraform-google-modules/service-accounts/google"
  version       = "~> 3.0"

  for_each      = var.service_account_names

  description   = var.service_account_description
  names         = [each.key]
  prefix        = var.service_account_prefix
  project_id    = var.project_id
}

module "service_account_iam_bindings" {
  source = "terraform-google-modules/iam/google//modules/service_accounts_iam"

  for_each         = var.kube_service_accounts

  service_accounts = [module.workload_identity_service_accounts]
  project          = var.project_id
  mode             = "additive"
  bindings = {
    "roles/iam.workloadIdentityUser" = [
      "serviceAccount:${var.project_id}.svc.id.goog[${each.key}]",
    ]
  }
}
