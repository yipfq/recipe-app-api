variable "tf_state_bucket" {
  description = "bucket name"
  default     = "alex-test-bucket-for-recipe-api-app"
}

variable "tf_state_lock_table" {
  description = "table name"
  default     = "alex-test-recipe-app-api-tf-lock"
}

variable "project" {
  description = "project name"
  default     = "recipe-app-api"
}

variable "contact" {
  description = "contact"
  default     = "alex@abc.com"
}
