variable "project_id" {}

variable "region" {
  default = "asia-east1"
}

variable "env_name" {
  default = "test"
}

variable "private_subnet" {
  default = "10.10.1.0/24"
}

variable "public_subnet" {
  default = "10.10.2.0/24"
}

variable "office_ip_ranges" {
  type    = "list"
  default = ["1.55.207.255/32"]
}

variable "credentials_file_path" {
  default = "../credentials.json"
}
