# ip externo excluir dps
resource "google_compute_address" "static" {
  name = "ipv4-address"
}

resource "google_compute_attached_disk" "attach_data_disk" {
    disk = var.data_disk_id
    instance = google_compute_instance.vm_instance.id
}

resource "google_compute_attached_disk" "attach_log_disk" {
    disk = var.log_disk_id
    instance = google_compute_instance.vm_instance.id
    depends_on = [google_compute_attached_disk.attach_data_disk]

    provisioner "file" {
        connection {
            type = "winrm"
            user = trim(split(":", split("\n", file("./pass.txt"))[2])[1], " ")
            password = trim(split(":", split("\n", file("./pass.txt"))[1])[1], " ")
            host = google_compute_address.static.address
            port = "5985"
            https = false
            insecure = true
        }

        source = "./scripts-powershell/discos.ps1"
        destination = "C:/discos.ps1"
    }

     provisioner "remote-exec" {
        connection {
            type = "winrm"
            user = trim(split(":", split("\n", file("./pass.txt"))[2])[1], " ")
            password = trim(split(":", split("\n", file("./pass.txt"))[1])[1], " ")
            host = google_compute_address.static.address
            port = "5985"
            https = false
            insecure = true
        }

        inline = ["powershell -ExecutionPolicy Unrestricted -File C:/discos.ps1 -Schedule"]
    }
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
        # ip externo excluir dps
        access_config {
            nat_ip = google_compute_address.static.address
        }
    }

    provisioner "local-exec" {
        command = join(" ", ["./inicial.sh", var.vm_name])
    }
}