output "nginx_app" {
  value = module.docker_app.nginx_container_id
}

output "health_checker" {
  value = module.docker_app.health_checker_container_id
}

output "docker_network" {
  value = module.docker_app.network_id
}