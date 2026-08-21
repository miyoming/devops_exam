variable "username" {
  type = string
  default = "username"
}
variable "repository_name" {
  type = string
  default = "terraform-docker-exam"
}
variable "repository_private" {
  type = bool
  default = true
}

variable "gitea_token" {
  type = string
}

variable "network_name" {
  type = string
  default = "exam-network"
}

variable "web_data_volume_name" {
  type = string
  default = "exam-web-data"
}

variable "nginx_image" {
  type = string
  default = "nginx:1.27.4"
}

variable "curl_image" {
  type = string
  default = "curlimages/curl:8.17.0"
}

variable "nginx_host_port" {
  description = "The host port mapped to the Nginx container"
  type        = number
  default     = 8080
}