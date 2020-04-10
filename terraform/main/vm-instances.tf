locals {
  management_list = [
    {
      #Taiwan
      vm_name         = "management"
      vm_zone         = "asia-east1-a"
      vm_machine_type = "f1-micro"
      vm_subnet       = "test-public"
      vm_tags         = ["management", "public-management", "allow-ssh-from-office"]
      vm_public_ip    = google_compute_address.management_static_ips.address
    },
  ]

  app_lists = [
    {
      # Taiwan
      vm_name         = "app-01"
      vm_zone         = "asia-east1-b"
      vm_machine_type = "f1-micro"
      vm_subnet       = "test-private"
      vm_tags         = ["app-01", "private-app", "allow-ssh-from-office"]
    },
    {
      # Taiwan
      vm_name         = "app-02"
      vm_zone         = "asia-east1-c"
      vm_machine_type = "f1-micro"
      vm_subnet       = "test-private"
      vm_tags         = ["app-02", "private-app", "allow-ssh-from-office"]
    },
  ]
}

resource "google_compute_instance" "management" {
  for_each     = { for vm in local.management_list : vm.vm_name => vm }
  name         = each.value.vm_name
  machine_type = each.value.vm_machine_type
  zone         = each.value.vm_zone
  tags         = each.value.vm_tags

  boot_disk {
    initialize_params {
      image = "ubuntu-1804-lts"
      size  = "10"
    }
  }

  network_interface {
    network    = module.vpc.vpc_self_link
    subnetwork = each.value.vm_subnet
    access_config {
      nat_ip = each.value.vm_public_ip
    }
  }

  scheduling {
    preemptible       = true
    automatic_restart = false
  }

  metadata_startup_script = <<EOT
    curl -sSO https://dl.google.com/cloudagents/install-monitoring-agent.sh && sudo bash install-monitoring-agent.sh
  EOT

  allow_stopping_for_update = true
}


resource "google_compute_instance" "app" {
  for_each     = { for vm in local.app_lists : vm.vm_name => vm }
  name         = each.value.vm_name
  machine_type = each.value.vm_machine_type
  zone         = each.value.vm_zone
  tags         = each.value.vm_tags

  boot_disk {
    initialize_params {
      image = "ubuntu-1804-lts"
      size  = "10"
    }
  }

  network_interface {
    network    = module.vpc.vpc_self_link
    subnetwork = each.value.vm_subnet
  }

  scheduling {
    preemptible       = true
    automatic_restart = false
  }

  metadata_startup_script = <<EOT
    curl -sSO https://dl.google.com/cloudagents/install-monitoring-agent.sh && sudo bash install-monitoring-agent.sh
  EOT

  allow_stopping_for_update = true
}
