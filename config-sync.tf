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

###
# Deploy and configure config sync
###

resource "local_file" "config-sync-management-yaml" {
  filename = "./config-management.yaml"
  content = yamlencode({
    "apiVersion" : "configmanagement.gke.io/v1",
    "kind" : "ConfigManagement",
    "metadata" : {"name" = "config-management"},
    "spec" : {"clusterName" = var.cluster_name,"git" : {"syncRepo" = var.sync_url,"syncBranch" = var.sync_branch,"secretType" = var.secret_type,"policyDir" = var.root_manifest_folder_name}}
  }
  )
}

resource "null_resource" "gke-config" {
    triggers = {
      always = timestamp()
    }
  provisioner "local-exec" {
    command     = "./postbuildscripts/config-sync.sh ${var.cluster_name} ${var.project_id} ${var.cluster_region} ${var.forward_proxy_name} ${var.forward_proxy_zone} ${var.istio_version}"

    interpreter = ["bash", "-c"]
  }
  depends_on = [local_file.config-sync-management-yaml]
}

resource "local_file" "secret-yaml" {
  count = length(keys(var.secret_data))

  filename = "./secret-${count.index}.yaml"
  content = yamlencode({
    "apiVersion" : "v1",
    "kind" : "Secret",
    "metadata" : {
      "name" = element(keys(var.secret_data), count.index)
    },
    "type" : "Opaque",
    "data" : {
      "KEY_DATA" = base64encode(element(values(var.secret_data), count.index))
    },
  })

  depends_on = [local_file.config-sync-management-yaml]
}

