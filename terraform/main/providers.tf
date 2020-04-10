provider "google" {
  credentials = var.credentials_file_path
  version     = "~> 3.0"

  project = var.project_id
  region  = var.region
}

provider "google-beta" {
  credentials = var.credentials_file_path
  project = var.project_id
  region = var.region
}
