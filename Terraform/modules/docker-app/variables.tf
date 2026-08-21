variable "username" {
  type = string
}


variable "repository_name" {
  type = string
}

variable "repository_private" {
  type    = bool
}

variable "gitea_token" {
  type = string
}

variable "network_name" {
  type = string
#  default = "exam-network"
}

variable "web_data_volume_name" {
  type = string
#  default = "exam-web-data"
}

variable "nginx_image" {
  type = string
#  default = "nginx:1.27.4"
}

variable "curl_image" {
  type = string
 # default = "curlimages/curl:8.17.0"
}

variable "nginx_host_port" {
  description = "The host port mapped to the Nginx container"
  type        = number
 # default     = 8080

  validation {
    condition     = var.nginx_host_port >= 1024 && var.nginx_host_port <= 65535
    error_message = "The Nginx host port must be within the 1024–65535 range."
  }
}
