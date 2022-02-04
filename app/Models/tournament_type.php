<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class tournament_type extends Model
{
    use HasFactory;
    protected $fillable = [
        'tournament_id',
        'name_th',
        'name_en',
        'detail_th',
        'detail_en', 
        'price',
        'distance',
        'unit', 
        'release_start', 
        'type',  
    ];
}
