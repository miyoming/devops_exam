# terraform-docker-exam  




create .env file for docker compose file  

sample env file:  

USER_UID=1000  
USER_GID=1000  
GITEA__database__DB_TYPE=postgres  
GITEA__database__HOST=db:5432  
GITEA__database__NAME=gitea  
GITEA__database__USER=gitea  
GITEA__database__PASSWD=gitea  
POSTGRES_USER=postgres_user_here  
POSTGRES_PASSWORD=postgres_password_here  
POSTGRES_DB=postgres_dbpassword_here  


create terraform.tfvars under terraform folder

sample terraform.tfvars:  

  #network_name = "exam-network"  
  web_data_volume_name = "exam-web-data"  
  nginx_image = "nginx:1.27.4"  
  curl_image = "curlimages/curl:8.17.0"  
  nginx_host_port = 8081  
  username = "username"  
  repository_name = "terraform-docker-exam"  
  repository_private = true  
  gitea_token = "token_here"  
