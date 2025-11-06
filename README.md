1. Создать бакет Object Storage и разместить в нём файл с картинкой:
 - Создать бакет в Object Storage с произвольным именем (например, _имя_студента_дата_).
   <img width="1015" height="296" alt="image" src="https://github.com/user-attachments/assets/eaa729a6-d526-4f3b-a623-350c1535d4b8" />
 - Положить в бакет файл с картинкой.
<img width="1358" height="661" alt="image" src="https://github.com/user-attachments/assets/e7018dd3-4231-4bf5-bb7f-50cdad9d129e" />
 - Сделать файл доступным из интернета.
 [Ссылка на файл](https://storage.yandexcloud.net/ranel-06.11/skrinshot-15-10-2023-202941.jpg)
2. Создать группу ВМ в public подсети фиксированного размера с шаблоном LAMP и веб-страницей, содержащей ссылку на картинку из бакета:

 - Создать Instance Group с тремя ВМ и шаблоном LAMP. Для LAMP рекомендуется использовать `image_id = fd827b91d99psvq5fjit`.
    <img width="1827" height="938" alt="image" src="https://github.com/user-attachments/assets/4420db43-70c7-41a3-bb04-10cd6e358cdf" />
    <img width="1600" height="882" alt="image" src="https://github.com/user-attachments/assets/f71e7c25-17da-4345-9457-a1ee45bbe4c4" />
    <img width="1453" height="978" alt="image" src="https://github.com/user-attachments/assets/023afcf7-0728-4153-b92a-f14aa7bbc687" />

 - Для создания стартовой веб-страницы рекомендуется использовать раздел `user_data` в [meta_data](https://cloud.yandex.ru/docs/compute/concepts/vm-metadata).
 - Разместить в стартовой веб-странице шаблонной ВМ ссылку на картинку из бакета.
  <img width="1916" height="945" alt="image" src="https://github.com/user-attachments/assets/256dd221-fd81-4855-9805-aad2c2fc7d3d" />
 - Настроить проверку состояния ВМ.

3. Подключить группу к сетевому балансировщику:

 - Создать сетевой балансировщик.
   <img width="1897" height="956" alt="image" src="https://github.com/user-attachments/assets/0606fff2-93f1-4912-96ff-5b054d979f17" />

 - Проверить работоспособность, удалив одну или несколько ВМ.
<img width="1911" height="935" alt="image" src="https://github.com/user-attachments/assets/19e383ab-c401-4ae9-b139-b276ee03d2c5" />

4. (дополнительно)* Создать Application Load Balancer с использованием Instance group и проверкой состояния.
