terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version =  ">= 0.13"

/*  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "os-tfstate"
    region     = "ru-central1"
    key        = "dir/file.tfstate"
    access_key = "YCAJEC1sGg5xCXXSWPXl5TViW"
    secret_key = "YCPDzxvdzBakSj6ndL-Z3j3Wem-91wmWro0AKZW-"

    skip_region_validation      = true
    skip_credentials_validation = true
  } */
}

provider yandex {
  service_account_key_file = "../../../secrets/key.json"
  cloud_id		   = var.yandex_cloud_id
  folder_id 		   = var.yandex_folder_id
}

resource "yandex_storage_bucket" "test" {
  bucket = "ostfstate"
}
