variable "disk_name" {
    description = "Nome do disco a ser criado"
    type = string
}

variable "disk_type" {
    description = "Tipo do disco a ser criado. Pode ser pd-ssd, pd-standard e pd-balanced"
    type = string
}

variable "disk_size" {
    description = "Tamanho em bytes do disco"
    type = number
}