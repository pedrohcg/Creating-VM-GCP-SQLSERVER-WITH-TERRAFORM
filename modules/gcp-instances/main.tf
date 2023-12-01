resource "google_compute_attached_disk" "attach_data_disk" {
    disk = var.data_disk_id
    instance = google_compute_instance.vm_instance.id
}

resource "google_compute_attached_disk" "attach_log_disk" {
    disk = var.log_disk_id
    instance = google_compute_instance.vm_instance.id
}

resource "google_compute_instance" "vm_instance" {
    name = var.vm_name
    machine_type = var.vm_size
    zone = "us-east1-b"

    labels = {
        foo = "baar"
    }

    tags = ["demo-vm-instance"]

    #Disco de inicialização
    boot_disk {
        initialize_params {
            size = 128
            type = "pd-ssd"
            image = "windows-server-2016-dc-v20231115"
        }
    }

    service_account {
        scopes = ["cloud-platform"]
    }

    network_interface {
        subnetwork = var.vm_subnet
        network_ip = var.vm_ip
    }
}