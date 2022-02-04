<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTournamentTypesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('tournament_types', function (Blueprint $table) {
            $table->id();
            $table->integer('tournament_id');
            $table->string('name_th');
            $table->string('name_en');
            $table->text('detail_th');
            $table->text('detail_en');

            $table->float('price');
            $table->integer('distance');
            $table->string('unit'); 
            $table->date('release_start'); 
            $table->char('type');  
            
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
        Schema::dropIfExists('tournament_types');
    }
}
