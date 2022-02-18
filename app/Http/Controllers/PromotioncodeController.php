<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB; 
use Illuminate\Support\Facades\Auth;
use DataTables;  
use PDF;
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

    public function promotioncreate()
    {    
        $Query = new ManageController; 
        $data=array(
            "Querytournaments" => $Query->Query_event(null),
        ); 
        return view('admin.promotioncreate', compact('data'));
    }  
    
    public function promotionupdate($get_id)
    {    
        $Query = new ManageController; 
        $firstPromotionCodes=DB::table('promotion_codes')
        ->select('*')    
        ->where('promotion_codes.verify', 0)   
        ->where('promotion_codes.id', $get_id) 
        ->first();
        $GetPromotionCodes=DB::table('promotion_codes_sponsors')
        ->select('promotion_codes_sponsors.sponsors_id as id', 'sponsors.name as sponsors_name')   
        ->leftJoin('sponsors', 'promotion_codes_sponsors.sponsors_id', '=', 'sponsors.id')   
        ->where('promotion_codes_sponsors.deleted_at', NULL)   
        ->where('promotion_codes_sponsors.code_id', $get_id) 
        ->get();
 
        $data=array(
            "Querytournaments" => $Query->Query_event(null),
            "firstPromotionCodes"   => $firstPromotionCodes,
            "GetPromotionCodes"     => $GetPromotionCodes,
            "get_id"                => $get_id,
        ); 
        return view('admin.promotionupdate', compact('data'));
    }   

    public  function Query_Promocode($keyword, $sport_id, $status_id)
    {
        $keywordSQL=""; $sportIDSQL=""; $status_idSQL="";
        if(isset($keyword)){
            if(!empty($keyword)){
                $keywordSQL="and users.name LIKE '%".$keyword."%'    
                or promotion_codes.name LIKE '%".$keyword."%'
                or promotion_codes.code LIKE '%".$keyword."%'";
            }
        }

        if(isset($sport_id)){
            if(!empty($sport_id)){
                $sportIDSQL=$sport_id;
            }
        } 

        if(isset($status_id)){
            if(!empty($status_id)){
                if($status_id==1){
                    $status_idSQL=" and promotion_codes.status = 0 and promotion_codes.verify = 0";
                } else if($status_id==2){
                    $status_idSQL=" and promotion_codes.status = 1 and promotion_codes.verify = 0";
                } else if($status_id==3){
                    $status_idSQL=" and promotion_codes.status = 2 and promotion_codes.verify = 1";
                } else if($status_id==4){ 
                    $status_idSQL=" and promotion_codes.status = 3";
                }
            }
        } 
        
        $data = DB::select('select promotion_codes.id as promocode_id, promotion_codes.name as promocode_name,
        promotion_codes.code as promocode_code, tournaments.name_th as tournaments_name,
        promotion_codes.price_discount as price_discount, users.name as userCreate, promotion_codes.created_at as created_at,
        promotion_codes.status as status, promotion_codes.verify as verify, 
        users_verify.name as usersName_verify, users_verify.lname as userslName_verify 

        from `promotion_codes`   
        left join `users` on `promotion_codes`.`user_create` = `users`.`id`
        left join users as users_verify on `promotion_codes`.`user_id` = `users_verify`.`id`
        left join `tournaments` on `promotion_codes`.`sport_id` = `tournaments`.`id`
        where promotion_codes.sport_id = '.$sportIDSQL.' 
        '.$status_idSQL.' '.$keywordSQL.'
        order by promotion_codes.id DESC'); 

        return $data;
    }
    
    public function datatablePromocode(Request $request)
    { 
        if($request->ajax()) {    
            $data=$this->Query_Promocode($request->keyword, $request->sport_id, $request->status_id); 
            return Datatables::of($data)
            ->addIndexColumn()
            ->addColumn('promocode_name', function($row){    
                return $row->promocode_name;
            }) 
            ->addColumn('promocode_code', function($row){    
                return '<span class="badge badge-dark"><i class="dripicons-ticket"></i> '.$row->promocode_code.'</span>';
            }) 
            ->addColumn('tournaments_name', function($row){    
                return $row->tournaments_name;
            }) 
            ->addColumn('price_discount', function($row){    
                return number_format($row->price_discount, 2)." ฿";
            }) 
            ->addColumn('userCreate', function($row){    
                return $row->userCreate;
            })   
            ->addColumn('created_at', function($row){    
                return date("m/d/Y", strtotime($row->created_at));
            })  
            ->addColumn('status', function($row){    
                $status=''; 
                if($row->status==0){
                    $status='<span class="badge badge-dark"> ปิดการใช้งาน </span>';
                } else if($row->status==1){
                    $status='<span class="badge badge-info"> เปิดใช้งาน </span>';
                } else if($row->status==2){
                    if($row->verify==1){
                        $status='<span class="badge badge-success"> ถูกใช้งานแล้ว </span>';
                    }  
                } else if($row->status==3){
                    $status='<span class="badge badge-danger"> ยกเลิกโค้ด </span>';
                }
                return $status;
            })  
            ->addColumn('bntmanage', function($row){     
                return  '<div class="text-right"><button type="button" class="btn btn-primary waves-effect waves-light btn-sm" 
                data-id="'.$row->promocode_id.'" id="bnt-promocode"> ตรวจสอบ  <i class="mdi mdi-file-document-box-search-outline"></i> </button></div>';
            }) 
            ->rawColumns(['promocode_name','promocode_code','tournaments_name','price_discount','userCreate','created_at','status','bntmanage'])
            ->make(true);
        } 
    }

    public function ajaxPreviwePromocode(Request $request)
    {
        if(isset($request)){
            $data=DB::table('promotion_codes')
            ->select('promotion_codes.id as id', 'promotion_codes.name as name', 'promotion_codes.detail as detail', 'promotion_codes.code as code',
            'promotion_codes.status as status', 'promotion_codes.verify as verify', 'promotion_codes.price_discount as price_discount',
            'promotion_codes.date_code as date_code', 'promotion_codes.created_at as created_at', 'promotion_codes.note as note',

            'users.name as users_fname', 'users.lname as users_lname',            
            'userCreate.name as fname', 'userCreate.lname as lname', 'tournaments.name_th as tournament_name',
            'sponsors.name as sponsors_name', 'promotion_codes_sponsors.id as codes_sponsors_id'
            )  

            ->leftJoin('tournaments', 'promotion_codes.sport_id', '=', 'tournaments.id')
            ->leftJoin('users as userCreate', 'promotion_codes.user_create', '=', 'userCreate.id') 
            ->leftJoin('users', 'promotion_codes.user_id', '=', 'users.id')  
            ->leftJoin('promotion_codes_sponsors', 'promotion_codes.id', '=', 'promotion_codes_sponsors.code_id')  
            ->leftJoin('sponsors', 'promotion_codes_sponsors.sponsors_id', '=', 'sponsors.id')  
            
            ->where('tournaments.status_event', 1) 
            ->where('tournaments.status_register', 1) 
            ->where('tournaments.status_pomotion', 1) 
            ->where('promotion_codes.id', $request->id) 
            ->get(); 

            $items=[];
            foreach($data as $key=>$row){
                $status_txt="";
                if($row->status==0){
                    $status_txt="ปิดการใช้งานโค้ด";
                } else if($row->status==1){
                    $status_txt="เปิดการใช้งานโค้ด";
                } else if($row->status==2){
                   if($row->verify==0){
                    $status_txt="โค้ดยังไม่ถูกใช้งาน";
                   } else if($row->verify==1){
                    $status_txt="โค้ดได้ถูกใช้งานแล้ว";
                   }
                } else if($row->status==3){
                    $status_txt="โค้ดถูกยกเลิก";
                }

                $items[$row->id]['id'] = $row->id;
                $items[$row->id]['name'] = $row->name;
                $items[$row->id]['detail'] = $row->detail;
                $items[$row->id]['code'] = $row->code;
                $items[$row->id]['note'] = $row->note;
                $items[$row->id]['status_txt'] = $status_txt; 
                
                $items[$row->id]['status'] = $row->status; 
                $items[$row->id]['verify'] = $row->verify; 

                $items[$row->id]['price_discount'] = number_format($row->price_discount, 2);
                $items[$row->id]['date_code']  = date("m/d/Y", strtotime($row->date_code));
                $items[$row->id]['created_at'] = date("m/d/Y", strtotime($row->created_at));
                $items[$row->id]['users_fname'] = $row->users_fname;
                $items[$row->id]['users_lname'] = $row->users_lname;
                $items[$row->id]['fname'] = $row->fname;
                $items[$row->id]['lname'] = $row->lname;
                $items[$row->id]['tournament_name'] = $row->tournament_name;
                $items[$row->id]['sponsors'][$row->codes_sponsors_id]['sponsors_id'] = $row->codes_sponsors_id;
                $items[$row->id]['sponsors'][$row->codes_sponsors_id]['sponsors_name'] = $row->sponsors_name;
            } 
        }
        return $items;
    }

    public function promotioncodesave(Request $request)
    {
        if(isset($request)){
            if(isset($request->name)){
                foreach($request->code as $row){
                    $data=array(
                        "sport_id" => $request->sport_id,
                        "name"   => $request->name,
                        "detail" => $request->detail,
                        "code"   => $row,
                        "status" => $request->status,
                        "verify" => 0,
                        "promotion_type" => 1,
                        "price_discount" => $request->discount,
                        "note"           => $request->note, 
        
                        "created_at"  => new \DateTime(),
                        "user_create" => Auth::user()->id,
                    );
                    $last_id=DB::table('promotion_codes')->insertGetId($data);
                    if(isset($request->sponsors_id)){
                        foreach($request->sponsors_id as $row){
                            $data_s=array(
                                "code_id"       => $last_id,
                                "sponsors_id"   => $row,
                                "created_at"    => new \DateTime(),
                            );
                            DB::table('promotion_codes_sponsors')->insert($data_s);
                        }
                    }
                } 
            } 
        }
        return redirect()->route('promotioncreate')->with('success', 'Save data successfully.'); 
    }

    public function promotioncodeupdate(Request $request)
    {
        if(isset($request)){ 
            $data=array(
                "sport_id" => $request->sport_id,
                "name"   => $request->name,
                "detail" => $request->detail,
                "code"   => $request->code,
                "status" => $request->status,
                "verify" => 0,
                "promotion_type" => 1,
                "price_discount" => $request->discount,
                "note"           => $request->note, 

                "updated_at"  => new \DateTime(),
                "user_create" => Auth::user()->id,
            );
            DB::table('promotion_codes')
            ->where('promotion_codes.id', $request->get_id) 
            ->update($data);  
            if(isset($request->sponsors_id)){
                DB::table('promotion_codes_sponsors')
                ->where('promotion_codes_sponsors.code_id', $request->get_id) 
                ->delete();  
                foreach($request->sponsors_id as $row){
                    $data_s=array(
                        "code_id"       => $request->get_id,
                        "sponsors_id"   => $row,
                        "created_at"    => new \DateTime(),
                    );
                    DB::table('promotion_codes_sponsors')->insert($data_s);
                }
            }
        }
        return redirect()->route('promotionupdate', [$request->get_id])->with('success', 'Update data successfully.'); 
    }

    public function promotioncodedelete(Request $request)
    {
        if(isset($request)){
            DB::table('promotion_codes')
            ->where('promotion_codes.id', $request->id) 
            ->delete();
            DB::table('promotion_codes_sponsors')
            ->where('promotion_codes_sponsors.code_id', $request->id) 
            ->delete();
        }
        return true; 
    } 
 
    public function datatableSponsors(Request $request)
    { 
        if($request->ajax()) {   
            $where="";
            if(!empty($request->val)){
                $where="where sponsors.id NOT IN (".$request->val.") "; 
            }  

            $data = DB::select('select * 
            from `sponsors`  
            '.$where.' 
            order by sponsors.id DESC'); 

            return Datatables::of($data)
            ->addIndexColumn()
            ->addColumn('sponsors_img', function($row){   
                $img=asset('images/sponsors').'/'.$row->filename; 
                return '<img src="'.$img.'" alt="" style="width: 100px;height: 70px;border-radius: 0.25rem;">';
            })  
            ->addColumn('sponsors_name', function($row){    
                return $row->name;
            })  
            ->addColumn('bntmanage', function($row){     
                return  '<div class="text-right"><button type="button" class="btn btn-primary waves-effect waves-light btn-sm" 
                data-id="'.$row->id.'" data-name="'.$row->name.'" id="add-sponsors"> <span class="txt-add-sponsors-'.$row->id.'"> เลือกข้อมูล </span> </button></div>';
            }) 
            ->rawColumns(['sponsors_img','sponsors_name', 'bntmanage'])
            ->make(true);
        } 
    }

    public function generatePDF_promocode()
    {   
        $data=array(
            'title' => 'รายการโปรโมชั่นโค้ด', 
            'Query_Promocode' => $data=$this->Query_Promocode($_GET['keyword'], $_GET['sport_id'], $_GET['status_id']), 
        ); 
        // return view('myPDF.promocode', compact('data'));
        $pdf = PDF::loadView('myPDF.promocode', compact('data')); 
        return @$pdf->stream(); 
    }   
     
}

