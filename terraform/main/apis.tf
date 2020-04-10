variable gcp_apis {
  default = [
    "cloudresourcemanager",
    "iam",
    "compute",
    "servicenetworking",
    "oslogin",
  ]
}

resource "google_project_service" "apis" {
  count = length(var.gcp_apis)

  service            = format("%s%s", element(var.gcp_apis, count.index), ".googleapis.com")
  disable_on_destroy = false
}
