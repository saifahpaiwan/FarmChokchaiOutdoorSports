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
    
    public function datatablePromocode(Request $request)
    { 
        if($request->ajax()) {   
            
            $keywordSQL=""; $sportIDSQL=""; $race_idSQL="";
            if(isset($request->keyword)){
                if(!empty($request->keyword)){
                    $keywordSQL="and users.name LIKE '%".$request->keyword."%'    
                    or promotion_codes.name LIKE '%".$request->keyword."%'
                    or promotion_codes.code LIKE '%".$request->keyword."%'";
                }
            }

            if(isset($request->sport_id)){
                if(!empty($request->sport_id)){
                    $sportIDSQL=$request->sport_id;
                }
            } 

            if(isset($request->race_id)){
                if(!empty($request->race_id)){
                    $race_idSQL=" and race_programs.tournamentTypes_id = ".$request->race_id;
                }
            } 
            
            $data = DB::select('select promotion_codes.id as promocode_id, promotion_codes.name as promocode_name,
            promotion_codes.code as promocode_code, tournaments.name_th as tournaments_name,
            promotion_codes.price_discount as price_discount, users.name as userCreate, promotion_codes.created_at as created_at,
            promotion_codes.status as status, promotion_codes.verify as verify

            from `promotion_codes`   
            left join `users` on `promotion_codes`.`user_create` = `users`.`id`
            left join `tournaments` on `promotion_codes`.`sport_id` = `tournaments`.`id`
            where promotion_codes.sport_id = '.$sportIDSQL.' 
            '.$race_idSQL.' '.$keywordSQL.'
            order by promotion_codes.id DESC'); 

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
                return date("d/m/Y", strtotime($row->created_at));
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
}
