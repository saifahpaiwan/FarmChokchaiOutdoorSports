<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class cart_sport_tem extends Model
{
    use HasFactory;
    protected $fillable = [
        'user_id',
        'sport_id',
        'sporttype_id',
        'generation_id',
        'shirt_id',
        'option_id',
    
        'payment_status',
        'payment_type', 
        'date_transfered',
        'file_transfered',
        'bank_id',
        'price_total',
        'price_discount',
        'net_total',
    
        'promotioncode_id',
        'code', 
    
        'deleted_at',  
    ]; 
}
