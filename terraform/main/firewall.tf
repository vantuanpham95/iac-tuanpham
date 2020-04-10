resource "google_compute_firewall" "management-public-access" {
  name    = "management-public-access"
  network = module.vpc.vpc_self_link

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  target_tags   = ["public-management"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "management-access-app" {
  name    = "management-access-app"
  network = module.vpc.vpc_self_link

  allow {
    protocol = "tcp"
    ports    = ["80", "443", "22"]
  }

  target_tags = ["private-app"]
  source_tags = ["public-management"]
}

resource "google_compute_firewall" "allow-ssh-from-office" {
  name    = "allow-ssh-from-office"
  network = module.vpc.vpc_self_link

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = concat(var.office_ip_ranges)
  target_tags   = ["allow-ssh-from-office"]
}

