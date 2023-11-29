variable "vm_name" {
    description = "Nome da VM a ser criada"
    type = string
}

variable "vm_size" {
    description = "Tamanho da VM a ser criada"
    type = string
}

variable "vm_ip" {
    description = "IP estatico da VM"
    type = string
}

variable "vm_subnet" {
    description = "Id da subnet da vm"
    type = string
}

variable "data_disk_id" {
    description = "Id do disco de dados"
    type = string
}

variable "log_disk_id" {
    description = "Id do disco de log"
    type = string
}