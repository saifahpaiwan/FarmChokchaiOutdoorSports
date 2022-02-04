<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateRaceProgramsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('race_programs', function (Blueprint $table) {
            $table->id();
            $table->integer('bill_id'); 
            $table->integer('tems_id'); 
            $table->integer('tournaments_id'); 
            $table->integer('tournamentTypes_id'); 
            $table->string('BIB'); 
            $table->string('EPC'); 
            $table->integer('users_id'); 
            $table->date('start_time');
            $table->date('end_time');

            $table->char('DNF');  
            $table->char('NRF');  
            $table->char('finish');  
            $table->char('status'); //สถานะการลงทะเบียนหน้างาน//

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
        Schema::dropIfExists('race_programs');
    }
}
