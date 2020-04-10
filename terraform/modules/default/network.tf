resource "google_compute_subnetwork" "public_subnet" {
  name          = format("%s-public", var.var_env_name)
  ip_cidr_range = var.var_public_subnet
  network       = var.var_network_self_link
  region        = var.var_region_name
}

resource "google_compute_subnetwork" "private_subnet" {
  name          = format("%s-private", var.var_env_name)
  ip_cidr_range = var.var_private_subnet
  network       = var.var_network_self_link
  region        = var.var_region_name
}
