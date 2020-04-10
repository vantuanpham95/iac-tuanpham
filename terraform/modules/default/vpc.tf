resource "google_compute_network" "vpc" {
  name                    = format("%s-vpc", var.var_env_name)
  auto_create_subnetworks = "false"
  routing_mode            = "GLOBAL"
}

output "vpc_self_link" {
  value = google_compute_network.vpc.self_link
}
