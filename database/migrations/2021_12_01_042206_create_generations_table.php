<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateGenerationsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('generations', function (Blueprint $table) {
            $table->id();
            $table->integer('tournament_id');
            $table->integer('tournament_type_id');

            $table->string('name_th');
            $table->string('name_en');
            $table->string('detail_th');
            $table->string('detail_en');

            $table->integer('age_min');
            $table->integer('age_max');
            // $table->char('sex');  
            $table->date('release_start'); 

            $table->char('deleted_at');  
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
        Schema::dropIfExists('generations');
    }
}
