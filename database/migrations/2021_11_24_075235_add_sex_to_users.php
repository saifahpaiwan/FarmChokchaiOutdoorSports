<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddSexToUsers extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('users', function (Blueprint $table) {
            $table->char('sex');
            $table->integer('age');
            $table->string('line_id');
            $table->string('telphone');
            $table->integer('day');
            $table->integer('months');
            $table->year('years');
            $table->char('citizen_type');
            $table->string('citizen');
            $table->string('nationality');
            $table->string('blood');
            $table->string('disease');
            $table->text('address');
            $table->string('district');
            $table->string('amphoe');
            $table->string('province');
            $table->string('country');
            $table->string('zipCode');
            $table->string('fEmergencyContact');
            $table->string('lEmergencyContact');
            $table->string('telEmergencyContact'); 
            $table->string('owner');
            $table->string('club');
            $table->string('verify'); 
            $table->char('deleted_at');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('users', function (Blueprint $table) {
            //
        });
    }
}
