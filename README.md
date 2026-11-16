# News Shower

Приложение для просмотра новостей

## Билд приложения

1. Нужно добавить API_KEY
   ### Способ 1:
   1. В корне проекта создать файл `secrets.json`
   2. Добавить в него следующее:
      ```json
      {
        "API_KEY": "<ApiKey от https://newsapi.org>"
      }
      ```
   3. Запускать приложение через `F5`
   ### Способ 2
   Запускать приложение через `flutter run --dart-define API_KEY=<ApiKey от https://newsapi.org>`
