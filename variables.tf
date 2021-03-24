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