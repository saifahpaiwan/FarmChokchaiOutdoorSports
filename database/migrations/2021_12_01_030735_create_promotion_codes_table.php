<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePromotionCodesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('promotion_codes', function (Blueprint $table) {
            $table->id();
            $table->integer('sport_id');
            $table->string('name');
            $table->string('code');
            $table->integer('status');
            $table->integer('verify');
            $table->integer('promotion_type');
            $table->float('price_discount');
            $table->integer('sponsor_id');
            $table->integer('user_id');
            $table->date('date_code');
 
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
        Schema::dropIfExists('promotion_codes');
    }
}
