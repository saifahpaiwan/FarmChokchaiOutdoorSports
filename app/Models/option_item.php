<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class option_item extends Model
{
    use HasFactory;
    protected $fillable = [
        'option_id',
        'topic',
        'detail',
    ]; 
}
