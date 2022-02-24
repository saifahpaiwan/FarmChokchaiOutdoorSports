<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB; 
use Illuminate\Support\Facades\Auth;
use App\Models\User;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Storage; 
class HomeController extends Controller
{ 
    public function index()
    {       
        $data=array(
            "Querywebsite"  => $this->Querywebsite(),
            "sponsors" => $this->Query_sponsors(null),  
        );
        return view('home', compact('data'));
    }  

    public function Querywebsite(){
        $data=DB::table('website') 
        ->select('*')   
        ->where('website.deleted_at',0) 
        ->first(); 
        return $data;
    }

    public function about()
    {  
        $data=array(
            "sponsors" => $this->Query_sponsors(null),
        );
        return view('about', compact('data'));
    }  

    public function contact()
    {  
        $data=array(
            "sponsors" => $this->Query_sponsors(null),
        );
        return view('contact', compact('data'));
    }
    
    public function checkapplication()
    {  
        $data=array(
            "sponsors" => $this->Query_sponsors(null),
        );
        return view('checkapplication', compact('data'));
    } 

    public function joinus()
    {  
        $data=array(
            "sponsors" => $this->Query_sponsors(null),
        );
        return view('joinus', compact('data'));
    }  

    public function privacpolicy()
    {  
        $data=array(
            "sponsors" => $this->Query_sponsors(null),
        );
        return view('privacpolicy', compact('data'));
    }   

    public function conditions()
    {  
        $data=array(
            "sponsors" => $this->Query_sponsors(null),
        );
        return view('conditions', compact('data'));
    }   
     
    public function orderview($get_id)
    {     
        $data = array( 
            "sponsors" => $this->Query_sponsors(null),
            'query_payment' => $this->query_payment($get_id, false, null), 
            'get_id'   => $get_id,
        ); 
        return view('orderview', compact('data'));  
    }  

    public function playerinfo($get_id)
    {    
        $data = array(   
            "sponsors" => $this->Query_sponsors(null),
            'get_id'   => $get_id,
        ); 
        return view('playerinfo', compact('data'));  
    }   

    public function member()
    { 
        $id=Auth::user()->id;  
        $data = array( 
            "sponsors" => $this->Query_sponsors(null),
            'users' => User::find($id), 
        ); 
        return view('member', compact('data'));
    }  

    public function candidacy1($get_id)
    { 
        $id=Auth::user()->id;  
        $user=User::find($id);  
        $data = array( 
            "sponsors" => $this->Query_sponsors(null),
            'users' => $user, 
            'contestant' => $this->contestant($id, $get_id),
            'QueryTournaments' => $this->Query_tournaments_type($get_id),
            'Query_option'     => $this->Query_option($get_id),  
            'first_tournaments' => $this->first_tournaments($get_id),
        );    
        return view('candidacy1', compact('data'));
    }  
 
    public function candidacy2($get_id)
    { 
        $id=Auth::user()->id;  
        $data = array( 
            "sponsors" => $this->Query_sponsors(null),
            'users' => User::find($id), 
            'contestant' => $this->contestant($id, $get_id),
            'QueryTournaments' => $this->Query_tournaments_type($get_id),
            'Query_option'     => $this->Query_option($get_id),
            'first_tournaments' => $this->first_tournaments($get_id),
        );    
        return view('candidacy2', compact('data'));
    }  

    public function Query_tournaments_type($id)
    {
        $data=DB::table('tournament_types') 
        ->select('*')   
        ->where('tournament_types.tournament_id', $id) 
        ->where('tournament_types.deleted_at', NULL) 
        ->get(); 
        return $data;
    }

    public function first_tournaments($id)
    {
        $data=DB::table('tournaments') 
        ->select('*')   
        ->where('tournaments.status_event', 1)
        ->where('tournaments.status_register', 1) 
        ->where('tournaments.id', $id) 
        ->where('tournaments.deleted_at',0) 
        ->first(); 
        return $data;
    }

    public function Query_option($id)
    {
        $data=DB::table('options') 
        ->select('options.id as optionsID', 'options.name as optionsName', 'options.detail as optionsDetail', 
        'option_items.id as opItems_id', 'options.filename as filename', 'options.status as status',
        'option_items.topic as opItems_topic', 'option_items.detail as opItems_detail')   
        ->leftJoin('option_items', 'options.id', '=', 'option_items.option_id') 
        ->where('options.sport_id', $id) 
        ->where('options.deleted_at', NULL) 
        ->get(); 
        $items=[];
        foreach($data as $key=>$row){
            $items[$row->optionsID]['optionsID'] = $row->optionsID;
            $items[$row->optionsID]['optionsName'] = $row->optionsName;
            $items[$row->optionsID]['optionsDetail'] = $row->optionsDetail;
            $items[$row->optionsID]['filename'] = $row->filename;
            $items[$row->optionsID]['status'] = $row->status;
            $items[$row->optionsID]['option_items'][$row->opItems_id]['opItems_id'] = $row->opItems_id;
            $items[$row->optionsID]['option_items'][$row->opItems_id]['opItems_topic'] = $row->opItems_topic;
            $items[$row->optionsID]['option_items'][$row->opItems_id]['opItems_detail'] = $row->opItems_detail;
        } 
        return $items;
    }
 
    public function order()
    { 
        $id=Auth::user()->id;  
        $data = array( 
            "sponsors" => $this->Query_sponsors(null),
            'users' => User::find($id), 
            'query_bill' => $this->query_bill()
        );  
        return view('order', compact('data'));
    }  

    public function payment($get_id)
    {   
        $id=Auth::user()->id;  
        $data = array( 
            "sponsors" => $this->Query_sponsors(null),
            'query_payment' => $this->query_payment($get_id, false, null),
            'users' => User::find($id), 
            'get_id'   => $get_id,
        ); 
        return view('payment', compact('data'));
    }   

    public function history()
    {   
        $id=Auth::user()->id; 
        $order_pay=DB::table('bill_tems')->select('*', 'users.name as fname', 'users.lname as lname', 'bill_tems.id as bill_id')  
        ->leftJoin('users', 'bill_tems.users_id', '=', 'users.id')  
        ->where('bill_tems.deleted_at', NULL) 
        ->where('bill_tems.users_id', $id) 
        ->get();  
        $data = array(  
            "sponsors" => $this->Query_sponsors(null),
            'users' => User::find($id),  
            "orderlist" => $order_pay,
        ); 
        return view('history', compact('data'));
    }    
    
    public function transfer($get_id)
    {   
        $id=Auth::user()->id;  
        $data = array(  
            "sponsors" => $this->Query_sponsors(null),
            'query_payment' => $this->query_payment($get_id, false, null),
            'users' => User::find($id), 
            'get_id'   => $get_id,
        ); 
        return view('transfer', compact('data'));
    }    

    public function event()
    {    
        $data = array(
            "sponsors" => $this->Query_sponsors(null),
            "event" =>  $this->Query_event(null),
        ); 
        return view('event', compact('data'));
    } 
    
    public function registerform($get_id)
    { 
        $id=Auth::user()->id;  
        $data = array( 
            "sponsors" => $this->Query_sponsors($get_id),
            "event" => $this->Query_event($get_id),
            'users' => User::find($id), 
            "get_id" => $get_id,
        );  
        return view('registerform', compact('data'));
    } 
  
    //========================================================================================================//

    public function Query_sponsors($get_id)
    {
        if(!empty($get_id)){
            $data=DB::table('tournaments_sponsors')->select('sponsors.filename as filename', 'sponsors.name as name', 'sponsors.detail as detail')    
            ->leftJoin('sponsors', 'tournaments_sponsors.sponsors_id', '=', 'sponsors.id')  
            ->where('sponsors.deleted_at', '0') 
            ->where('tournaments_sponsors.tournament_id', $get_id) 
            ->get(); 
        } else {
            $data=DB::table('sponsors')->select('*')    
            ->where('sponsors.deleted_at', '0') 
            ->orderBy('sponsors.order_number', 'asc')
            ->get(); 
        } 
        return $data;
    }
 
    public function Query_event($get_id)
    {
        if(!empty($get_id)){
            $data=DB::table('tournaments')->select('*')    
            ->where('tournaments.deleted_at', 0)
            ->where('tournaments.status_event', 1) 
            ->where('tournaments.id', $get_id) 
            ->first(); 
        } else {
            $data=DB::table('tournaments')->select('*')    
            ->where('tournaments.deleted_at', 0)
            ->where('tournaments.status_event', 1) 
            ->get(); 
        } 
        return $data;
    }

    public function query_bill()
    {
        $id=Auth::user()->id;  
        $data=DB::table('cart_sport_tems') 
        ->select('cart_sport_tems.sport_id as sport_id', 'cart_sport_tems.id as tems_id', 'tournaments.name_th as tournaments_name', 'tournaments.name_en as tournaments_name_en',
        'tournament_types.name_th as tournamentTypes_name',  'tournament_types.name_en as tournamentTypes_name_en', 'generations.name_th as generationsName', 'generations.name_en as generationsName_en', 
        'cart_sport_tems.price_total as price_total', 'cart_sport_tems.price_discount as price_discount', 'cart_sport_tems.net_total as net_total',
        'users.name as username_f', 'users.lname as username_l', 'cart_sport_tems.option_id as option_id',
        'tournaments.race_type as raceType', 'cart_sport_tems.code as code')   
        ->leftJoin('tournaments', 'cart_sport_tems.sport_id', '=', 'tournaments.id')  
        ->leftJoin('tournament_types', 'cart_sport_tems.sporttype_id', '=', 'tournament_types.id')
        ->leftJoin('generations', 'cart_sport_tems.generation_id', '=', 'generations.id')
        ->leftJoin('users', 'cart_sport_tems.user_id', '=', 'users.id')
        ->where('cart_sport_tems.deleted_at', NULL)
        ->where('cart_sport_tems.check_is', 1) 
        ->where('cart_sport_tems.candidacy', $id)
        ->get();   
        $items=[];
        if(isset($data)){
            foreach($data as $key=>$row){
                $option_arr=""; 
                $option=DB::table('option_items') 
                ->select('option_items.topic as topic', 'option_items.detail as detail') 
                ->whereRaw('option_items.id in ('.$row->option_id.')')
                ->get(); 
                foreach($option as $arr){
                    $option_arr.=$arr->topic." ".$arr->detail." ";
                } 
                if($row->raceType==1){ $raceType="race running"; } else {$raceType="bike sharing competition";}

                $items[$key]['tems_id'] = $row->tems_id;
                $items[$key]['sport_id'] = $row->sport_id;
                
                $items[$key]['tournaments_name'] = $row->tournaments_name;
                $items[$key]['tournaments_name_en'] = $row->tournaments_name_en; 
                $items[$key]['tournamentTypes_name'] = $row->tournamentTypes_name;
                $items[$key]['tournamentTypes_name_en'] = $row->tournamentTypes_name_en;
                $items[$key]['generationsName'] = $row->generationsName;
                $items[$key]['generationsName_en'] = $row->generationsName_en;
                $items[$key]['name'] = $row->username_f." ".$row->username_l;
                $items[$key]['price_total'] = $row->price_total;
                $items[$key]['price_discount'] = $row->price_discount;
                $items[$key]['net_total'] = $row->net_total;
                $items[$key]['options'] = $option_arr; 
                $items[$key]['raceType'] = $raceType;
                $items[$key]['code'] = $row->code; 
            }
        } 
        return $items; 
    }

    public function query_payment($get_id, $admin=false, $users_id)
    {  
        $id=null;
        if(isset(Auth::user()->id)){
            if($admin==true){
                $id=$users_id; 
            } else { 
                $id=Auth::user()->id;  
            } 
        } else {
            if(isset($_GET['users_id'])){
                $id=$_GET['users_id'];
            } 
        }

        $data=DB::table('bill_tems') 
        ->select('bill_tems.id as bill_id', 'bill_tems.order_number as order_number', 
        'bill_tems.price_total as price_total', 'bill_tems.price_discount as price_discount', 'bill_tems.net_total as net_total',
        'bill_tems.created_at as created_at', 'bill_tems.updated_at as updated_at', 'tournaments.name_th as tournamentName', 'tournaments.name_en as tournamentName_en',
        'tournaments.race_type as raceType',
        'users.name as users_fname',  'users.lname as users_lname', 'cart_sport_tems.id as cart_sport_id', 'promotion_codes.code as code', 'promotion_codes.detail as code_detail', 
        'users_team.name as users_team_fname',  'users_team.lname as users_team_lname', 'users_team.sex as sex', 'users_team.id as users_tems_id',
        'tournament_types.name_th as tournament_type_name', 'tournament_types.name_en as tournament_type_name_en', 'generations.name_th as generations', 'generations.name_en as generations_en', 'cart_sport_tems.option_id as option_id',
        'bill_tems.payment_status as payment_status', 'bill_tems.payment_type as payment_type', 'bill_tems.date_transfered as date_transfered',
        'bill_tems.check_payment as check_payment', 'cart_sport_tems.sport_id as sport_id', 'cart_sport_tems.sporttype_id as sporttype_id',
        'race_programs.BIB as BIB', 'race_programs.status as race_status', 'tournaments.abbreviation as abbreviation',
        'bill_tems.file_transfered as file_transfered', 
        'cart_sport_tems.price_total as temsPrice_total', 'cart_sport_tems.price_discount as temsPrice_discount', 
        'cart_sport_tems.net_total as temsNet_total', 'bill_tems.note as note', 
        )   
        ->leftJoin('users', 'bill_tems.users_id', '=', 'users.id')    
        ->leftJoin('cart_sport_tems', 'bill_tems.id', '=', 'cart_sport_tems.bill_id') 
        ->leftJoin('promotion_codes', 'cart_sport_tems.promotioncode_id', '=', 'promotion_codes.id') 
        ->leftJoin('users as users_team', 'cart_sport_tems.user_id', '=', 'users_team.id') 
        ->leftJoin('tournaments', 'cart_sport_tems.sport_id', '=', 'tournaments.id') 
        ->leftJoin('tournament_types', 'cart_sport_tems.sporttype_id', '=', 'tournament_types.id')  
        ->leftJoin('generations', 'cart_sport_tems.generation_id', '=', 'generations.id')

        ->leftJoin('race_programs', 'cart_sport_tems.id', '=', 'race_programs.tems_id') 
        
        ->where('bill_tems.deleted_at', NULL)
        ->where('bill_tems.users_id', $id)
        ->where('bill_tems.id', $get_id) 
        ->get(); 
        $items=[];
        if(isset($data)){
            foreach($data as $key=>$row){
                if($row->raceType==1){ $raceType="race running"; } else {$raceType="bike sharing competition";}
                $items[$row->bill_id]['bill_id'] = $row->bill_id;
                $items[$row->bill_id]['order_number'] = $row->order_number; 
                $items[$row->bill_id]['users_fname'] = $row->users_fname;
                $items[$row->bill_id]['users_lname'] = $row->users_lname; 

                $items[$row->bill_id]['price_total'] = $row->price_total;
                $items[$row->bill_id]['price_discount'] = $row->price_discount;
                $items[$row->bill_id]['net_total'] = $row->net_total;  

                $items[$row->bill_id]['price_total_fm'] = number_format($row->price_total, 2);
                $items[$row->bill_id]['price_discount_fm'] = number_format($row->price_discount, 2);
                $items[$row->bill_id]['net_total_fm'] = number_format($row->net_total, 2);  

                $items[$row->bill_id]['created_at'] = $row->created_at;
                $items[$row->bill_id]['created_at_strtotime'] = date("m/d/Y", strtotime($row->created_at)); 
                $items[$row->bill_id]['created_at_carbon'] = Carbon::parse($row->created_at)->diffForHumans(); 
                $items[$row->bill_id]['updated_at_carbon'] = Carbon::parse($row->updated_at)->diffForHumans(); 

                $items[$row->bill_id]['payment_status'] = $row->payment_status;
                $items[$row->bill_id]['payment_type'] = $row->payment_type;
                $items[$row->bill_id]['date_transfered'] = $row->date_transfered;
                $items[$row->bill_id]['date_transfered_strtotime'] = date("m/d/Y", strtotime($row->date_transfered)); 
                $items[$row->bill_id]['check_payment'] = $row->check_payment;
                $items[$row->bill_id]['file_transfered'] = $row->file_transfered;
                $items[$row->bill_id]['note'] = $row->note;
                
                $option_arr=""; 
                $option=DB::table('option_items') 
                ->select('option_items.topic as topic', 'option_items.detail as detail') 
                ->whereRaw('option_items.id in ('.$row->option_id.')')
                ->get(); 
                foreach($option as $arr){
                    $option_arr.=$arr->topic." ".$arr->detail." ";
                }
                $items[$row->bill_id]['datalist'][$row->cart_sport_id]['sport_id'] = $row->sport_id;
                $items[$row->bill_id]['datalist'][$row->cart_sport_id]['sporttype_id'] = $row->sporttype_id;
                $items[$row->bill_id]['datalist'][$row->cart_sport_id]['users_tems_id'] = $row->users_tems_id;
                $items[$row->bill_id]['datalist'][$row->cart_sport_id]['abbreviation'] = $row->abbreviation;
                
                $items[$row->bill_id]['datalist'][$row->cart_sport_id]['cart_sport_id'] = $row->cart_sport_id;
                $items[$row->bill_id]['datalist'][$row->cart_sport_id]['tournamentName'] = $row->tournamentName;
                $items[$row->bill_id]['datalist'][$row->cart_sport_id]['tournamentName_en'] = $row->tournamentName_en; 
                $items[$row->bill_id]['datalist'][$row->cart_sport_id]['raceType'] = $raceType;
                $items[$row->bill_id]['datalist'][$row->cart_sport_id]['code'] = $row->code;
                $items[$row->bill_id]['datalist'][$row->cart_sport_id]['code_detail'] = $row->code_detail;
                $items[$row->bill_id]['datalist'][$row->cart_sport_id]['users_team_fname'] = $row->users_team_fname;
                $items[$row->bill_id]['datalist'][$row->cart_sport_id]['users_team_lname'] = $row->users_team_lname; 
  
                $items[$row->bill_id]['datalist'][$row->cart_sport_id]['tournament_type_name'] = $row->tournament_type_name;
                $items[$row->bill_id]['datalist'][$row->cart_sport_id]['tournament_type_name_en'] = $row->tournament_type_name_en;
                $items[$row->bill_id]['datalist'][$row->cart_sport_id]['generations'] = $row->generations;
                $items[$row->bill_id]['datalist'][$row->cart_sport_id]['generations_en'] = $row->generations_en;
                
                $items[$row->bill_id]['datalist'][$row->cart_sport_id]['option'] = $option_arr;

                $items[$row->bill_id]['datalist'][$row->cart_sport_id]['temsPrice_total'] = number_format($row->temsPrice_total, 2);
                $items[$row->bill_id]['datalist'][$row->cart_sport_id]['temsPrice_discount'] = number_format($row->temsPrice_discount, 2);
                $items[$row->bill_id]['datalist'][$row->cart_sport_id]['temsNet_total'] = number_format($row->temsNet_total, 2); 

                $items[$row->bill_id]['datalist'][$row->cart_sport_id]['BIB'] = $row->BIB;
                $items[$row->bill_id]['datalist'][$row->cart_sport_id]['race_status'] = $row->race_status; 
            }
        }   
        return $items; 
    }

    public function saveuser(Request $request)
    {  
        $validatedData = $request->validate(
            [  
                'fname'    => 'required', 'string', 'max:100',   
                'lname'   => 'required', 'string', 'max:100',
                'day'   => 'required', 'string', 'max:100',
                'month'   => 'required', 'string', 'max:100',
                'year'   => 'required', 'string', 'max:100',
                'sex'   => 'required', 'string', 'max:100',
                'TypeCitizen'   => 'required', 'string', 'max:100',
                'citizen'   => 'required', 'string', 'max:100',  
                'nationality'   => 'required', 'string', 'max:100',  
                'blood'   => 'required',
               
                'no'   => 'required', 'string', 'max:255',
                'district'   => 'required', 'string', 'max:255',
                'amphoe'   => 'required', 'string', 'max:255',
                'province'   => 'required', 'string', 'max:255',
                'zipcode'   => 'required', 'string', 'max:255',
                'country'   => 'required', 'string', 'max:255',   
                'mobilephone'   => 'required', 'string', 'max:255',
                'Femergency'   => 'required', 'string', 'max:255',
                'Lemergency'   => 'required', 'string', 'max:255',   
                'telemergency'   => 'required', 'string', 'max:255',   
            ]
        );    

        $data=array(
            "name"          => $request->fname,
            "lname"         => $request->lname,
            "day"           => $request->day,
            "months"         => $request->month,
            "years"          => $request->year,
            "sex"           => $request->sex,
            "citizen_type"  => $request->TypeCitizen,
            "citizen"          => $request->citizen,
            "nationality"      => $request->nationality,
            "blood"            => $request->blood,
            "disease"          => $request->congenital,

            "address"          => $request->no,
            "district"         => $request->district,
            "amphoe"           => $request->amphoe,
            "province"         => $request->province,
            "country"          => $request->country,
            "zipCode"          => $request->zipcode,
            "telphone"         => $request->mobilephone,
            
            "fEmergencyContact"          => $request->Femergency,
            "lEmergencyContact"          => $request->Lemergency,
            "telEmergencyContact"        => $request->telemergency, 
            "verify_information"          => 1,
             
            "created_at"      => new \DateTime(),   
        );   
        DB::table('users')
        ->where('users.id', Auth::user()->id) 
        ->update($data); 
        return redirect()->route('event')->with('success', 'User data saved successfully.'); 
    }
    
    public function contestant($id, $get_id)
    {
        if(!empty($id)){
            $data=DB::table('cart_sport_tems') 
            ->select('cart_sport_tems.id as tems_id', 'users.name as fname', 'users.lname as lname', 'users.sex as sex',
            'tournament_types.name_th as tournament_name', 'tournament_types.name_en as tournament_name_en',
            'generations.name_th as generations_name', 'generations.name_en as generations_name_en') 
            ->leftJoin('users', 'cart_sport_tems.user_id', '=', 'users.id')
            ->leftJoin('tournament_types', 'cart_sport_tems.sporttype_id', '=', 'tournament_types.id')
            ->leftJoin('generations', 'cart_sport_tems.generation_id', '=', 'generations.id')
            ->where('cart_sport_tems.candidacy', $id) 
            ->where('cart_sport_tems.sport_id', $get_id) 
            ->where('cart_sport_tems.type_register', 2)  
            ->where('cart_sport_tems.deleted_at', NULL)
            ->where('cart_sport_tems.check_is', NULL) 
            ->get(); 
            return $data;
        } 
    } 

    public function checkemail(Request $request)
    {
        $data=[];   
        if(isset($request)){
            $email=NULL;
            if($request->radio==1){
                $row=DB::table('users') 
                ->select('users.email as email')   
                // ->where('users.deleted_at', NULL)
                ->where('users.email', $request->val)  
                ->where('users.is_users', 1)  
                ->first();
                if(isset($row->email)){
                    $email=$row->email;
                } 
            }else if($request->radio==2){
                $row=DB::table('users') 
                ->select('users.email as email')   
                ->where('users.deleted_at', NULL)
                ->where('users.is_users', 1) 
                ->where('users.citizen', $request->val)  
                ->where('users.citizen_type', 1)   
                ->first(); 
                if(isset($row->email)){
                    $email=$row->email;
                } 
            }else if($request->radio==3){
                $row=DB::table('users') 
                ->select('users.email as email')   
                ->where('users.deleted_at', NULL)
                ->where('users.is_users', 1) 
                ->where('users.citizen', $request->val)  
                ->where('users.citizen_type', 2)   
                ->first(); 
                if(isset($row->email)){
                    $email=$row->email;
                } 
            }
             
            $data=array( 
                "email" => $email,
            );
        }
        return $data;
    }

    public function search_order(Request $request)
    {
        if(isset($request)){ 
            if(!empty($request->search)){
                $search="and bill_tems.order_number LIKE '%".$request->search."%' 
                or users.name LIKE '%".$request->search."%' 
                or users.lname LIKE '%".$request->search."%'
                or users.telphone LIKE '%".$request->search."%'
                or users.citizen LIKE '%".$request->search."%'";
            }

            $data = DB::select('select bill_tems.id as bill_id, bill_tems.users_id as users_id 
            from `bill_tems` 
            left join `cart_sport_tems` on `bill_tems`.`id` = `cart_sport_tems`.`bill_id` 
            left join `users` on `cart_sport_tems`.`user_id` = `users`.`id` 
            where `bill_tems`.`payment_status` = 1 '.$search);  
        }

        if(!empty($data[0]->bill_id)){ 
            return redirect()->route('orderview', [$data[0]->bill_id.'?users_id='.$data[0]->users_id]); 
        } else {
            return redirect()->route('checkapplication')->with('error', 'No information found!'); 
        }
    }
     
}
