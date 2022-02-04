<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateBillTemsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('bill_tems', function (Blueprint $table) {
            $table->id();
            $table->integer('order_number'); 
            $table->string('team');  
            $table->integer('sport_id'); 

            $table->integer('payment_status');  //  null=ยังไม่ชำระ, 1=ชำระแล้ว, 2=ยกเลิกการชำระ, 3=เกินกำหนดการชำระ	
            $table->char('payment_type');       //	1=โอนเงินผ่านธนาคาร, 2=ชำระผ่านบัตรเคดิต
            $table->date('date_transfered');    //	วันที่ชำระเงิน
            $table->string('file_transfered');  //  ไฟล์หลักฐานการชำระเงิน
            $table->integer('bank_id');         //  ธนาคารที่ชำระเงิน

            $table->float('price_total');
            $table->float('price_discount');
            $table->float('net_total');
              
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
        Schema::dropIfExists('bill_tems');
    }
}
