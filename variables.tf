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

//variable "forward_proxy_name" {
//  description = "Forward proxy name"
//  type        = string
//  default     = null
//}

variable "project_id" {
  description = "Project ID to deploy into"
  type        = string
  default     = null
}

variable "mig_name" {
  description = "Name of forward proxy mig"
  type = string
  default = null
}

variable "mig_instance_zone" {
  description = "Forward proxy zone"
  type = string
  default = null
}

## creation of config-management config sync file

variable "cluster_name" {
  description = "Cluster name"
  type = string
  default = "tb-mgmt-gke"
}

variable "sync_url" {
  description = "Repo sync url"
  type = string
  default = "https://github.com/tranquilitybase-io/tb-managementplane-gke-manifests.git"
}

variable "sync_branch" {
  description = "Sync branch"
  type = string
  default = "mvp3"
}

variable "secret_type" {
  description = "Secret type for sync repo"
  type = string
  default = "none"
}

variable "root_manifest_folder_name" {
  description = "Root folder that holds manifests"
  type = string
  default = "/tb-manifests"
}