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

data "google_compute_instance_group" "mig_instances" {
  name    = var.mig_name
  project = var.project_id
  zone    = var.mig_instance_zone
}

resource "local_file" "config-management" {
  filename = "../../../../../config-management.yaml"
  content = yamlencode({
    "apiVersion" : "configmanagement.gke.io/v1",
    "kind" : "ConfigManagement",
    "metadata" : {"name" = "config-management"},
    "spec" : {"clusterName" = var.cluster_name,"git:" : {"syncRepo" = var.sync_url,"syncBranch" = var.sync_branch,"secretType" = var.secret_type,"policyDir" = var.root_manifest_folder_name}}
  }
  )
}

resource "null_resource" "getpwd" {
    triggers = {
      always = timestamp()
    }
  provisioner "local-exec" {
    command     = "../../../../../scripts/gke-config.sh ${var.cluster_name} ${var.project_id} ${var.cluster_region}"
    interpreter = ["bash", "-c"]
  }
}