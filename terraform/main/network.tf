resource "google_compute_address" "management_static_ips" {
  name   = "management-static-ip"
  region = var.region
}

# output "management_static_ips" {
#   value = "${google_compute_address.management_static_ips.address}"
# }
