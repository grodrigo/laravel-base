# laravel-base
create .env or copy it from .env.example
cp .env.example .env

mkdir www  
put your content there and run composer and npm install  
docker-compose up -d  
check localhost:8080 in your browser  

## Example with a running basic project
Here there is an example with a basic laravel api with passport authentication with a vue front:
```
git clone https://github.com/grodrigo/laravel-base.git
cd laravel-base
cp .env.example .env
git clone https://github.com/grodrigo/laravel-app.git www
git clone https://github.com/grodrigo/vue-app.git front

follow this steps to configure gmail with laravel
https://programacionymas.com/blog/como-enviar-mails-correos-desde-laravel

cp www/.env.example www/.env
```

```
change www/.env file with:
DB_CONNECTION=mysql
DB_HOST=
DB_PORT=3306
DB_DATABASE=dblaravel
DB_USERNAME=uuser
DB_PASSWORD=upassword

MAIL_DRIVER=smtp
MAIL_HOST=smtp.gmail.com
MAIL_PORT=587
MAIL_USERNAME=mimail@gmail.com
MAIL_PASSWORD=mipasswordultraloco
MAIL_ENCRYPTION=tls
MAIL_FROM_ADDRESS=laravelapp_test@gmail.com
MAIL_FROM_NAME="I'm a test!"
```

```
finish the setup
docker-compose run --rm composer install
docker-compose run --rm nodejs npm install
docker-compose up -d mysql
docker-compose run --rm artisan migrate
sudo chmod 777 -R www/storage
docker-compose run --rm artisan key:generate
```

laravel will be running on localhost:8080  
vue will be running on localhost:8081

Import in Postman the collection in www/laravel.postman_collection.json
do a signup, check your email, etc.


---------------
if you want to restore db from a file
cp www/your_db_file.sql.gz ./backups
docker-compose run --rm mysql zcat /backups/your_db_file.sql.gz | mysql -u root -p
```

## Start a new project:
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
when you do  
docker-compose run --rm artisan make:auth  
you probably get 
 Symfony\Component\Debug\Exception\FatalErrorException  : Declaration of Symfony\Component\Translation\TranslatorInterface::setLocale($locale) must be compatible with Symfony\Contracts\Translation\LocaleAwareInterface::setLocale(string $locale)

In order to avoid it, add this line to your www/composer.json in the requirements section or probably better in the vendor symfony/trasnlation-contracts composer requirements  
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
