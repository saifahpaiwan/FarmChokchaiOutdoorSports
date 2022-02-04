<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Providers\RouteServiceProvider;
use Illuminate\Foundation\Auth\AuthenticatesUsers; 
use App\Models\User;  
use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;
use Laravel\Socialite\Facades\Socialite;

class LoginController extends Controller
{
    /*
    |--------------------------------------------------------------------------
    | Login Controller
    |--------------------------------------------------------------------------
    |
    | This controller handles authenticating users for the application and
    | redirecting them to your home screen. The controller uses a trait
    | to conveniently provide its functionality to your applications.
    |
    */

    use AuthenticatesUsers;

    /**
     * Where to redirect users after login.
     *
     * @var string
     */
    // protected $redirectTo = RouteServiceProvider::HOME;
    protected $redirectTo = '/';

    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('guest')->except('logout');
    }

    public function login( Request $request )
    {     
        $input = $request->all();
        $this->validate($request, [
            'email' => 'required|email',
            'password' => 'required'
        ]); 
 
        if(auth()->attempt(array('email' => $input['email'], 'password' => $input['password']))){   
            if(auth()->user()->is_users == 1){
                return redirect()->route('home');
            } else if(auth()->user()->is_users == 2){
                return redirect()->route('dashboard');
            }  
        } else {
            return redirect()->route('login')->with('error', 'Email-address and password are Wrong'); 
        }
    }

    // Googlr Login //
    public function redirectToGoogle() {
        return Socialite::driver('google')->redirect(); 
    }  

    public function handleGoogleCallback(){ 
        $user = Socialite::driver('google')->user();  
        $this->_registerOrLoginUser($user);   
        return redirect()->route('home');
    }

    // Facebook Login //
    public function redirectToFacebook() {
        return Socialite::driver('facebook')->redirect();
    } 

    public function handleFacebookCallback(){ 
        $user = Socialite::driver('facebook')->user(); 
        $this->_registerOrLoginUser($user); 
        return redirect()->route('home');
    }


    protected function _registerOrLoginUser($data){
        $user = User::Where('email', '=', $data->email)->first();
        if(!$user){
            $user = new User();
            $user->name = $data->name;
            $user->email = $data->email; 
            $user->provider_id = $data->id;
            $user->avatar = $data->avatar;
            $user->save();
        } 
        Auth::login($user);
    }

    public function redirectToLine(Request $request)
    {         
        $user = User::Where('email', '=', $request->decodedIDToken)->first();
        if(!$user){
            $user = new User();
            $user->name = $request->displayName;
            $user->email = $request->decodedIDToken; 
            $user->provider_id = $request->userId;
            $user->avatar = $request->pictureUrl;
            $user->save();
        } 
        Auth::login($user); 
    } 
}
