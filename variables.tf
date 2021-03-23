variable "forward_proxy_name" {
  description = "Forward proxy name"
  type        = string
  default     = null
}

variable "project_id" {
  description = "Project ID to deploy into"
  type        = string
  default     = null
}

variable "zone" {
  description = "Zone of forward proxy"
  type        = string
  default     = null
}