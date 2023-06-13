Система Заказ гостиницы. Клиент заполняет Заявку, указывая количество мест в
номере, класс апартаментов и время пребывания. Администратор просматривает
поступившую Заявку, выделяет наиболее подходящий из доступных Номеров, после чего
система выставляет Счет Клиенту.

Нужно:
1) Сделать модели с миграциями для базы данных (поля по своему вкусу, но перечисленные в задаче точно должны быть)
2) Сделать запросы GraphQL для
    - получение списка заявок с фильтрацией и сортировкой (доступно только администратору)
    - получение списка счетов с фильтрацией как минимум по клиенту и сортировкой по дате создания (клиент должен видеть только свои счета, администратор -- все)
    - мутация для создания заявки (авторизованный пользователь имеет доступ)
    - мутация для создания счета (может только администратор вызвать)
3) Авторизация на каком либо уровне, связанная с graphql (в скобках указан уровень доступа)
4) Тестовое покрытие

По своему желанию добавил github actions
