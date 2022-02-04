<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTournamentsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('tournaments', function (Blueprint $table) {
            $table->id();
            $table->string('name_th');
            $table->string('name_en');
            $table->string('title_th');
            $table->string('title_en');
            $table->text('detail_th');
            $table->text('detail_en');
            
            $table->text('address_th'); 
            $table->text('address_en'); 

            $table->integer('race_type');
            $table->text('location');  
            $table->string('icon'); 

            $table->char('status_event');
            $table->char('status_register');
            $table->char('status_pomotion'); 

            $table->date('register_start');
            $table->date('register_end');
            $table->date('event_start');
            $table->date('event_end');
            $table->text('remark');
 
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
        Schema::dropIfExists('tournaments');
    }
}
