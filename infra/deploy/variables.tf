variable "prefix" {
  description = "prefix for resource name"
  default     = "raa"
}

variable "project" {
  description = "project name"
  default     = "recipe-app-api"
}

variable "contact" {
  description = "contact email for tagging resources"
  default     = "alex@abc.com"
}

variable "db_username" {
  description = "db username"
  default     = "recipeapp"
}

variable "db_password" {
  description = "db password"
}

variable "ecr_proxy_image" {
  description = "path to the ECR repo with the proxy image"
}

variable "ecr_app_image" {
  description = "Path to the ECR repo with the API image"
}

variable "django_secret_key" {
  description = "Secret key for Django"
}
