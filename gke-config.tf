resource "null_resource" "kubectl" {
  //  triggers = {
  //    always = timestamp()
  //  }
  provisioner "local-exec" {
    command     = "gcloud compute ssh ${var.forward_proxy_name} --project ${var.project_id} --zone ${var.forward_proxy_zone} -- -L 3128:localhost:3128 -N -q -f"
    interpreter = ["bash", "-c"]
  }
}