terraform {
  required_providers {
    gitea = {
      source  = "go-gitea/gitea"
      version = "0.7.0"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "4.5.0"
    }

  }
}

provider "docker" {
  host = "npipe:////./pipe/docker_engine"
}

provider "gitea" {
  base_url = "http://192.168.8.103:3000/"
  token    = var.gitea_token
}

data "gitea_user" "current" {
  username = var.username
}

resource "gitea_repository" "test" {
  username     = data.gitea_user.current.username
  name         = var.repository_name
  private      = var.repository_private
  issue_labels = "Default"
  license      = "MIT"
  gitignores   = "Go"
}

resource "gitea_repository_branch_protection" "test" {
  username   = data.gitea_user.current.username
  name       = gitea_repository.test.name
  rule_name  = "main"
  enable_push = true
  required_approvals = 1
}



# Create the custom network
resource "docker_network" "exam_network" {
  name = var.network_name
}

# Create the volume for web data
resource "docker_volume" "exam_web_data" {
  name = var.web_data_volume_name
}

# Pull the Nginx image
resource "docker_image" "nginx" {
  name = var.nginx_image
}

# Pull the curl image for health checking
resource "docker_image" "curl" {
  name = var.curl_image
}

# Start the Nginx web server container
resource "docker_container" "exam_web_server"{ 
  name  = "exam-web-server"
  image = docker_image.nginx.image_id

  # Network attachment
  networks_advanced {
    name = docker_network.exam_network.name
  }

  # Mount the volume
  volumes {
    volume_name    = docker_volume.exam_web_data.name
    container_path = "/var/cache/nginx"
  }

  # Port forwarding for localhost verification
  ports {
    internal = 80
    external = var.nginx_host_port

  }

  # Native Docker container healthcheck
  healthcheck {
    test     = ["CMD", "curl", "-f", "http://localhost:80/"]
    interval = "10s"
    retries  = 3
    timeout  = "5s"
  }

  # Labels requirement
  labels {
    label = "project"
    value  = "development"
  }
    # Second label block
labels {
  label = "managed-by"
  value = "terraform"
    }
restart = "unless-stopped"
  }


# Start the health checker container
resource "docker_container" "exam_health_checker" {
  name  = "exam-health-checker"
  image = docker_image.curl.image_id

  # Network attachment
  networks_advanced {
    name = docker_network.exam_network.name
  }

  # Command to continuously ping Nginx
  entrypoint = [
    "sh", 
    "-c", 
    "while true; do curl -sf http://exam-web-server:80 || echo 'Health check failed'; sleep 30; done"
  ]

  # Container dependency
  depends_on = [docker_container.exam_web_server]

  # Labels requirement
  labels {
    label = "exam"
    value  = "health-checker"
  }
}
