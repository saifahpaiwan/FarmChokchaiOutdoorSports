<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB; 
use Illuminate\Support\Facades\Auth;
use App\Http\Controllers\ManageController;

class PromotioncodeController extends Controller
{
    public function promotionlist()
    {    
        $Query = new ManageController; 
        $data=array(
            "Querytournaments" => $Query->Query_event(null),
        ); 
        return view('admin.promotionlist', compact('data'));
    }    
}
