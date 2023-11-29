resource "google_compute_address" "ip_adress" {
    name = var.name
    subnetwork = var.network_id
    address_type = "INTERNAL"
    address = join("", ["10.0.41.", split("-", var.name)[2]])
}