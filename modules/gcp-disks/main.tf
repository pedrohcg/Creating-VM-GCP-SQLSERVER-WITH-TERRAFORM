resource "google_compute_disk" "disk" {
    name = var.disk_name
    type = var.disk_type
    size = var.disk_size
}