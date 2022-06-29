resource "yandex_vpc_network" "default" {
  name = "default-net"
}

resource "yandex_vpc_subnet" "default-subnet" {
  count 	 = 2
  name           = "subnet-${count.index}"
  v4_cidr_blocks = [var.cidrs[count.index]]
  zone           = var.zones[count.index]
  network_id     = "${yandex_vpc_network.default.id}"
}

resource "yandex_dns_zone" "bysart_ru" {
  zone             = "bysart.ru."
  public           = true
}

resource "yandex_dns_recordset" "revproxy" {
  zone_id = yandex_dns_zone.bysart_ru.id
  name    = "bysart.ru."
  type    = "A"
  ttl     = 200
  data    = ["${yandex_compute_instance.mashine[0].network_interface.0.nat_ip_address}"]
}
