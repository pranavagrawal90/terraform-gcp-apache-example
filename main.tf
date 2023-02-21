resource "google_compute_firewall" "firewall" {
  name    = "allow-http"
  network = var.vpc_name
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  source_ranges = ["0.0.0.0/0"] # Not So Secure. Limit the Source Range
  target_tags   = ["http-server"]
}

resource "google_compute_firewall" "ssh_firewall" {
  name    = "allow-ssh"
  network = var.vpc_name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = [var.my_ip]
  target_tags   = ["ssh-server"]
}


resource "google_compute_instance" "vm_instance" {
  name         = "wsl-test"
  machine_type = var.instance_type
  zone         = "us-central1-a"
  tags = ["http-server"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = var.vpc_name
    access_config {
    }
  }

  metadata_startup_script = <<EOT
#!/bin/bash
apt-get update
apt install apache2 apache2-utils -y
sudo systemctl enable apache2
sudo systemctl start apache2
EOT

}
