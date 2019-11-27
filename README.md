# laravel-base
create .env or copy it from .env.example
cp .env.example .env

mkdir www
put your content there.

## You can use this laravel base app project:
clone https://github.com/grodrigo/laravel-app.git www
cp www/.env.example www/.env
docker-compose run --rm composer install
docker-compose run --rm nodejs npm install
docker-compose run --rm artisan migrate
docker-compose up -d
sudo chmod 777 -R www/storage

check that you can register/login a user
------------------------------
------------------------------
## Start a new project:
what I did in the laravel-app was to create a simple project with these steps:

To start a new project you can do:
docker-compose run --rm composer create-project --prefer-dist laravel/laravel .

Your files will be owned by root, change it, edit with sudo, or choice your approach, i.e
sudo chown -R $USER:$USER .
change database settings in www/.env, make sure to set DB_HOST=mysql and your database name, user and password

docker-compose up -d

and that's all

### Usage of the this repo
Running Artisan commands
Example:
$ docker-compose run --rm artisan make:auth

Running composer commands
Example:
$ docker-compose run --rm composer update

Running with Node.js
$ docker-compose run --rm nodejs npm install

## SPECIAL NOTES:
when you do
docker-compose run --rm artisan make:auth
you probably get 
 Symfony\Component\Debug\Exception\FatalErrorException  : Declaration of Symfony\Component\Translation\TranslatorInterface::setLocale($locale) must be compatible with Symfony\Contracts\Translation\LocaleAwareInterface::setLocale(string $locale)

In order to avoid it, add this line to your www/composer.json in the requirements section
"symfony/translation-contracts": "^1.1.6"

and then update the composer by
docker-compose run --rm composer update

artisan make:auth won't work on laravel 6, to get authentication do:
docker-compose run --rm composer require laravel/ui
docker-compose run --rm artisan ui bootstrap --auth

Please run "npm install && npm run dev" to compile your fresh scaffolding:
docker-compose run --rm nodejs npm install && npm run dev

docker-compose run --rm artisan migrate

Try to register a user in localhost:8080
your storage logs will probably get permission issues:
sudo chown 33:33 -R www/storage/logs/

if this doesn't work do:
sudo chmod 777 -R www/storage/logs/
or directly to all www/storage due to storage/session permissions problem
