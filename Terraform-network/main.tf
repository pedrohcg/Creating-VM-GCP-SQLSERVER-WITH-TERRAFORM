provider "google" {
    project = "criandovm-terraform"
    region = "us-east1"
    zone = "us-east1-b"
    access_token = var.token
}

resource "google_compute_network" "vpc_network" {
  name = "dev-network"
}

resource "google_compute_subnetwork" "subnet" {
  name          = "dev-subnet"
  ip_cidr_range = "10.0.0.0/16"
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_firewall" "rdp-rule" {
  name = "demo-rdp"
  network = google_compute_network.vpc_network.name
  allow {
    protocol = "tcp"
    ports = ["3389"]
  }
  target_tags = ["demo-vm-instance"]
  source_ranges = ["0.0.0.0/0"]
}