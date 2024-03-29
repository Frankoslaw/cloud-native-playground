variable "access_key" {
  description = "Access key to AWS console"
}
variable "secret_key" {
  description = "Secret key to AWS console"
}

variable "server_region" {
  description = "Region to deploy server"
  type        = string
  default     = "eu-central-1"
}

variable "server_username" {
  description = "Admin Username to access server"
  type        = string
  default     = "openvpn"
}

variable "server_password" {
  description = "Admin Password to access server"
  type        = string
  default     = "password"
}
