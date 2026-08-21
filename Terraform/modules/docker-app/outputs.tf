output "nginx_container_id" {
  value       = docker_container.exam_web_server.id
  description = "The ID of the Nginx web server container"
}

output "health_checker_container_id" {
  value       = docker_container.exam_health_checker.id
  description = "The ID of the curl health checker container"
}

output "network_id" {
  value       = docker_network.exam_network.id
  description = "The ID of the custom Docker network"
}