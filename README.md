# DictionaryApp
## Архитектура
Реализована архитектура MVVM-C 
## API
Для запросов с сервера используется библиотека Alamofire
## CoreData
Для сохранения данных используется CoreData
## Repository
Реализован паттерн репозиторий, отвечают за менеджмент данных между пользователем, ApiService и CoreDataService
## AudioService
Для воспроизведения звука используется AVPlayer
## DependencyInjection
Все зависимости инициализируются один раз в AppCoordinator и далее передаются от одного координатора к другому
