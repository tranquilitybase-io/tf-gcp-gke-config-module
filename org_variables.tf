###
# Copy and populate common.auto.tfvars.tpl to deployment folder
###

resource "local_file" "org_tfvars" {
  filename = "./postbuildscripts/org.auto.tfvars"
  content = templatefile("./templates/org.tfvars.tpl",
  {
    domains_to_allow                            = jsonencode(var.domains_to_allow)
    billing_data_users                          = var.billing_data_users
    audit_data_users                            = var.audit_data_users
    org_id                                      = var.org_id
    billing_account                             = var.billing_account
    terraform_service_account                   = var.terraform_service_account
    default_region                              = var.default_region
    scc_notification_name                       = var.scc_notification_name
    parent_folder                               = var.parent_folder
    scc_notification_filter                     = var.scc_notification_filter
    create_access_context_manager_access_policy = var.create_access_context_manager_access_policy
  }
  )
}