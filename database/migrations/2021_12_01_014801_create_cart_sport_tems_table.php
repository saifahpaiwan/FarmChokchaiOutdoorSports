<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCartSportTemsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('cart_sport_tems', function (Blueprint $table) {
            $table->id();  
            $table->integer('user_id');
            $table->integer('sport_id');
            $table->integer('sporttype_id');
            $table->integer('generation_id');
            // $table->integer('shirt_id');
            $table->integer('option_id');

            // $table->integer('payment_status');
            // $table->char('payment_type'); 
            // $table->date('date_transfered');
            // $table->string('file_transfered');
            // $table->integer('bank_id');
            $table->float('price_total');
            $table->float('price_discount');
            $table->float('net_total');

            $table->integer('promotioncode_id');
            $table->string('code'); 

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
        Schema::dropIfExists('cart_sport_tems');
    }
}
