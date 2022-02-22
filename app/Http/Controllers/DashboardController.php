<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request; 
use Illuminate\Support\Facades\DB; 
use Illuminate\Support\Facades\Auth;
use DataTables;  

class DashboardController extends Controller
{
    
    public function dashboard()
    {     
        $data=array(); 
        return view('admin.dashboard', compact('data'));
    }  
}
