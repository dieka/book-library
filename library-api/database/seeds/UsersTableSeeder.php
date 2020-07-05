<?php

use Illuminate\Database\Seeder;
use Faker\Generator;

class UsersTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $faker = Faker\Factory::create();
        App\User::create([
            'username'  => 'admin',
            'name'      => $faker->name,
            'password'  => app('hash')->make('12345678'),
            'email'     => $faker->email
        ]);
    }
}
