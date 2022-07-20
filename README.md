
---

Автор:<br>Быстровский Артём<br>
Преподаватель:<br> Булат Замилов, Олег Букатчук, Руслан Жданов

<h2>Дипломный практикум в YandexCloud</h2><br>

Старт работы:<br>15/06/2022<br>
Завершение работы:<br>21/07/2022
    
---

<br><h3>I. Задание по дипломной работе</h3>

Цели:

1. Зарегистрировать доменное имя (любое на ваш выбор в любой доменной зоне).
2. Подготовить инфраструктуру с помощью Terraform на базе облачного провайдера YandexCloud.
3. Настроить внешний Reverse Proxy на основе Nginx и LetsEncrypt.
4. Настроить кластер MySQL.
5. Установить WordPress.
6. Развернуть Gitlab CE и Gitlab Runner.
7. Настроить CI/CD для автоматического развёртывания приложения.
8. Настроить мониторинг инфраструктуры с помощью стека: Prometheus, Alert Manager и Grafana.

[Полный листинг задания](https://netology.ru/profile/program/fdvpspdc-2/lessons/135374/lesson_items/696439)

<br><h3>II. Требования для сдачи задания</h3>

1. Репозиторий со всеми Terraform манифестами и готовность продемонстрировать создание всех ресурсов с нуля.
2. Репозиторий со всеми Ansible ролями и готовность продемонстрировать установку всех сервисов с нуля.
3. Скриншоты веб-интерфейсов всех сервисов работающих по HTTPS на вашем доменном имени.
    - https://www.you.domain (WordPress)
    - https://gitlab.you.domain (Gitlab)
    - https://grafana.you.domain (Grafana)
    - https://prometheus.you.domain (Prometheus)
    - https://alertmanager.you.domain (Alert Manager)
4. Все репозитории рекомендуется хранить на одном из ресурсов (github.com или gitlab.com).

<br><h3>III. Выполение задания</h3>

Общая структура каталогов: 
- terraform -  каталог манифестов создания и настройки инфраструктуры
- ansible - роли, таски и настройки для деплоя и настройки на серверах необходимых сервисов

```
[sovar@fedora diplom-yandexcloud]$ tree -L 2
.
├── ansible
│   ├── db              
│   ├── gitlab
│   ├── monitoring
│   ├── nginx
│   ├── node_exporter
│   ├── runner
│   └── wordpress
├── README.md
└── terraform
    ├── ansible.cfg
    ├── ansible.tf
    ├── invetory.tf
    ├── main.tf
    ├── mashines.tf
    ├── net.tf
    ├── outputs.tf
    ├── ssh-key
    ├── terraform.tfstate
    ├── terraform.tfstate.backup
    └── variables.tf

9 directories, 12 files
```

Листинг необходимых скриншотов:

`https://www.bysart.ru (WordPress)`

![img.png](png/1.png)

`https://gitlab.you.domain (Gitlab)`

![img.png](png/2.png)

`https://grafana.you.domain (Grafana)`

![img.png](png/3.png)

`https://prometheus.you.domain (Prometheus)`

![img.png](png/4.png)

`https://alertmanager.you.domain (Alert Manager)`

![img.png](png/5.png)

<h4>Пояснительная записка по работе</h4>

1. Регистрация доменного имени

Доменное имя bysart.ru, регистратор nic.ru, домен делегирован DNS YandexCloud

![img.png](png/6.png)

2. Создание инфраструктуры

Выполнял работу для  workspace stage, можно было бы добавить  workspace prod, поднять аналогичную инфраструктуру в другой подсети, настроить пайп на тестирования изменения в stage, если успешное завершение тестов, то происходил бы автоматический пуш в prod. В силу ограниченности по ресурсам выбрал путь с одним workspace.

![img.png](png/7.png)

3. Установка Nginx и LetsEncrypt

```
[sovar@fedora nginx]$ tree
.
├── nginx-letsencrypt.yml
└── roles
    └── nginx-revproxy
        ├── tasks
        │   └── main.yml
        └── templates
            ├── http.j2
            ├── https.j2
            ├── index.html
            └── nginx.conf

4 directories, 6 files
```

4. Установка кластера MySQL

```
[sovar@fedora db]$ tree
.
├── db.yml
└── roles
    ├── db-install
    │   └── tasks
    │       └── main.yml
    ├── db-setup-master
    │   ├── tasks
    │   │   └── main.yml
    │   └── templates
    │       └── mysqld.cnf
    └── db-setup-slave
        ├── tasks
        │   └── main.yml
        └── templates
            └── mysqld.cnf

9 directories, 6 files
```

Статус реплики - выведена основная информация
```
mysql> SHOW REPLICA STATUS\G;
*************************** 1. row ***************************
             Replica_IO_State: Connecting to source
                  Source_Host: 192.168.100.101
                  Source_User: wordpress
                  Source_Port: 3306
                Connect_Retry: 60
              Source_Log_File:
          Read_Source_Log_Pos: 4
               Relay_Log_File: mysql-relay-bin.000001
                Relay_Log_Pos: 4
        Relay_Source_Log_File:
           Replica_IO_Running: Connecting
          Replica_SQL_Running: Yes
              Replicate_Do_DB:
          Replicate_Ignore_DB:
           Replicate_Do_Table:
       Replicate_Ignore_Table:
      Replicate_Wild_Do_Table:
  Replicate_Wild_Ignore_Table:
                   Last_Errno: 0
                   Last_Error:
.................................
```

5. Установка WordPress

```
[sovar@fedora wordpress]$ tree
.
├── roles
│   └── wordpress
│       ├── tasks
│       │   └── main.yml
│       └── templates
│           ├── wordpress.conf
│           └── wp-config.php
└── wordpress.yml

4 directories, 4 files
```

6. Установка Gitlab CE и Gitlab Runner

Для установки данных сервисов, были использованы готовые роли, разработанные geerlingguy, riemers. Опасность использования готовых ролей понятна, однако во первых использовал для того, чтобы показать и другой способ получения результата, во вторых получен опыт чтения ролей других разработчиков.

```
[sovar@fedora gitlab]$ tree
.
├── ansible-role-gitlab
│   ├── defaults
│   │   └── main.yml
│   ├── handlers
│   │   └── main.yml
│   ├── LICENSE
│   ├── meta
│   │   └── main.yml
│   ├── molecule
│   │   └── default
│   │       ├── converge.yml
│   │       ├── molecule.yml
│   │       └── version.yml
│   ├── README.md
│   ├── tasks
│   │   └── main.yml
│   ├── templates
│   │   └── gitlab.rb.j2
│   └── vars
│       ├── Debian.yml
│       └── RedHat.yml
└── gitlab.yml

9 directories, 13 files
```
```
[sovar@fedora runner]$ tree
.
├── ansible-gitlab-runner
│   ├── defaults
│   │   ├── main.yml
│   │   └── main.yml123
│   ├── handlers
│   │   └── main.yml
│   ├── LICENSE
│   ├── meta
│   │   └── main.yml
│   ├── README.md
│   ├── tasks
│   │   ├── config-runner-container.yml
│   │   ├── config-runners-container.yml
│   │   ├── config-runners-windows.yml
│   │   ├── config-runners.yml
│   │   ├── config-runner-windows.yml
│   │   ├── config-runner.yml
│   │   ├── Container.yml
│   │   ├── global-setup-windows.yml
│   │   ├── global-setup.yml
│   │   ├── install-arch.yml
│   │   ├── install-container.yml
│   │   ├── install-debian.yml
│   │   ├── install-macos.yml
│   │   ├── install-redhat.yml
│   │   ├── install-windows.yml
│   │   ├── line-config-runner-windows.yml
│   │   ├── line-config-runner.yml
│   │   ├── main.yml
│   │   ├── register-runner-container.yml
│   │   ├── register-runner-windows.yml
│   │   ├── register-runner.yml
│   │   ├── section-config-runner-windows.yml
│   │   ├── section-config-runner.yml
│   │   ├── systemd-reload.yml
│   │   ├── Unix.yml
│   │   ├── update-config-runner-windows.yml
│   │   ├── update-config-runner.yml
│   │   └── Windows.yml
│   ├── tests
│   │   ├── files
│   │   │   └── mock_gitlab_runner_ci.py
│   │   ├── inventory
│   │   ├── test.yml
│   │   ├── travis-bootstrap-ansible.ps1
│   │   └── vars
│   │       ├── default.yml
│   │       └── Windows.yml
│   └── vars
│       ├── Archlinux.yml
│       ├── Darwin.yml
│       ├── Debian.yml
│       ├── default.yml
│       ├── main.yml
│       ├── RedHat.yml
│       └── Windows.yml
└── runner.yml

9 directories, 48 files
```
Для поднятия runner нужен ключ, который можно взять из консоли gitlab, далее добавить default значения для корректной отработки роли.

![img.png](png/8.png)

Для настройки пайпа необходимо прописать ssh ключ в переменные, настроить job

![img.png](png/9.png)

Работа пайпа по коммиту

![img.png](png/10.png)
![img.png](png/11.png)

7. Установка Prometheus, Alert Manager, Node Exporter и Grafana

Для grafana был использован дашборд 1860, добавлен через импорт, источник определен prometheus

![img.png](png/12.png)

П.С. задание для меня было интересным, парой сложным, но мне понравилось. Спасибо всем.
