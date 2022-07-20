
---

Автор:<br>Быстровский Артём<br>
Преподаватель:<br> Булат Замилов, Олег Букатчук, Руслан Жданов

<h2>Дипломный практикум в YandexCloud</h2><br>

Старт работы:<br>15/06/2022<br>
Завершение работы:<br>ХХ/ХХ/2022
    
---

<br><h3>I. Задание по дипломной работе</h3><br>

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

<br><h3>II. Требования для сдачи задания</h3><br>

1. Репозиторий со всеми Terraform манифестами и готовность продемонстрировать создание всех ресурсов с нуля.
2. Репозиторий со всеми Ansible ролями и готовность продемонстрировать установку всех сервисов с нуля.
3. Скриншоты веб-интерфейсов всех сервисов работающих по HTTPS на вашем доменном имени.
    - https://www.you.domain (WordPress)
    - https://gitlab.you.domain (Gitlab)
    - https://grafana.you.domain (Grafana)
    - https://prometheus.you.domain (Prometheus)
    - https://alertmanager.you.domain (Alert Manager)
4. Все репозитории рекомендуется хранить на одном из ресурсов (github.com или gitlab.com).

<br><h3>III. Выполение задания</h3><br>

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

