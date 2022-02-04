<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class bill_tem extends Model
{
    use HasFactory;
    protected $fillable = [
        'order_number',
        'team',  
        'sport_id',
        'sporttype_id',

        'payment_status',  
        'payment_type',     
        'date_transfered',   
        'file_transfered',  
        'bank_id',  

        'price_total',
        'price_discount',
        'net_total',
            
        'deleted_at',  
    ];
}
