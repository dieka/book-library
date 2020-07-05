<?php

/** @var \Laravel\Lumen\Routing\Router $router */

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It is a breeze. Simply tell Lumen the URIs it should respond to
| and give it the Closure to call when that URI is requested.
|
*/

\Dusterio\LumenPassport\LumenPassport::routes($router->app);
$router->get('/', function () use ($router) {
    return $router->app->version();
});
$router->get('/key', function() {
    return \Illuminate\Support\Str::random(32);
});
$router->get('/book/latest', 'BookController@getLatest');
$router->group(['middleware' => 'auth'], function () use ($router) {
    $router->get('/book', 'BookController@getAll');
    $router->get('/book/{id}', 'BookController@get');
    $router->post('/book', 'BookController@create');
    $router->post('/book/{id}', 'BookController@update');
    $router->delete('/book/{id}', 'BookController@delete');
});
