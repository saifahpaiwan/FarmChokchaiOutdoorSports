<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class generation extends Model
{
    use HasFactory;
    protected $fillable = [
        'tournament_id',
        'tournament_type_id',

        'name_th',
        'name_en',
        'detail_th',
        'detail_en',

        'age_min',
        'age_max',
        'sex',  
        'release_start', 
    ];
}
