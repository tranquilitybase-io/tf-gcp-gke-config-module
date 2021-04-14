variable "project_id" {
  description = "Project ID to deploy into"
  type        = string
}

variable "cluster_name" {
  description = "Cluster name"
  type = string
}

variable "sync_url" {
  description = "Repo sync url"
  type = string
}

variable "root_manifest_folder_name" {
  description = "Root folder that holds manifests"
  type = string
}

variable "cluster_region" {
  description = "Region of gke cluster"
  type = string
}

variable "forward_proxy_name" {
  description = "Forward proxy instance name"
  type = string
}

variable "forward_proxy_zone" {
  description = "Forward proxy instance zone"
  type = string
}
