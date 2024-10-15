# Organizational Chart
README WIP

envs:
 - SECRET_KEY_BASE
 - TEST_DATABASE_URL
 - TEST_DATABASE_NAME
 - DEV_DATABASE_URL
 - DEV_DATABASE_NAME
 - PROD_DATABASE_URL
 - PROD_DATABASE_NAME
 - SIDEKIQ_WORKERS
 - SIDEKIQ_USER
 - SIDEKIQ_PASSWORD=
 - REDIS_URL
 - RAILS_ENV

## Api endpoints
http://localhost:3000/api/v1/users.json
```json
{
	"per_page": 3,
	"page": 0,
	"company_id": 1
}
```


http://localhost:3000/api/v1/users/managed_users.json
```json
{
	"leader_id": 11
}
```

http://localhost:3000/api/v1/users/sub_managed_users.json
```json
{
	"leader_id": 11
}
```


## Organograma das seeds
Ao Rodar as seeds, será gerada uma estrutura de lideres com os usuários na seguinte disposição:
![Seeds](./doc/images/seeds_user_names.jpg)