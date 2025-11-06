terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  token     = var.yc_token
  cloud_id  = var.yc_cloud_id
  folder_id = var.yc_folder_id
  zone      = "ru-central1-d"
}

variable "yc_cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
  default     = null
}

variable "yc_folder_id" {
  description = "Yandex Folder ID"
  type        = string
  default     = null
}

variable "yc_network_id" {
  description = "Yandex Network ID"
  type        = string
}

variable "yc_subnet_id" {
  description = "Yandex Subnet ID"
  type        = string
}

variable "yc_token" {
  description = "Yandex Cloud OAuth token"
  type        = string
  default     = null
}

variable "yc_service_account" {
  description = "Yandex Service Account"
  type        = string
  default     = null
}

resource "yandex_resourcemanager_folder_iam_member" "editor" {
  folder_id = var.yc_folder_id
  role      = "editor"
  member    = "serviceAccount:${var.yc_service_account}"
}

resource "yandex_resourcemanager_folder_iam_member" "vpc_user" {
  folder_id = var.yc_folder_id
  role      = "vpc.user"
  member    = "serviceAccount:${var.yc_service_account}"
}

resource "yandex_resourcemanager_folder_iam_member" "compute_user" {
  folder_id = var.yc_folder_id
  role      = "compute.admin"
  member    = "serviceAccount:${var.yc_service_account}"
}

resource "yandex_compute_instance_group" "lamp-group" {
  name               = "lamp-instance-group"
  folder_id          = var.yc_folder_id
  service_account_id = var.yc_service_account

  instance_template {
    platform_id = "standard-v3"
    
    resources {
      memory = 2
      cores  = 2
    }

    boot_disk {
      initialize_params {
        image_id = "fd827b91d99psvq5fjit"
        size     = 20
      }
    }

    network_interface {
      network_id = var.yc_network_id
      subnet_ids = [var.yc_subnet_id]
      nat = true
    }

    metadata = {
      user-data = <<-EOF
        #cloud-config
        packages:
          - apache2
          - mysql-server
          - php
          - php-mysql
          - libapache2-mod-php
        runcmd:
          - systemctl enable apache2
          - systemctl start apache2
          - echo "<?php phpinfo(); ?>" > /var/www/html/phpinfo.php
          - |
            cat > /var/www/html/index.html << EOL
            <!DOCTYPE html>
            <html>
            <head>
                <title>Test LAMP</title>
            </head>
            <body>
                <h1>LAMP</h1>
                <p></p>
                <h2>My image:</h2>
                <img src="https://storage.yandexcloud.net/ranel-06.11/skrinshot-15-10-2023-202941.jpg" alt="Image" style="max-width: 600px;">
                <br>
            </body>
            </html>
            EOL
          - chown -R www-data:www-data /var/www/html
          - systemctl restart apache2
      EOF
    }
  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  allocation_policy {
    zones = ["ru-central1-d"]
  }

  deploy_policy {
    max_unavailable = 1
    max_expansion   = 0
  }

  health_check {
    interval = 2
    timeout  = 1
    unhealthy_threshold = 5
    healthy_threshold = 2
    http_options {
      port = 80
      path = "/index.html"
    }
  }

}

output "instance_external_ips" {
  value = [
    for instance in yandex_compute_instance_group.lamp-group.instances : 
    instance.network_interface[0].nat_ip_address
  ]
  description = "Внешние IP-адреса всех инстансов в группе"
}

output "instance_group_id" {
  value = yandex_compute_instance_group.lamp-group.id
}

output "service_account_id" {
  value = var.yc_service_account
}

output "instance_group_status" {
  value = yandex_compute_instance_group.lamp-group.status
}

output "website_urls" {
  value = [
    for instance in yandex_compute_instance_group.lamp-group.instances : 
    "http://${instance.network_interface[0].nat_ip_address}"
  ]
  description = "URL для проверки веб-страниц в браузере"
}