<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB; 
use Illuminate\Support\Facades\Auth;
use App\Models\User;
use Illuminate\Support\Facades\Session;

use Illuminate\Support\Facades\Mail;
use App\Mail\storeMail_Order;

class TournamentsController extends Controller
{
    public function recrod_tems1(Request $request)
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
                'email' =>  'required|email',
                
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
                
                'rang'   => 'required', 
                'option'   => 'required',
            ],
            [
                'fname.required' => 'This value is required.', 
                'lname.required'   => 'This value is required.',
                'day.required'   => 'This value is required.',
                'month.required'   => 'This value is required.',
                'year.required'   => 'This value is required.',
                'sex.required'   => 'This value is required.',
                'TypeCitizen.required'   => 'This value is required.',
                'citizen.required'   => 'This value is required.',  
                'email.required'    => 'This value is required.', 
                'email.email'    => 'Invalid email format.',   
                
                'nationality.required'   => 'This value is required.',  
                'blood.required'   => 'This value is required.', 

                'no.required'   => 'This value is required.',
                'district.required'   => 'This value is required.',
                'amphoe.required'   => 'This value is required.',
                'province.required'   => 'This value is required.',
                'zipcode.required'   => 'This value is required.',
                'country.required'   => 'This value is required.',   
                'mobilephone.required'   => 'This value is required.',
                'Femergency.required'   => 'This value is required.',
                'Lemergency.required'   => 'This value is required.',   
                'telemergency.required'   => 'This value is required.',   
                
                'rang.required'   => 'Please select information.', 
                'option.required'   => 'Please select information.',
            ]
        );   
         
        if(isset($request)){   
            $first=DB::table('users') 
            ->select('users.id as users_id',
            DB::raw('count(users.id) as count'))
            ->where('users.is_users', 1)
            ->where('users.deleted_at', NULL)
            ->where('users.email', $request->email)
            ->groupBy('users.id')
            ->first();   
            $count_user=0; $users_id=null;
            if(!empty($first)){ $count_user=$first->count; $users_id=$first->users_id;}  
            $data_users=array(
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
                "email"            => $request->email,
    
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
              
            if($count_user>0){
                DB::table('users')
                ->where('users.id', $users_id) 
                ->update($data_users);
                $last_id=$users_id;
            } else {
                $last_id=DB::table('users')->insertGetId($data_users);
            }

            //============ตัวแปร============//
            $price=0; $discount=0; $nettotal=0; 
            $codesID=NULL; $option=[];
            //============ตัวแปร============//

            if(isset($request->rang)){
                $tournament=DB::table('tournament_types') 
                ->select('*')
                ->where('tournament_types.tournament_id', intval($request->sport_id))
                ->where('tournament_types.id', $request->rang)
                ->where('tournament_types.deleted_at', NULL)
                ->first(); 
                if(!empty($tournament)){
                    $price=$tournament->price; // **** 
                    $nettotal=$tournament->price; // **** 
                }
                  
                $user=User::find($last_id);  
                $age=intval(date('Y')-$user->years);
                $generations_id=0; 
                if($tournament->function=="O"){
                    $generations_data = DB::select('select generations.id as g_id, generations.detail_th as detail_th from `generations`   
                    where `generations`.`tournament_id` = '.$request->sport_id.' 
                    and `generations`.`tournament_type_id` = '.$request->rang.'   
                    and `generations`.`sex` = "'.$user->sex.'" '); 
                } else if($tournament->function=="T"){
                    $generations_data = DB::select('select generations.id as g_id, generations.detail_th as detail_th from `generations`   
                    where `generations`.`tournament_id` = '.$request->sport_id.' 
                    and `generations`.`tournament_type_id` = '.$request->rang.'   
                    and `generations`.`sex` = "'.$user->sex.'" 
                    and `generations`.`age_min` <= '.$age.' 
                    and `generations`.`age_max` >= '.$age); 
                }

                $items=[];
                foreach($generations_data as $key=>$row){
                    $items['g_id'] = $row->g_id;
                    $items['detail_th'] =  $row->detail_th;
                }
                if(!empty($items['g_id'])){
                    $generations_id=$items['g_id'];
                } 
 
                // ************************************************************************//
                // $age=intval(date('Y')-$request->year);
                // $generations=DB::table('generations') 
                // ->select('generations.id as g_id')
                // ->where('generations.tournament_id', intval($request->sport_id))
                // ->where('generations.tournament_type_id', $request->rang)
                // ->where('generations.age_min', '<=', $age)
                // ->where('generations.age_max', '>=', $age)
                // ->where('generations.deleted_at', NULL)
                // ->first();  
                // ************************************************************************//
            } 
  
            if(isset($request->code)){ 
                if($request->status=="U"){
                    $promotionCode=DB::table('promotion_codes') 
                    ->select('promotion_codes.price_discount as price_discount', 'promotion_codes.id as promotion_codesID') 
                    ->where('promotion_codes.sport_id', intval($request->sport_id))
                    ->where('promotion_codes.code', $request->code)
                    ->where('promotion_codes.status', 2)
                    ->where('promotion_codes.verify', 1) 
                    ->where('promotion_codes.user_id', $last_id) 
                    ->first();   
                    if(empty($promotionCode)){
                        $promotionCode=DB::table('promotion_codes') 
                        ->select('promotion_codes.price_discount as price_discount', 'promotion_codes.id as promotion_codesID') 
                        ->where('promotion_codes.sport_id', intval($request->sport_id))
                        ->where('promotion_codes.code', $request->code)
                        ->where('promotion_codes.status', 1)
                        ->where('promotion_codes.verify', 0) 
                        ->first(); 
                    }  

                    if(isset($promotionCode->promotion_codesID)){
                        $codesID=$promotionCode->promotion_codesID;
                        $discount=$promotionCode->price_discount; // **** 
                        $nettotal=($price-$promotionCode->price_discount); // ****  
                    }
                } else {
                    $promotionCode=DB::table('promotion_codes') 
                    ->select('promotion_codes.price_discount as price_discount', 'promotion_codes.id as promotion_codesID') 
                    ->where('promotion_codes.sport_id', intval($request->sport_id))
                    ->where('promotion_codes.code', $request->code)
                    ->where('promotion_codes.status', 1)
                    ->where('promotion_codes.verify', 0) 
                    ->first(); 
                    if(isset($promotionCode->promotion_codesID)){
                        $codesID=$promotionCode->promotion_codesID;
                        $discount=$promotionCode->price_discount; // **** 
                        $nettotal=($price-$promotionCode->price_discount); // ****
                    }
                }
            }
              
            if(count($request->option)>0){
                foreach($request->option as $row){
                    $option[]=$row[0];
                }
            } 

            if($request->status=="U"){ 
                $first_set=DB::table('cart_sport_tems') 
                ->select('*')
                ->where('cart_sport_tems.id', $request->tems_id)
                ->first();
                if(!empty($first_set->promotioncode_id)){
                    $dataCode_set=array(
                        "status"  => 1,
                        "verify"  => 0,
                        "user_id" => null, 
                        "updated_at" => new \DateTime(),   
                    );
                    DB::table('promotion_codes')
                    ->where('promotion_codes.id', $first_set->promotioncode_id) 
                    ->update($dataCode_set);
                } 
            }
 
            $data=array(
                'user_id'       => $last_id,
                'sport_id'      => intval($request->sport_id),
                'sporttype_id'  => $tournament->id,
                'generation_id' => $generations_id, 
                'option_id'     => implode(',', $option),
                 
                'price_total'       => $price,
                'price_discount'    => $discount,
                'net_total'         => $nettotal,
                'promotioncode_id'  => $codesID,
                'code'              => $request->code, // เพื่อไวตรวจสอบกับ Code จริง ***
                
                'candidacy'         => Auth::user()->id,
                'type_register'     => 2,  
                "created_at"        => new \DateTime(),   
            ); 
            if($request->status=="U"){
                if(DB::table('cart_sport_tems')
                ->where('cart_sport_tems.id', $request->tems_id) 
                ->update($data)){
                    if(!empty($codesID)){
                        $dataCode=array(
                            "status"  => 2,
                            "verify"  => 1,
                            "user_id" => $last_id,
                            "date_code"  => new \DateTime(),   
                            "updated_at" => new \DateTime(),   
                        );
                        DB::table('promotion_codes')
                        ->where('promotion_codes.id', $codesID) 
                        ->update($dataCode);
                    } 
                }
            } else {
                if(DB::table('cart_sport_tems')->insert($data)){
                    if(!empty($codesID)){
                        $dataCode=array(
                            "status"  => 2,
                            "verify"  => 1,
                            "user_id" => $last_id,
                            "date_code"  => new \DateTime(),   
                            "updated_at" => new \DateTime(),   
                        );
                        DB::table('promotion_codes')
                        ->where('promotion_codes.id', $codesID) 
                        ->update($dataCode);
                    } 
                } 
            } 
        } 
        
        return redirect()->route('candidacy2', [$request->sport_id])->with('success', 'Save data successfully.'); 
    }


    public function check_promotion_code(Request $request)
    { 
        if(isset($request)){
            $data=array(
                "code"   => $request->code,
                "status" => 500, 
                "msg"    => '<span class="mt-2 text-danger check-danger"> 
                <i class="fa fa-times" aria-hidden="true"></i>
                This promotion code could not be found. 
              </span>',
            );  
            
            //==================================// 
            if($request->status=="U"){
                $tems=DB::table('cart_sport_tems') 
                ->select('cart_sport_tems.user_id as user_id')   
                ->where('cart_sport_tems.id', $request->tems_id) 
                ->first();   

                $first=DB::table('promotion_codes') 
                ->select('*')   
                ->where('promotion_codes.code', $request->code)
                ->where('promotion_codes.sport_id', intval($request->sport_id))  
                ->where('promotion_codes.status', 2)
                ->where('promotion_codes.verify', 1)
                ->where('promotion_codes.user_id', $tems->user_id)
                ->first();   
                if(!empty($first)){
                    $data=array(
                        "code"   => $request->code,
                        "status" => 200, 
                        "msg"    => '<span class="mt-2 text-success check-success"> 
                        <i class="fa fa-check-circle" aria-hidden="true"></i>
                        This promotion code can be used. 
                      </span>',
                    );
                } else {
                    $first=DB::table('promotion_codes') 
                    ->select('*')   
                    ->where('promotion_codes.code', $request->code)
                    ->where('promotion_codes.sport_id', intval($request->sport_id))  
                    ->where('promotion_codes.status', 1)
                    ->where('promotion_codes.verify', 0)
                    ->first();  
                    if(!empty($first)){
                        $data=array(
                            "code"   => $request->code,
                            "status" => 200, 
                            "msg"    => '<span class="mt-2 text-success check-success"> 
                            <i class="fa fa-check-circle" aria-hidden="true"></i>
                            This promotion code can be used. 
                            </span>',
                        );
                    }
                }
            } else {
                $first=DB::table('promotion_codes') 
                ->select('*')   
                ->where('promotion_codes.code', $request->code)
                ->where('promotion_codes.sport_id', $request->sport_id)  
                ->where('promotion_codes.status', 1)
                ->where('promotion_codes.verify', 0)
                ->first();   
                if(!empty($first)){
                    $data=array(
                        "code"   => $request->code,
                        "status" => 200, 
                        "msg"    => '<span class="mt-2 text-success check-success"> 
                        <i class="fa fa-check-circle" aria-hidden="true"></i>
                        This promotion code can be used. 
                        </span>',
                    );
                }
            }   
        } 
        return $data;
    }

    public function remove_users_register(Request $request)
    {
        if(isset($request)){
            $data=array(
                "status" => 500,
                "msg"    => "error!"
            );
            $row=DB::table('cart_sport_tems') 
            ->select('cart_sport_tems.promotioncode_id as code_id', 'cart_sport_tems.code as code',
            DB::raw('count(cart_sport_tems.id) as count'))  
            ->where('cart_sport_tems.id', $request->tems_id)
            ->where('cart_sport_tems.deleted_at', NULL) 
            ->where('cart_sport_tems.type_register', 2) 
            ->where('cart_sport_tems.promotioncode_id', '!=', "")
            ->where('cart_sport_tems.code', '!=', "")
            ->groupBy('cart_sport_tems.id')
            ->groupBy('cart_sport_tems.id')
            ->groupBy('cart_sport_tems.promotioncode_id')
            ->groupBy('cart_sport_tems.code')
            ->first(); 
            
            if(!empty($row)){
                $dataCode=array(
                    "status"  => 1,
                    "verify"  => 0,
                    "user_id" => NULL,
                    "date_code"  => NULL,   
                    "updated_at" => new \DateTime(),   
                );
                DB::table('promotion_codes')
                ->where('promotion_codes.id', $row->code_id) 
                ->update($dataCode);
            }  
            if(DB::table('cart_sport_tems')
            ->where('cart_sport_tems.id', $request->tems_id)
            ->delete()){
                $data=array(
                    "status" => 200,
                    "msg"    => "success"
                );
            }

            return $data;
        }
    }

    public function preview_cart_sport(Request $request)
    {
        if(isset($request)){
            $data=DB::table('cart_sport_tems') 
            ->select('users.name as fname', 'users.lname as lname', 'users.day as day', 'users.months as months', 'users.years as years',
            'users.sex as sex', 'users.citizen_type as citizen_type', 'users.citizen as citizen', 'users.email as email', 'users.telphone as telphone',
            'users.nationality as nationality', 'users.blood as blood', 'users.disease as disease', 'users.address as address', 'users.district as district',
            'users.amphoe as amphoe', 'users.province as province', 'users.country as country', 'users.zipCode as zipCode', 'users.fEmergencyContact as fEmergencyContact',
            'users.lEmergencyContact as lEmergencyContact', 'users.telEmergencyContact as telEmergencyContact', 

            'cart_sport_tems.sport_id as sport_id', 'cart_sport_tems.sporttype_id as sporttype_id', 'cart_sport_tems.generation_id as generation_id',
            'cart_sport_tems.option_id as option_id', 'cart_sport_tems.user_id as user_id', 'cart_sport_tems.code as code',
            'cart_sport_tems.id as cart_sport_temsID'
            )  
            ->leftJoin('users', 'cart_sport_tems.user_id', '=', 'users.id') 
            ->leftJoin('generations', 'cart_sport_tems.generation_id', '=', 'generations.id')
            ->where('cart_sport_tems.sport_id', $request->sport_id)
            ->where('cart_sport_tems.id', $request->tems_id)
            ->where('cart_sport_tems.deleted_at', NULL) 
            ->where('cart_sport_tems.type_register', 2)   
            ->first(); 
        }

        return $data;
    }

    public function create(Request $request)
    {   
        $price=0; $discount=0; $nettotal=0;
        $id=Auth::user()->id;
        $order_number=date("Ymd").$request->sport_id; 
        if(isset($request->listusers)){
            foreach($request->listusers as $row){ 

                $first=DB::table('cart_sport_tems')->select('*')   
                ->where('cart_sport_tems.deleted_at', NULL)  
                ->where('cart_sport_tems.candidacy', $id) 
                ->where('cart_sport_tems.type_register', 2)
                ->where('cart_sport_tems.id', $row)   
                ->first();  
                $data_de=array(
                    "team"          => $request->team,
                    "check_is"      => 1,
                    "updated_at"    => new \DateTime(), 
                );
                DB::table('cart_sport_tems')
                ->where('cart_sport_tems.id', $row) 
                ->update($data_de); 
  
                // $price+=$first->price_total;
                // $discount+=$first->price_discount; 
            }
            // $nettotal=($price-$discount); 
            // $data=array(
            //     "order_number"  => $order_number,
            //     "team"          => $request->team,
            //     "sport_id"      => $request->sport_id, 
            
            //     "price_total"       => $price,
            //     "price_discount"    => $discount,
            //     "net_total"         => $nettotal,
            //     "users_id"          => $id,
            //     "type_register"     => 2,

            //     "created_at"    => new \DateTime(),  
            // );
            // $last_id=DB::table('bill_tems')->insertGetId($data);
            // if(!empty($last_id)){
            //     if(isset($request->listusers)){
            //         foreach($request->listusers as $row){ 
            //             $data_de=array(
            //                 "bill_id"       => $last_id,
            //                 "updated_at"    => new \DateTime(), 
            //             );
            //             DB::table('cart_sport_tems')
            //             ->where('cart_sport_tems.id', $row) 
            //             ->update($data_de);  
            //         }
            //     }
            // } 
            // $num=$order_number.$last_id;
            // $data_number=array("order_number" => $num); 
            // DB::table('bill_tems')
            // ->where('bill_tems.id', $last_id) 
            // ->update($data_number);
            return redirect()->route('order'); 
        } else {
            return redirect()->route('candidacy2', [$request->sport_id])->with('error', 'Please specify information!'); 
        } 
    }

    public function closeOrder(Request $request)
    { 
        if(isset($request)){ 
            $data=null; 
            $Query=DB::table('cart_sport_tems')
            ->select('cart_sport_tems.promotioncode_id as promotioncode_id', 'cart_sport_tems.code as code')   
            ->where('cart_sport_tems.deleted_at', NULL) 
            ->where('cart_sport_tems.bill_id', $request->id)   
            ->get(); 
            
            if(isset($Query)){
                foreach($Query as $key=>$row){
                    if(!empty($row->promotioncode_id) && !empty($row->code)){
                        $dataCode=array(
                            "status"  => 1,
                            "verify"  => 0,
                            "user_id" => NULL,
                            "date_code"  => NULL,   
                            "updated_at" => new \DateTime(),   
                        );
                        DB::table('promotion_codes')
                        ->where('promotion_codes.id', $row->promotioncode_id) 
                        ->update($dataCode);
                    }
                }
            }

            if(DB::table('cart_sport_tems')->where('cart_sport_tems.id', $request->id)->delete()){
                $data=DB::table('bill_tems')->where('bill_tems.id', $request->id)->delete();
            }
            return $data;
        }
    }

    public function close_cartOrder(Request $request)
    {
        if(isset($request)){
            $data=null;  $id=Auth::user()->id;
            $Query=DB::table('cart_sport_tems')
            ->select('cart_sport_tems.promotioncode_id as promotioncode_id', 'cart_sport_tems.code as code')   
            ->where('cart_sport_tems.deleted_at', NULL) 
            ->where('cart_sport_tems.candidacy', $id)   
            ->where('cart_sport_tems.check_is', 1)   
            ->get(); 
            
            if(isset($Query)){
                foreach($Query as $key=>$row){
                    if(!empty($row->promotioncode_id) && !empty($row->code)){
                        $dataCode=array(
                            "status"  => 1,
                            "verify"  => 0,
                            "user_id" => NULL,
                            "date_code"  => NULL,   
                            "updated_at" => new \DateTime(),   
                        );
                        DB::table('promotion_codes')
                        ->where('promotion_codes.id', $row->promotioncode_id) 
                        ->update($dataCode);
                    }
                }
            }  
            DB::table('cart_sport_tems')->where('cart_sport_tems.bill_id', $request->id)->delete();
        }
        return $data;
    }

    public function createOne(Request $request)
    {  
        if(isset($request)){
            $id=Auth::user()->id; $option=[];
            $price=0; $discount=0; $nettotal=0; $codesID=NULL;
            $first=DB::table('tournament_types')->select('*')   
            ->where('tournament_types.deleted_at', NULL)    
            ->where('tournament_types.tournament_id', $request->sport_id) 
            ->where('tournament_types.id', $request->rang)   
            ->first();
            $price=$first->price; 
            // PROMOTION CODE //
            if(!empty($request->code)){
                $dataCode=array(
                    "status"  => 2,
                    "verify"  => 1,
                    "user_id" => $id,
                    "date_code"  => new \DateTime(),   
                );
                if(DB::table('promotion_codes')
                ->where('promotion_codes.code', $request->code) 
                ->update($dataCode)){
                    $procode=DB::table('promotion_codes')->select('*')  
                    ->where('promotion_codes.status', 2) 
                    ->where('promotion_codes.verify', 1) 
                    ->where('promotion_codes.code', $request->code)   
                    ->first();
                    $discount=$procode->price_discount;  
                    $codesID=$procode->id;
                }
            } 
            $nettotal=($price-$discount); 
            if(count($request->option)>0){
                foreach($request->option as $row){
                    $option[]=$row[0];
                }
            } 
            $data_st=array(
                'user_id'       => $id,
                'sport_id'      => intval($request->sport_id),
                'sporttype_id'  => $request->rang,
                'generation_id' => $request->generations_id, 
                'option_id'     => implode(',', $option),
                 
                'price_total'       => $price,
                'price_discount'    => $discount,
                'net_total'         => $nettotal,
                'promotioncode_id'  => $codesID,
                'code'              => $request->code, // เพื่อไวตรวจสอบกับ Code จริง ***
                
                'candidacy'         => Auth::user()->id, 
                'type_register'     => 1,
                'check_is'     => 1,
            ); 
            DB::table('cart_sport_tems')->insert($data_st);

            // $order_number=date("Ymd").$request->sport_id;
            // $price=0; $discount=0; $nettotal=0; $codesID=NULL;
            // $id=Auth::user()->id; $option=[];
            // $first=DB::table('tournament_types')->select('*')   
            // ->where('tournament_types.deleted_at', NULL)    
            // ->where('tournament_types.tournament_id', $request->sport_id) 
            // ->where('tournament_types.id', $request->rang)   
            // ->first();

            // $price=$first->price; 
            // // PROMOTION CODE //
            // if(!empty($request->code)){
            //     $dataCode=array(
            //         "status"  => 2,
            //         "verify"  => 1,
            //         "user_id" => $id,
            //         "date_code"  => new \DateTime(),   
            //     );
            //     if(DB::table('promotion_codes')
            //     ->where('promotion_codes.code', $request->code) 
            //     ->update($dataCode)){
            //         $procode=DB::table('promotion_codes')->select('*')  
            //         ->where('promotion_codes.status', 2) 
            //         ->where('promotion_codes.verify', 1) 
            //         ->where('promotion_codes.code', $request->code)   
            //         ->first();
            //         $discount=$procode->price_discount;  
            //         $codesID=$procode->id;
            //     }
            // }   

            // $nettotal=($price-$discount); 
            // $data=array(
            //     "order_number"  => $order_number, 
            //     "sport_id"      => $request->sport_id, 
               
            //     "price_total"       => $price,
            //     "price_discount"    => $discount,
            //     "net_total"         => $nettotal,
            //     "users_id"          => $id,
            //     "type_register"     => 1,
    
            //     "created_at"    => new \DateTime(),  
            // );  
            // $last_id=DB::table('bill_tems')->insertGetId($data);
            // if(!empty($last_id)){ 
            //     if(count($request->option)>0){
            //         foreach($request->option as $row){
            //             $option[]=$row[0];
            //         }
            //     } 
            //     $data_st=array(
            //         'user_id'       => $id,
            //         'sport_id'      => intval($request->sport_id),
            //         'sporttype_id'  => $request->rang,
            //         'generation_id' => $request->generations_id, 
            //         'option_id'     => implode(',', $option),
                     
            //         'price_total'       => $price,
            //         'price_discount'    => $discount,
            //         'net_total'         => $nettotal,
            //         'promotioncode_id'  => $codesID,
            //         'code'              => $request->code, // เพื่อไวตรวจสอบกับ Code จริง ***
                    
            //         'candidacy'         => Auth::user()->id,
            //         'bill_id'           => $last_id,
            //         'type_register'     => 1,
            //         'check_is'     => 1,
            //     ); 
            //     if(DB::table('cart_sport_tems')->insert($data_st)){
            //         $num=$order_number.$last_id;
            //         $data_number=array("order_number" => $num); 
            //         DB::table('bill_tems')
            //         ->where('bill_tems.id', $last_id) 
            //         ->update($data_number);
            //     }
            // }
        }
        return redirect()->route('order'); 
    }

    public function transfersave(Request $request)
    {
        $validatedData = $request->validate(
            [    
                'file_upload' => 'mimes:jpeg,jpg,png',   
            ],
            [    
                'file_upload.mimes'=>' Please upload the file as an image.',   
            ]
        );   
        if(isset($request)){
            if(!empty($request->file('file_upload'))){
                $uploade_location = 'images/payment/'; $itmes=[]; 
                $file = $request->file('file_upload');
                $file_gen = hexdec(uniqid());
                $file_ext = strtolower($file->getClientOriginalExtension()); 
                $file_name = $file_gen.'.'.$file_ext;
                $file->move($uploade_location, $file_name);
                $data=array(
                    "date_transfered" => $request->date_transferred." ".$request->time_transferred, 
                    "payment_status"  => 1,
                    "payment_type"    => 1,
                    "bank_id"         => 1,
                    "file_transfered" => $file_name,

                    "created_at"      => new \DateTime(),
                );
                DB::table('bill_tems')
                ->where('bill_tems.id', $request->bill_id)
                ->where('bill_tems.users_id', Auth::user()->id)   
                ->update($data); 

                //=======================ต้องผ่านการตรวจสอบจากเจ้าหน้าที่=======================//
                // $bill=DB::table('bill_tems')->select('users.email as email')  
                // ->leftJoin('users', 'bill_tems.users_id', '=', 'users.id')  
                // ->where('bill_tems.id', $request->bill_id) 
                // ->where('bill_tems.users_id', Auth::user()->id)   
                // ->first();
                // if(!empty($bill->email)){
                //     Mail::to($bill->email)->send(new storeMail_Order($request->bill_id));  
                // }
            } 
        } 
        return redirect()->route('payment', [$request->bill_id]); 
    }

    public function psuccess()
    {    
        if($_GET['Ref']){
            $order_number=$_GET['Ref'];
            $bill_id=$_GET['Ref1'];
            $status=$_GET['status'];
            if($status==1){
                $data=array(
                    "date_transfered" => new \DateTime(), 
                    "payment_status"  => 1,
                    "payment_type"    => 2,
                    "bank_id"         => 2, 

                    "updated_at"      => new \DateTime(),
                ); 
                DB::table('bill_tems')
                ->where('bill_tems.id', $bill_id)
                ->where('bill_tems.order_number', $order_number)
                ->where('bill_tems.users_id', Auth::user()->id)   
                ->update($data); 

                $bill=DB::table('bill_tems')->select('users.email as email')  
                ->leftJoin('users', 'bill_tems.users_id', '=', 'users.id')  
                ->where('bill_tems.id', $bill_id)
                ->where('bill_tems.order_number', $order_number)
                ->where('bill_tems.users_id', Auth::user()->id)   
                ->first();
                if(!empty($bill->email)){
                    $dataPay=array("check_payment" => 1); 
                    DB::table('bill_tems')
                    ->where('bill_tems.id', $bill_id) 
                    ->where('bill_tems.payment_type', 2)
                    ->update($dataPay);
                    $this->transfer_contestantInfo($bill_id);
                    Mail::to($bill->email)->send(new storeMail_Order($bill_id));   
                }
                return redirect()->route('payment', [$bill_id]);
            } 
        } 
    }  

    public function pwarning()
    { 
        return view('pwarning');
    }

    public function rangGenerations(Request $request)
    { 
        // เงื่อนไขการระบุรุ่นอายุของผู้เข้าแข่งขัน // 
        $priceRang=0;
        $id=Auth::user()->id;  
        $user=User::find($id);  
        $age=intval(date('Y')-$user->years);
        if(isset($request->rang)){
            $tournament=DB::table('tournament_types')->select('tournament_types.price as price', 'tournament_types.function as function') 
            ->where('tournament_types.id', $request->rang) 
            ->where('tournament_types.deleted_at', NULL)   
            ->first();
            $priceRang=$tournament->price;
        }
        
        if($tournament->function=="O"){
            $data = DB::select('select generations.id as g_id, generations.detail_th as detail_th from `generations`   
            where `generations`.`tournament_id` = '.$request->sport_id.' 
            and `generations`.`tournament_type_id` = '.$request->rang.'   
            and `generations`.`sex` = "'.$user->sex.'" '); 
        } else if($tournament->function=="T"){
            $data = DB::select('select generations.id as g_id, generations.detail_th as detail_th from `generations`   
            where `generations`.`tournament_id` = '.$request->sport_id.' 
            and `generations`.`tournament_type_id` = '.$request->rang.'   
            and `generations`.`sex` = "'.$user->sex.'" 
            and `generations`.`age_min` <= '.$age.' 
            and `generations`.`age_max` >= '.$age); 
        }  
 
        $items=[];
        foreach($data as $key=>$row){
            $items['g_id'] = $row->g_id;
            $items['detail_th'] =  $row->detail_th;
        }
         
        $array=array(
          "items"     => $items,
          "priceRang" => $priceRang,  
        );
 
        return $array;  
    }

    public function remove_listOrder(Request $request)
    {
        if(isset($request)){
            $first=DB::table('cart_sport_tems') 
            ->select('*')    
            ->where('cart_sport_tems.id', $request->tems_id)  
            ->where('cart_sport_tems.check_is', 1)
            ->where('cart_sport_tems.deleted_at', NULL)
            ->first();  
            if(!empty($first->promotioncode_id)){ 
                $dataCode=array(
                    "status"  => 1,
                    "verify"  => 0,
                    "user_id" => NULL,
                    "date_code"  => NULL,   
                    "updated_at" => new \DateTime(),   
                );
                DB::table('promotion_codes')
                ->where('promotion_codes.id', $first->promotioncode_id) 
                ->update($dataCode);
            }  
            $data=DB::table('cart_sport_tems')->where('cart_sport_tems.id', $request->tems_id)->delete();
        }
        return $data;
    }

    public function ordersave(Request $request)
    { 
        if(isset($request)){
            $order_number=null;
            $order_number=date("Ymd");  
            $last_id=null; $id=Auth::user()->id;
            $data=array(
                "order_number"  => $order_number, 
                "price_total"       => $request->price,
                "price_discount"    => $request->discount,
                "net_total"         => $request->net_total,
                "users_id"          => $id, 

                "created_at"    => new \DateTime(),  
            );
            $last_id=DB::table('bill_tems')->insertGetId($data); 
            if(!empty($last_id)){
                if(isset($request->data)){
                    foreach($request->data as $key=>$row){
                        $data_tems=array(
                            'bill_id'  => $last_id,
                            'check_is' => 2, 
                        ); 
                        DB::table('cart_sport_tems')
                        ->where('cart_sport_tems.sport_id', $row['sport_id']) 
                        ->where('cart_sport_tems.id', $row['tems_id']) 
                        ->update($data_tems);
                    }
                } 
                $num=$order_number.$last_id;
                $data_number=array("order_number" => $num); 
                DB::table('bill_tems')
                ->where('bill_tems.id', $last_id) 
                ->update($data_number);
            }
        }
        return redirect()->route('payment', [$last_id]);
    }


    // ================== Transfer ContestantInfo โอนข้อมูลนักกีฬา ================== //
    public function transfer_contestantInfo($bill_id)
    { 
        if($bill_id){ 
            $count=DB::table('race_programs')  
            ->where('race_programs.bill_id', $bill_id)   
            ->count();   
            if($count==0){

                $Query=DB::table('cart_sport_tems') 
                ->select('cart_sport_tems.id as tems_id', 'cart_sport_tems.sport_id as sport_id', 
                'cart_sport_tems.sporttype_id as sporttype_id', 'cart_sport_tems.user_id as user_id', 
                'tournaments.race_type as race_type', 'users.sex as sex', 'cart_sport_tems.generation_id as generation_id')    
                ->leftJoin('bill_tems', 'cart_sport_tems.bill_id', '=', 'bill_tems.id') 
                ->leftJoin('tournaments', 'cart_sport_tems.sport_id', '=', 'tournaments.id') 
                ->leftJoin('users', 'cart_sport_tems.user_id', '=', 'users.id') 
                ->where('cart_sport_tems.bill_id', $bill_id)  
                ->where('cart_sport_tems.check_is', 2)
                ->where('bill_tems.check_payment', 1) 
                ->get();   

                if(count($Query)>0){
                    foreach($Query as $key=>$row){
                        $BIB=$this->gen_bib($row->tems_id, $row->sport_id, $row->sporttype_id, $row->sex, $row->generation_id, $row->race_type); 
                        $data=array(
                            "bill_id"            => $bill_id,
                            "tems_id"            => $row->tems_id,
                            "tournaments_id"     => $row->sport_id,
                            "tournamentTypes_id" => $row->sporttype_id,
                            "BIB"                => $BIB,

                            "users_id"           => $row->user_id,
                            "created_at"         => new \DateTime(),  
                        ); 
                        DB::table('race_programs')->insert($data);
                    } 
                }

            }
        }
    }

    public function gen_bib($tems_id, $sport_id, $sporttype_id, $sex, $generation_id, $race_type)
    { 
        $bib=""; $num_type=""; $run_num=""; 
        if($race_type==1){ //งานวิ่ง  
            if(!empty($sex)){
                $bib.=$sex."-";
            } 
            $row_type=DB::table('tournament_types') 
            ->select('tournament_types.order_num as order_num')    
            ->where('tournament_types.id', $sporttype_id)   
            ->first();   
            $num_type=$bib.$row_type->order_num;   
            
            $check_bib=DB::table('race_programs')
            ->leftJoin('users', 'race_programs.users_id', '=', 'users.id')
            ->where('users.sex', $sex)
            ->where('race_programs.tournaments_id', $sport_id)
            ->where('race_programs.tournamentTypes_id', $sporttype_id)
            ->max('race_programs.id');  

            if(!empty($check_bib)){
                $bib_row=DB::table('race_programs')->select('race_programs.BIB as BIB')
                ->where('race_programs.id', $check_bib)->first(); 
                $explode=explode("-",$bib_row->BIB);
                $num=intval(substr($explode[1],1));
                $run=($num+1);
                if(strlen($run)==1){
                    $run_num=$num_type."00".$run;
                } else if(strlen($run)==2){
                    $run_num=$num_type."0".$run;
                } else if(strlen($run)==3){
                    $run_num=$num_type.$run;
                }
            } else {
                $run_num=$num_type."001";
            } 
        }else if($race_type==2){ //งานปันจักยาน
            $row_generations=DB::table('generations') 
            ->select('generations.order_num as order_num')    
            ->where('generations.id', $generation_id)   
            ->first();   
            
            $check_bib=DB::table('race_programs') 
            ->leftJoin('cart_sport_tems', 'race_programs.tems_id', '=', 'cart_sport_tems.id')
            ->leftJoin('generations', 'cart_sport_tems.generation_id', '=', 'generations.id') 
            ->where('generations.id', $generation_id)
            ->where('race_programs.tournaments_id', $sport_id)
            ->where('race_programs.tournamentTypes_id', $sporttype_id)
            ->max('race_programs.id');

            if(!empty($check_bib)){
                $bib_row=DB::table('race_programs')->select('race_programs.BIB as BIB')->where('race_programs.id', $check_bib)->first(); 
                $num=intval(substr($bib_row->BIB,1));
                $run=($num+1); 
                if(strlen($run)==1){
                    $run_num=$row_generations->order_num."00".$run;
                } else if(strlen($run)==2){
                    $run_num=$row_generations->order_num."0".$run;
                } else if(strlen($run)==3){
                    $run_num=$row_generations->order_num.$run;
                }
            } else {
                $run_num=$row_generations->order_num."001";
            } 
           
        }
        return $run_num;
    }

    public function confirm_bill_sendemail($bill_id){
        $bill=DB::table('bill_tems')->select('users.email as email')  
        ->leftJoin('users', 'bill_tems.users_id', '=', 'users.id')  
        ->where('bill_tems.id', $bill_id) 
        ->where('bill_tems.payment_type', 1)    
        ->first(); 
        if(!empty($bill->email)){
            $dataPay=array("check_payment" => 1); 
            DB::table('bill_tems')
            ->where('bill_tems.id', $bill_id) 
            ->where('bill_tems.payment_type', 1)
            ->update($dataPay);
            $this->transfer_contestantInfo($bill_id);
            Mail::to($bill->email)->send(new storeMail_Order($bill_id));   
        }
    }
    
}
