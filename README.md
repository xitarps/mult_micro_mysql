# Organizational Chart
This project aims on help managment of orgazational chart
<br>We can manage companies, users and leadership relations


<center><img src="doc/images/organizational_chart.jpg"></center>

## Project(board with cards)
[board from github's project](https://github.com/users/xitarps/projects/7/views/1)

## ENVs
Please before start, pay attention to <b>'env.example'</b> , adjust as your needs
and rename it to: <b>'.env.development'</b>
<br>Then you will be are ready to work on it

## Api endpoints
In case of manual testing on insomnia, here a json with data all set:
 - Insomina file(json):
   - [Api Json file](./doc/insomnia/endpoints.json)

## Prerequisites
  - Docker
  - Docker compose

<br>for more details on how to install these tools:
[xita rps's gist](https://gist.github.com/xitarps/f20989a9976aab14517159fdc85a3223)

## Install/Configure

Clone the project:
```
git clone https://github.com/xitarps/organizational_chart
```
Enter the folder:
```
cd organizational_chart
```
Copy .env:
```
cp env.example .env.development
```
*obs: change it to meet your needs
Run container build:
```
docker-compose build
```
Start conainers:
```
docker-compse up
```
Prepare development enviroment(such as database migrations etc):
```
docker-compose exec web bash -c "bin/setup"
```
Optional - Run seeds to have data already set when starting the app
```
docker-compose exec web bash -c "rails db:seed"
```

## Run App
Start application:
```
docker-compose up
```
Then you can interact wit it with curl, insominia, postman etc

## Running tests
Run rspec:
```
docker-compose exec web bash -c "rspec"
```
*obs: test coverage can be found after running rspec on your browser on ./coverage/index.html

## Linter(rubocop)
Run rubcop:
```
docker-compose exec web bash -c "rubocop"
```

## Organizational chart's seeds visual abstraction
After running seeds, the organizational chart structure will be:
![Seeds](./doc/images/seeds_user_names.jpg)