resource "local_file" "inventory" {
  content = <<-DOC
    
    [revproxy]
    bysart.ru ansible_host=${yandex_compute_instance.mashine[0].network_interface.0.nat_ip_address} email=ya.bysart@yandex.ru domain=bysart.ru
    
    [db]
    db01.bysart.ru ansible_host=${yandex_compute_instance.mashine[1].network_interface.0.nat_ip_address}
    db02.bysart.ru ansible_host=${yandex_compute_instance.mashine[2].network_interface.0.nat_ip_address}

    [db01]
    db01.bysart.ru ansible_host=${yandex_compute_instance.mashine[1].network_interface.0.nat_ip_address}

    [db02]
    db02.bysart.ru ansible_host=${yandex_compute_instance.mashine[2].network_interface.0.nat_ip_address}
   
    [wordpress]
    app.bysart.ru ansible_host=${yandex_compute_instance.mashine[3].network_interface.0.nat_ip_address} domain=bysart.ru 

    [gitlab]
    gitlab.bysart.ru ansible_host=${yandex_compute_instance.mashine[4].network_interface.0.nat_ip_address} domain=bysart.ru gitlab_external_url=http://gitlab.bysart.ru/

    [runner]
    runner.bysart.ru ansible_host=${yandex_compute_instance.mashine[5].network_interface.0.nat_ip_address} domain=bysart.ru  

    [monitoring]
    monitoring.bysart.ru ansible_host=${yandex_compute_instance.mashine[6].network_interface.0.nat_ip_address} domain=bysart.ru

    DOC

  filename = "../ansible/inventory.yml"

  depends_on = [
    yandex_compute_instance.mashine[0],
    yandex_compute_instance.mashine[1],
    yandex_compute_instance.mashine[2],
    yandex_compute_instance.mashine[3],
    yandex_compute_instance.mashine[4],
    yandex_compute_instance.mashine[5],
    yandex_compute_instance.mashine[6],
  ]
}
