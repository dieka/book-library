<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateBooksTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('books', function (Blueprint $table) {
            $table->id();
            $table->string('isbn', 50);
            $table->string('title', 100);
            $table->string('author', 50);
            $table->string('publisher_name', 50)->nullable();
            $table->integer('publisher_year')->nullable();
            $table->string('genre', 50)->nullable();
            $table->string('synopsis', 200)->nullable();
            $table->boolean('status');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('books');
    }
}
