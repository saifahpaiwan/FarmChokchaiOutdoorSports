<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class promotion_code extends Model
{
    use HasFactory;
    protected $fillable = [
        'sport_id',
        'name',
        'code',
        'status',
        'verify',
        'promotion_type',
        'price_discount',
        'sponsor_id',
        'user_id',
        'date_code', 
    ];
}
