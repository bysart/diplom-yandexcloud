variable "yandex_cloud_id" {
  default = "b1gvejhn1spuhaec5omf"
}

variable "yandex_folder_id" {
  default = "b1gl2va1p0mbg72a3mqp"
}

variable "cidrs" {
  type = list(string)
  default = ["192.168.100.0/24", "192.168.101.0/24"]
}

variable "zones" {
  type = list(string)  
  default = ["ru-central1-a", "ru-central1-b"]
}

variable "ubu" {
  default = "fd87tirk5i8vitv9uuo1"
}

variable "vm" {
  type = list(string)
  default = ["bysart.ru", "db01.bysart.ru", "db02.bysart.ru", "app.bysart.ru", "gitlab.bysart.ru", "runner.bysart.ru", "monitoring.bysart.ru"]
}

