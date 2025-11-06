<img width="1015" height="296" alt="image" src="https://github.com/user-attachments/assets/e8b280ff-87e7-4c26-9fa4-9c1ef83d5fb9" />1. Создать бакет Object Storage и разместить в нём файл с картинкой:

 - Создать бакет в Object Storage с произвольным именем (например, _имя_студента_дата_).
   <img width="1015" height="296" alt="image" src="https://github.com/user-attachments/assets/eaa729a6-d526-4f3b-a623-350c1535d4b8" />
 - Положить в бакет файл с картинкой.
<img width="1358" height="661" alt="image" src="https://github.com/user-attachments/assets/e7018dd3-4231-4bf5-bb7f-50cdad9d129e" />
 - Сделать файл доступным из интернета.
 [Ссылка на файл](https://storage.yandexcloud.net/ranel-06.11/skrinshot-15-10-2023-202941.jpg)
2. Создать группу ВМ в public подсети фиксированного размера с шаблоном LAMP и веб-страницей, содержащей ссылку на картинку из бакета:

 - Создать Instance Group с тремя ВМ и шаблоном LAMP. Для LAMP рекомендуется использовать `image_id = fd827b91d99psvq5fjit`.
 - Для создания стартовой веб-страницы рекомендуется использовать раздел `user_data` в [meta_data](https://cloud.yandex.ru/docs/compute/concepts/vm-metadata).
 - Разместить в стартовой веб-странице шаблонной ВМ ссылку на картинку из бакета.
 - Настроить проверку состояния ВМ.
 
3. Подключить группу к сетевому балансировщику:

 - Создать сетевой балансировщик.
 - Проверить работоспособность, удалив одну или несколько ВМ.
4. (дополнительно)* Создать Application Load Balancer с использованием Instance group и проверкой состояния.
