module "docker_app" {
  source = "./modules/docker-app"
  network_name = var.network_name
  web_data_volume_name = var.web_data_volume_name
  nginx_image = var.nginx_image
  curl_image = var.curl_image
  nginx_host_port = var.nginx_host_port
  username = var.username
  repository_name = var.repository_name
  repository_private = var.repository_private
  gitea_token = var.gitea_token

}

