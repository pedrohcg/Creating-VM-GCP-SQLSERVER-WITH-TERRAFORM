provider "google" {
    project = "criandovm-terraform"
    region = "us-east1"
    zone = "us-east1-b"
    access_token = var.token
}

resource "google_compute_network" "default" {
  name = "dev-network"
}

resource "google_compute_subnetwork" "default" {
  name          = "dev-subnet"
  ip_cidr_range = "10.0.0.0/16"
  network       = google_compute_network.default.id
}

module "ip-address" {
    source = "./modules/ip-address"
    name = var.vm_name
    network_id = google_compute_subnetwork.default.id
}

module "disk-data" {
    source = "./modules/gcp-disks"
    disk_name = join("-", [var.vm_name, "datadisk-1"])
    disk_type = var.disk_type
    disk_size = var.disk_size_data
}

module "disk-log" {
    source = "./modules/gcp-disks"
    disk_name = join("-", [var.vm_name, "logdisk-1"])
    disk_type = var.disk_type
    disk_size = var.disk_size_log
}

module "gcp-instance" {
    source = "./modules/gcp-instances"
    vm_name = var.vm_name
    vm_size = var.vm_size
    vm_subnet = google_compute_subnetwork.default.id
    vm_ip = module.ip-address.ip
    data_disk_id = module.disk-data.disk_id
    log_disk_id = module.disk-log.disk_id
}