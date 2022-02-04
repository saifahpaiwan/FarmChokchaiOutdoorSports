<?php

namespace App\Models;

use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;

    /**
     * The attributes that are mass assignable.
     *
     * @var string[]
     */
    protected $fillable = [
        'name',
        'email',
        'password',
        'sex',
        'age',
        'line_id',
        'telphone',
        'day',
        'months',
        'years',
        'citizen_type',
        'citizen',
        'nationality',
        'blood',
        'disease',
        'address',
        'district',
        'amphoe',
        'province',
        'country',
        'zipCode',
        'fEmergencyContact',
        'lEmergencyContact',
        'telEmergencyContact', 
        'owner',
        'club',
        'verify', 
        'deleted_at', 
        'provider_id',
        'avatar',
        'verify_information',
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
    ];
}
