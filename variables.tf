variable "vm_name" {
    description = "Nome da vm a ser criada"
    type = string

    validation {
        condition = substr(var.vm_name, 0, 4) == "gc2d" && length(regexall("[0-9]+$", var.vm_name)) > 0
        error_message = "Nome de vm inválido"
    }
}

variable "vm_size" {
    description = "Tamanho da vm a ser criada"
    type = string
}

variable "token" {
    description = "Access Token GCP"
    type = string
}

variable "disk_type"{
    description = "Tipo do disco a ser criado. Pode ser pd-ssd, pd-standard e pd-balanced"
    type = string

    validation {
        condition = contains(["pd-ssd", "pd-standard", "pd-balanced"], var.disk_type)
        error_message = "O tipo de disco deve ser obrigatoriamente pd-ssd, pd-standard ou pd-balanced"
    }
}

variable "disk_size_data" {
    description = "Tamanho do disco em bytes"
    type = number
}

variable "disk_size_log" {
    description = "Tamanho do disco em bytes"
    type = number
}

variable "subnet" {
    description = "Nome da subnet"
    type = string
}