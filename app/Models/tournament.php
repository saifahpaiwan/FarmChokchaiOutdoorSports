<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class tournament extends Model
{
    use HasFactory;
    protected $fillable = [
        'name_th',
        'name_en',
        'title_th',
        'title_en',
        'detail_th',
        'detail_en',
        
        'address_th', 
        'address_en', 

        'race_type',
        'location',  
        'icon', 

        'status_event',
        'status_register',
        'status_pomotion', 

        'register_start',
        'register_end',
        'event_start',
        'event_end',
        'remark', 
    ];
}
