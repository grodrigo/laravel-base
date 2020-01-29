Pre-requisites: docker and docker-compose, follow the oficial instructions to install them and to run docker with sudo to get an easily setup

# laravel-base
create .env or copy it from .env.example (docker environment)
cp .env.example .env

mkdir www  
put your laravel content there and run composer and npm install  
docker-compose up -d  
check localhost:8080 in your browser  

## Example with a running basic project
Here there is an example with a basic laravel api:  
In laravel-base folder you'll have docker files and other stuff.  
Inside it you'll need a www folder with your laravel app.
```
git clone https://github.com/grodrigo/laravel-base.git
cd laravel-base
cp .env.example .env
git clone https://github.com/grodrigo/laravel-app.git www
cp www/.env.example www/.env
```

```
change your laravel www/.env file with (put the same of your docker .env file and take note of the DB_HOST=mysql parameter)
DB_CONNECTION=mysql
DB_HOST=mysql
DB_PORT=3306
DB_DATABASE=dblaravel
DB_USERNAME=uuser
DB_PASSWORD=upassword
```

```
finish the setup
docker-compose run --rm composer install
docker-compose run --rm nodejs npm install
docker-compose up -d mysql
docker-compose run --rm artisan migrate:refresh --seed
docker-compose run --rm artisan key:generate
sudo chown 82:82 -R www/storage/logs
sudo chown 82:82 -R www/storage/framework/views/
sudo chown 82:82 -R www/storage/framework/cache
sudo chown 82:82 -R www/storage/bootstrap/cache
docker-compose up -d mysql nginx php7fpm
```

laravel will be running on localhost:8080  

On pc restart the project will be up due to the policy restart in the docker-compose.yml file. If you change that or you stop the services you can start again the project with:  
docker-compose up -d mysql nginx php7fpm  

another option for migrate and seed could be:  
docker-compose run --rm artisan migrate  
docker-compose run --rm artisan db:seed  

---------------
---------------
if you want to restore db from a file
cp www/your_db_file.sql.gz ./backups
docker-compose run --rm mysql zcat /backups/your_db_file.sql.gz | mysql -u root -p


## How to start a new project:
To start a new project you can do:  
docker-compose run --rm composer create-project --prefer-dist laravel/laravel .

Your files will be owned by root, change it, edit with sudo, or choice your approach, i.e  
sudo chown -R $USER:$USER .  
change database settings in www/.env, make sure to set DB_HOST=mysql and your database name, user and password  

docker-compose up -d

## Usage of the this repo
```
Running Artisan commands  
Example:
$ docker-compose run --rm artisan make:auth

Running composer commands
Example:
$ docker-compose run --rm composer update

Running with Node.js
$ docker-compose run --rm nodejs npm install
```

## SPECIAL NOTES:
artisan make:auth won't work on laravel 6, to get authentication do:  
docker-compose run --rm composer require laravel/ui  
docker-compose run --rm artisan ui bootstrap --auth  

Please run "npm install && npm run dev" to compile your fresh scaffolding:  
docker-compose run --rm nodejs npm install && npm run dev

docker-compose run --rm artisan migrate  

Try to register a user in localhost:8080  
your storage logs will probably get permission issues:  
sudo chown 82:82 -R www/storage/logs/  
sudo chown 82:82 -R www/storage/session/  

(alpine www-data is 82, instead of 33 like in debian)

if this doesn't work do:  
sudo chmod 777 -R www/storage/logs/  
or directly to all www/storage due to storage/session permissions problem

Mysql error:
Illuminate\Database\QueryException  : SQLSTATE[HY000]: General error: 1005 Can't create table `dblaravel`.`password_resets` (errno: 13 "Permission denied")  
do  
sudo chown -R 999:999 db_data/


