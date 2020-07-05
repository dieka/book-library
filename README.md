# Book Library
Simple CRUD web application made with Vue.JS and Lumen framework.

## Installation (Development Mode)

### 1. Database Restore (PostgreSQL)
Restore /databases/blib_db.sql to your empty PostgreSQL database.

### 2. Backend API (library-api)

In terminal, install project composer dependency packages.
```bash
composer install
```
Configure your db connection in .env configuration .

```dosini
DB_CONNECTION=pgsql
DB_HOST=127.0.0.1
DB_PORT=5432
DB_DATABASE=blib_db
DB_USERNAME=postgres
DB_PASSWORD=123456
```

Start lumen web api (example: port 8000).
```bash
php artisan serve
```

### 3. Frontend App (library-app)
In terminal, install project npm dependency packages.
```bash
npm install
# or
yarn install
```
Configure your Vue.JS environment variables (.env), and set web api url (example: port 8000).
```dosini
VUE_APP_API_URL=http://localhost:8000/
```
Start vue js web app.
```bash
npm run serve
# or 
yarn serve
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.
