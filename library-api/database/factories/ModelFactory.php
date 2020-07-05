<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\Book;
use Faker\Generator as Generator;

/*
|--------------------------------------------------------------------------
| Model Factories
|--------------------------------------------------------------------------
|
| This directory should contain each of the model factory definitions for
| your application. Factories provide a convenient way to generate new
| model instances for testing / seeding your application's database.
|
*/

$factory->define(Book::class, function (Generator $faker) {
    $faker->addProvider(new Faker\Provider\Barcode($faker));
    $faker->addProvider(new Faker\Provider\en_US\Company($faker));
    $faker->addProvider(new Faker\Provider\en_US\Text($faker));

    $dataGenre = ['Horor', 'Fantasi', 'Romance', 'Humor',
        'Misteri', 'Biografi', 'Jurnal', 'Sejarah'];
    return [
        'isbn' => $faker->isbn13,
        'title' => $faker->name,
        'author' => $faker->name,
        'publisher_name' => $faker->company,
        'publisher_year' => $faker->year,
        'genre' => $dataGenre[rand(0, 7)],
        'synopsis' => $faker->realText(rand(60,100)),
        'status' => true,
    ];
});

