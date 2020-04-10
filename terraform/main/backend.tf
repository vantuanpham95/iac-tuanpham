terraform {
  required_version = "~> 0.12.2"
  backend "gcs" {
    bucket      = "terraform-tundo-0612"
    credentials = "../credentials.json"
  }
}
