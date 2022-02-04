<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

class isverify_information
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle(Request $request, Closure $next)
    {
        if(auth()->user()){
            if(auth()->user()->verify_information == 0){
                return redirect()->route('member')->with("info", "Please provide information."); 
            } 
        }
        return $next($request); 
    }
}
