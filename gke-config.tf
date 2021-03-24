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

//resource "null_resource" "kubectl" {
//  //  triggers = {
//  //    always = timestamp()
//  //  }
//  provisioner "local-exec" {
//    command     = "gcloud compute ssh ${data.google_compute_instance_group.mig_instances.instances} --project ${var.project_id} -- -L 3128:localhost:3128 -N -q -f"
//    interpreter = ["bash", "-c"]
//  }
//}
