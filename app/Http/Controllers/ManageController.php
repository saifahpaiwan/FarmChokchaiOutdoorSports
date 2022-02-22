<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB; 
use Illuminate\Support\Facades\Auth;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use DataTables;  
use PDF;
use Illuminate\Support\Facades\Session; 
use App\Http\Controllers\HomeController;
use App\Http\Controllers\TournamentsController;
use App\Http\Controllers\ReportmatchController; 
use Illuminate\Support\Facades\Mail;
use App\Mail\storeMail_Order;

class ManageController extends Controller
{
    public function dashboard()
    {   
        $Query=DB::table('tournaments')->select('*')    
        ->where('tournaments.deleted_at', 0)
        ->where('tournaments.status_event', 1)
        ->where('tournaments.status_register', 1) 
        ->get(); 
        $data=array(
            "Querytournaments" => $Query,
        ); 
        return view('admin.dashboard', compact('data'));
    }   

    public function settings()
    {    
        $data=array(); 
        return view('admin.settings', compact('data'));
    }    
 
    public function checkOrderslist()
    {    
        $data=array(
            "Querytournaments" => $this->Query_event(null),
        ); 
        return view('admin.checkOrderslist', compact('data'));
    }   

    public function sportmanlist()
    {    
        $data=array(
            "Querytournaments" => $this->Query_event(null),
        ); 
        return view('admin.sportmanlist', compact('data'));
    }   
  
    public function racePrograms($get_id)
    {       
        $title=""; $redirect="";
        if($get_id==1){
            $title="เลือกการลงทะเบียนหน้างาน Scan QR Code"; 
            $redirect="registerQRcode";
        } else if($get_id==2){
            $title="สมัครรายการแข่งขันหน้างาน (Register)"; 
            $redirect="applySport";
        }

        $data=array(
            "Querytournaments" => $this->Query_event(null),
            "redirect" => $redirect,
            "title"  => $title,

        );
        return view('admin.racePrograms', compact('data'));
    }  

    public function applysuccess($bill_id, $users_id)
    {    
        $Query = new HomeController;   
        $data=array(
            'Querypayment' => $Query->query_payment($bill_id, true, $users_id),
        );  
        return view('admin.applysuccess', compact('data'));
    }    
 
    public function registerQRcode($get_id)
    {  
        $Query = new ReportmatchController;  
        $data=array(
            "Querytournaments" => $this->Query_event($get_id),
            "statisticsRegis"  => $Query->statisticsRegis($get_id),
        ); 
        return view('admin.registerQRcode', compact('data'));
    }  

    public function Query_event($get_id)
    {
        if(!empty($get_id)){
            $data=DB::table('tournaments')->select('*')    
            ->where('tournaments.deleted_at', 0)
            ->where('tournaments.status_event', 1)
            ->where('tournaments.status_register', 1) 
            ->where('tournaments.id', $get_id) 
            ->first(); 
        } else {
            $data=DB::table('tournaments')->select('*')    
            ->where('tournaments.deleted_at', 0)
            ->where('tournaments.status_event', 1)
            ->where('tournaments.status_register', 1) 
            ->get(); 
        }
        return $data;
    } 

    public function detailSports(Request $request)
    {
        if(isset($request)){   
            $Qrcode=$request->Qrcode;  
            $Code1=""; $Bill_id=null; $Tems_id=null;
            $Sport_id=null; $SportType_id=null; $Users_id=null; 
            if(!empty($Qrcode)){
                $explode1=explode("/",$Qrcode); 
                if(isset($explode1[4])){
                    $Code1=$explode1[4];
                }
                if(!empty($Code1)){ 
                    $explode2=explode("-",$Code1); 
                    $Bill_id=$explode2[1];
                    $Tems_id=$explode2[2]; 
                    $Sport_id=$request->sportID;
                    $SportType_id=$explode2[4];
                    $Users_id=$explode2[5];
                }
            }
  
            $Query=DB::table('race_programs') 
            ->select('bill_tems.id as bill_id', 'bill_tems.order_number as order_number', 'bill_tems.payment_type as payment_type', 
            'bill_tems.date_transfered as date_transfered', 'bill_tems.payment_status as payment_status',
            'bill_tems.file_transfered as file_transfered', 'bill_tems.created_at as created_at',
            
            'race_programs.id as race_id', 'race_programs.BIB as BIB', 'race_programs.status as raceStatus', 
            'race_programs.updated_at as raceDate',

            'users_bill.id as Busers_id', 'users_bill.name as Busers_fname', 'users_bill.lname as Busers_lname', 
            'cart_sport_tems.id as tems_id', 'cart_sport_tems.team as team',  
            'cart_sport_tems.sport_id as sport_id', 'cart_sport_tems.sporttype_id as sporttype_id',
            'users_tems.name as Temusers_fname', 'users_tems.lname as Temusers_lname', 'tournament_types.name_th as tournamentTypeName',
            'generations.name_th as generations', 'cart_sport_tems.option_id as option_id',

            'race_programs.receiver_name as receiver_name', 'race_programs.receiver_tel as receiver_tel',
            )    
            ->leftJoin('bill_tems', 'race_programs.bill_id', '=', 'bill_tems.id') 
            ->leftJoin('users as users_bill', 'bill_tems.users_id', '=', 'users_bill.id') 
            ->leftJoin('cart_sport_tems', 'race_programs.tems_id', '=', 'cart_sport_tems.id') 
            ->leftJoin('users as users_tems', 'cart_sport_tems.user_id', '=', 'users_tems.id') 
            ->leftJoin('generations', 'cart_sport_tems.generation_id', '=', 'generations.id')
            ->leftJoin('tournament_types', 'race_programs.tournamentTypes_id', '=', 'tournament_types.id')
            
            ->where('race_programs.bill_id', $Bill_id)  
            ->where('bill_tems.payment_status', 1) 
            ->where('bill_tems.check_payment', 1) 
            ->where('race_programs.tournaments_id', $Sport_id) 
            ->where('race_programs.tournamentTypes_id', $SportType_id)  
            ->get();  
            
            $itmes=null;
            if(isset($Query)){
                foreach($Query as $key=>$row){
                    $payment_status=($row->payment_status==1)? 'ชำระแล้ว <i class="text-success mdi mdi-check-circle"></i>' : 'ยังไม่ชำระ <i class="text-danger mdi mdi-close-circle"></i>';
                    $payment_type=($row->payment_type==1)? "โอนเงินผ่านธนาคาร" : "ชำระผ่านบัตรเคดิต";
                    $itmes[$row->bill_id]['bill_id']=$row->bill_id;
                    $itmes[$row->bill_id]['sport_id']=$row->sport_id;
                    $itmes[$row->bill_id]['sporttype_id']=$row->sporttype_id;
                    $itmes[$row->bill_id]['order_number']=$row->order_number;
                    $itmes[$row->bill_id]['Busers_id']=$row->Busers_id;
                    $itmes[$row->bill_id]['Busersname']=$row->Busers_fname." ".$row->Busers_lname; 
                    $itmes[$row->bill_id]['payment_status']=$payment_status;
                    $itmes[$row->bill_id]['payment_type']=$payment_type;
                    $itmes[$row->bill_id]['file_transfered']=$row->file_transfered;
                    $itmes[$row->bill_id]['date_transfered']=$row->date_transfered;
                    $itmes[$row->bill_id]['created_at']=date("m/d/Y", strtotime($row->created_at));

                    if($row->tems_id==$Tems_id){
                        $itmes[$row->bill_id]['sportsman'][$row->tems_id]['sportsman_id']=$row->tems_id;
                        $itmes[$row->bill_id]['sportsman'][$row->tems_id]['sportsman_team']=$row->team;
                        $itmes[$row->bill_id]['sportsman'][$row->tems_id]['sportsman_name']=$row->Temusers_fname." ".$row->Temusers_lname;
                        $itmes[$row->bill_id]['sportsman'][$row->tems_id]['sportsman_generations']=$row->generations;
                        $itmes[$row->bill_id]['sportsman'][$row->tems_id]['sportsman_tournamentTypeName']=$row->tournamentTypeName;
                         
                        $option_sportsman=""; 
                        $option=DB::table('option_items') 
                        ->select('option_items.topic as topic', 'option_items.detail as detail') 
                        ->whereRaw('option_items.id in ('.$row->option_id.')')
                        ->get(); 
                        foreach($option as $arr){
                            $option_sportsman.=$arr->topic." ".$arr->detail." ";
                        }
                        $itmes[$row->bill_id]['sportsman'][$row->tems_id]['sportsman_option']=$option_sportsman;

                        $itmes[$row->bill_id]['sportsman'][$row->tems_id]['sportsman_race_id']=$row->race_id;
                        $itmes[$row->bill_id]['sportsman'][$row->tems_id]['sportsman_BIB']=$row->BIB;
                        $itmes[$row->bill_id]['sportsman'][$row->tems_id]['sportsman_raceStatus']=$row->raceStatus;
                        $itmes[$row->bill_id]['sportsman'][$row->tems_id]['sportsman_raceDate']=$row->raceDate; 
                        $itmes[$row->bill_id]['sportsman'][$row->tems_id]['sportsman_receiver_name']=$row->receiver_name; 
                        $itmes[$row->bill_id]['sportsman'][$row->tems_id]['sportsman_receiver_tel']=$row->receiver_tel; 
 
                    } else { 
                        $itmes[$row->bill_id]['workers'][$row->tems_id]['workers_id']=$row->tems_id;
                        $itmes[$row->bill_id]['workers'][$row->tems_id]['workers_team']=$row->team;
                        $itmes[$row->bill_id]['workers'][$row->tems_id]['workers_name']=$row->Temusers_fname." ".$row->Temusers_lname;
                        $itmes[$row->bill_id]['workers'][$row->tems_id]['workers_generations']=$row->generations;
                        $itmes[$row->bill_id]['workers'][$row->tems_id]['workers_tournamentTypeName']=$row->tournamentTypeName;

                        $option_workers=""; 
                        $option=DB::table('option_items') 
                        ->select('option_items.topic as topic', 'option_items.detail as detail') 
                        ->whereRaw('option_items.id in ('.$row->option_id.')')
                        ->get(); 
                        foreach($option as $arr){
                            $option_workers.=$arr->topic." ".$arr->detail." ";
                        }
                        $itmes[$row->bill_id]['workers'][$row->tems_id]['workers_option']=$option_workers; 
                        $itmes[$row->bill_id]['workers'][$row->tems_id]['workers_race_id']=$row->race_id;
                        $itmes[$row->bill_id]['workers'][$row->tems_id]['workers_BIB']=$row->BIB;
                        $itmes[$row->bill_id]['workers'][$row->tems_id]['workers_raceStatus']=$row->raceStatus;
                        $itmes[$row->bill_id]['workers'][$row->tems_id]['workers_raceDate']=$row->raceDate; 
                        $itmes[$row->bill_id]['workers'][$row->tems_id]['workers_receiver_name']=$row->receiver_name; 
                        $itmes[$row->bill_id]['workers'][$row->tems_id]['workers_receiver_tel']=$row->receiver_tel;
                    }
                }
            } 
 
            return $itmes;
        }
    }

    public function registerSave(Request $request)
    {
        if(isset($request)){
            $data_set=array(
                "status" => 1,
                "receiver_name" => null,
                "receiver_tel"  => null, 
                "updated_at"    => null,
            );
            DB::table('race_programs') 
            ->where('race_programs.bill_id', $request->bill_id) 
            ->where('race_programs.tournaments_id', $request->sport_id) 
            ->update($data_set); 

            if(!empty($request->sportsmanArr)){
                $data_s=array(
                    "status" => 2,
                    "receiver_name" => $request->username,
                    "receiver_tel"  => $request->telephone,

                    "updated_at"    => new \DateTime(),
                );
                DB::table('race_programs')
                ->where('race_programs.tems_id', $request->sportsmanArr) 
                ->where('race_programs.bill_id', $request->bill_id) 
                ->where('race_programs.tournaments_id', $request->sport_id) 
                ->update($data_s); 
            }
            
            if(!empty($request->workersArr)){
                $workersArr=explode(",",$request->workersArr);
                foreach($workersArr as $key=>$val){
                    $data_w=array(
                        "status" => 2,
                        "receiver_name" => $request->username,
                        "receiver_tel"  => $request->telephone,
    
                        "updated_at"    => new \DateTime(),
                    );
                    DB::table('race_programs')
                    ->where('race_programs.tems_id', $val) 
                    ->where('race_programs.bill_id', $request->bill_id) 
                    ->where('race_programs.tournaments_id', $request->sport_id) 
                    ->update($data_w); 
                }
            }
        }
        return redirect()->route('registerQRcode', [$request->sport_id])->with('success', 'Save data successfully.'); 
    }

    public function closeRegister(Request $request)
    {
        if(isset($request)){ 
            $data_set=array(
                "status" => 1,
                "receiver_name" => null,
                "receiver_tel"  => null,

                "updated_at"    => new \DateTime(),
            );
            DB::table('race_programs')
            ->where('race_programs.tems_id', $request->sportsmanArr) 
            ->where('race_programs.bill_id', $request->bill_id) 
            ->where('race_programs.tournaments_id', $request->sport_id) 
            ->update($data_set); 
        }
        return "OK";
    }

    public function Query_Sportsman($sportID, $keyword, $race_id, $daterange)
    {
        $keywordSQL=""; $sportIDSQL=""; $race_idSQL="";
        if(isset($keyword)){
            if(!empty($keyword)){
                $keywordSQL="and users.name LIKE '%".$keyword."%' 
                or users.lname LIKE '%".$keyword."%'
                or users.telphone LIKE '%".$keyword."%'
                or users.citizen LIKE '%".$keyword."%'
                or race_programs.BIB LIKE '%".$keyword."%'
                or bill_tems.order_number LIKE '%".$keyword."%'";
            }
        }

        if(isset($sportID)){
            if(!empty($sportID)){
                $sportIDSQL=$sportID;
            }
        } 

        if(isset($race_id)){
            if(!empty($race_id)){
                $race_idSQL=" and race_programs.tournamentTypes_id = ".$race_id;
            }
        } 

        $data = DB::select('select race_programs.BIB as BIB, users.name as fname, users.lname as lname,
        cart_sport_tems.id as tems_id, race_programs.status as status, generations.name_th as generationsName,
        tournament_types.name_th as tournamentTypesName, tournaments.abbreviation as abbreviation,
        tournaments.name_th as tournamentsName,
        race_programs.bill_id as bill_id, race_programs.tems_id as tems_id, 
        race_programs.tournaments_id as tournaments_id, race_programs.tournamentTypes_id as tournamentTypes_id,
        race_programs.users_id as users_id, bill_tems.order_number as order_number, bill_tems.created_at as created_at,
        bill_tems.payment_status as payment_status, bill_tems.check_payment as check_payment

        from `race_programs` 
        left join `users` on `race_programs`.`users_id` = `users`.`id` 
        left join `cart_sport_tems` on `race_programs`.`tems_id` = `cart_sport_tems`.`id`  
        left join `generations` on `cart_sport_tems`.`generation_id` = `generations`.`id`  
        left join `tournaments` on `race_programs`.`tournaments_id` = `tournaments`.`id`  
        left join `tournament_types` on `race_programs`.`tournamentTypes_id` = `tournament_types`.`id`
        left join `bill_tems` on `race_programs`.`bill_id` = `bill_tems`.`id`  
        where race_programs.tournaments_id = '.$sportIDSQL.' '.$keywordSQL.' '.$race_idSQL.'
        order by bill_tems.id asc'); 
        return $data;
    }

    public function datatableReportSportsman(Request $request) 
    {    
        if($request->ajax()) {   
            $data = $this->Query_Sportsman($request->sport_id, $request->keyword, $request->race_id, $request->daterange); 
            return Datatables::of($data)
            ->addIndexColumn()
            ->addColumn('order_number', function($row){    
                return '<b>#'.$row->order_number.'</b>';
            }) 
            ->addColumn('name', function($row){    
                return $row->fname." ".$row->lname;
            }) 
            ->addColumn('bib', function($row){    
                return '<b>'.$row->BIB.'</b>';
            }) 
            ->addColumn('tournamentsName', function($row){    
                return $row->tournamentsName;
            })
            ->addColumn('tournamentTypesName', function($row){    
                return $row->tournamentTypesName;
            }) 
            ->addColumn('generationsName', function($row){    
                return $row->generationsName;
            }) 
            ->addColumn('payment_status', function($row){   
                $status=""; 
                if($row->payment_status==1){
                    if($row->check_payment==1){
                        $status='<span class="badge badge-success">ชำระเงินแล้ว <i class="icon-check"></i></span>';
                    }else{
                        $status='<span class="badge badge-warning">
                        ชำระเงินแล้วรอตรวจสอบ <i class="icon-clock"></i></span>';
                    }
                } else if($row->payment_status==2){
                    $status='<span class="badge badge-danger"> 
                    ยกเลิกการชำระเงิน <i class="icon-close"></i></span>';
                } else if($row->payment_status==3){
                    $status='<span class="badge badge-danger"> 
                    เกินกำหนดการชำระ <i class="mdi mdi-clock-alert-outline"></i></span>';
                } else if($row->payment_status==4){
                    $status='<span class="badge badge-danger"> 
                    ยกเลิกรายการ <i class="icon-close"></i></span>';
                } else {
                    $status='<span class="badge badge-danger"> 
                    ยังไม่ชำระเงิน <i class="icon-close"></i></span>';
                }
                return $status;
            })    
            ->addColumn('created_at', function($row){    
                return date("m/d/Y", strtotime($row->created_at));
            }) 
            ->addColumn('btnStatus', function($row){     
                $disabled="disabled";
                if($row->payment_status==1 && $row->check_payment==1){
                    $disabled="";
                }
                $button='<button type="button" class="btn btn-primary waves-effect waves-light btn-sm" id="geninvoice" data-id="'.$row->tems_id.'" '.$disabled.'>  
                ออกใบกำกับภาษี <i class="mdi mdi-file-document-box-check-outline"></i>  </button>';
                return '<div class="text-right">'.$button.'</div>';
            })   
            ->rawColumns(['order_number', 'name', 'bib', 'tournamentsName', 'tournamentTypesName', 'generationsName', 'payment_status', 'created_at', 'btnStatus'])
            ->make(true);
        }
    }

    public function datatableSportsman(Request $request)
    {    
        if($request->ajax()) {    
            $data = $this->Query_Sportsman($request->sportID, $request->keyword, null, null); 
            return Datatables::of($data)
            ->addIndexColumn()
            ->addColumn('bib', function($row){    
                return '<b>'.$row->BIB.'</b>';
            }) 
            ->addColumn('name', function($row){    
                return $row->fname." ".$row->lname ;
            }) 
            ->addColumn('generationsName', function($row){    
                return $row->generationsName;
            }) 
            ->addColumn('detail', function($row){    
                return $row->tournamentTypesName;
            }) 
            ->addColumn('status', function($row){  
                if($row->check_payment==1){
                    if($row->status==1){
                        $status_txt='<span class="badge badge-danger"> ยังไม่ลงทะเบียน </span>';
                    }else{
                        $status_txt='<span class="badge badge-success"> ลงทะเบียนแล้ว </span>';
                    } 
                }  else {
                    $status_txt='<span class="badge badge-warning"> รอตรวจสอบ </span>';
                } 
                      
                return $status_txt;
            }) 
            ->addColumn('btnStatus', function($row){     
                $val='https://demo.chokchaiinternational.com/playerinfo/'.$row->abbreviation.'-'.$row->bill_id.'-'.$row->tems_id.'-'.$row->tournaments_id.'-'.$row->tournamentTypes_id.'-'.$row->users_id;
                if($row->check_payment==1){
                    if($row->status==1){
                        $button='<button type="button" class="btn btn-sm btn-primary waves-effect width-md waves-light" id="btnSQR" data-id="'.$val.'"> ลงทะเบียน </button>';
                    }else{
                        $button='<button type="button" class="btn btn-sm btn-success waves-effect width-md waves-light" id="btnSQR" data-id="'.$val.'"> ดูข้อมูล </button>';
                    }
                } else {
                    $button='<button type="button" class="btn btn-sm btn-primary waves-effect width-md waves-light" id="btnSQR" data-id="'.$val.'" disabled> ลงทะเบียน </button>';
                }
                return '<div class="text-right">'.$button.'</div>';
            })   
            ->rawColumns(['bib', 'name', 'generationsName', 'detail', 'status', 'btnStatus'])
            ->make(true);
        }
    }


    public function Query_bill($event_id, $status_id, $orderNumber, $daterange)
    { 
        $event_idSQL=""; $status_idSQL=""; $orderNumberSQL=""; $daterangeSQL="";
        if(!empty($event_id)){
            $event_idSQL=" and cart_sport_tems.sport_id = ".$event_id;
        } 
        if(!empty($status_id)){
            if($status_id==1){
                $status_idSQL=" and bill_tems.payment_status = 1 and bill_tems.check_payment = 1";
            } else if($status_id==2){
                $status_idSQL=" and bill_tems.payment_status = 1 and bill_tems.check_payment = 0 ";
            } else if($status_id==3){
                $status_idSQL=" and bill_tems.payment_status = 0 and bill_tems.check_payment = 0";
            } 
        }

        if(!empty($orderNumber)){
            $orderNumberSQL=" and bill_tems.order_number = '".$orderNumber."' ";
        }

        if(!empty($daterange)){
            $explode=explode("-", $daterange);
            $date1=date("Y-m-d", strtotime($explode[0]));
            $date2=date("Y-m-d", strtotime($explode[1]));
            $daterangeSQL=" and (bill_tems.created_at BETWEEN '".$date1." 00:00:00 ' AND '".$date2." 23:59:59 ') ";
        }
 
        $data = DB::select('select bill_tems.id as bill_id, bill_tems.order_number as order_number, users.name as fname, users.lname as lname, users.id as usersID,
        bill_tems.payment_status as payment_status, bill_tems.payment_type as payment_type, bill_tems.date_transfered as date_transfered,
        bill_tems.file_transfered as file_transfered, bill_tems.check_payment as check_payment, bill_tems.net_total as net_total,
        bill_tems.created_at as created_at
        
        from `bill_tems` 
        left join `cart_sport_tems` on `bill_tems`.`id` = `cart_sport_tems`.`bill_id`  
        left join `users` on `bill_tems`.`users_id` = `users`.`id`  
        where users.is_users = 1 
        '.$event_idSQL.' '.$orderNumberSQL.' '.$status_idSQL.' '.$daterangeSQL.'
        GROUP BY  bill_tems.id, bill_tems.order_number, users.name, users.lname, users.id,
        bill_tems.payment_status, bill_tems.payment_type, bill_tems.date_transfered,
        bill_tems.file_transfered, bill_tems.check_payment, bill_tems.net_total, bill_tems.created_at
        order by bill_tems.id DESC'); 
        return $data;
    }
    
    public function datatableBill(Request $request)
    {    
        if($request->ajax()) {     
            //==========================================//
            $data = $this->Query_bill($request->event_id, $request->status_id, $request->orderNumber, $request->daterange);
            //=========================================//
            return Datatables::of($data)
            ->addIndexColumn()
            ->addColumn('order_number', function($row){    
                return '<b>#'.$row->order_number.'</b>';
            }) 
            ->addColumn('name', function($row){    
                return $row->fname." ".$row->lname;
            }) 
            ->addColumn('payment_type', function($row){    
                $payment_type="";
                if($row->payment_type==1){
                    $payment_type="โอนเงินผ่านธนาคาร";
                }else{$payment_type="ชำระผ่านบัตรเคดิต";}
                return $payment_type;
            }) 
            ->addColumn('date_transfered', function($row){    
                return date("m/d/Y", strtotime($row->date_transfered))." ".date("H:i:s", strtotime($row->date_transfered))." น.";
            })  
            ->addColumn('net_total', function($row){    
                return number_format($row->net_total, 2)." ฿";
            })
            ->addColumn('payment_status', function($row){  
                $status="";   
                if($row->payment_status==1){
                    if($row->check_payment==1){
                        $status='<span class="badge badge-success">ชำระเงินแล้ว <i class="icon-check"></i></span>';
                    }else{
                        $status='<span class="badge badge-warning">
                        ชำระเงินแล้วรอตรวจสอบ <i class="icon-clock"></i></span>';
                    }
                } else if($row->payment_status==2){
                    $status='<span class="badge badge-danger"> 
                    ยกเลิกการชำระเงิน <i class="icon-close"></i></span>';
                } else if($row->payment_status==3){
                    $status='<span class="badge badge-danger"> 
                    เกินกำหนดการชำระ <i class="mdi mdi-clock-alert-outline"></i></span>';
                } else if($row->payment_status==4){
                    $status='<span class="badge badge-danger"> 
                    ยกเลิกรายการ <i class="icon-close"></i></span>';
                } else {
                    $status='<span class="badge badge-danger"> 
                    ยังไม่ชำระเงิน <i class="icon-close"></i></span>';
                }
                return $status;
            })  
            ->addColumn('created_at', function($row){    
                return date("m/d/Y", strtotime($row->created_at));
            })
            ->addColumn('button_viwe', function($row){    
                return '<div class="text-right"><button type="button" class="btn btn-primary waves-effect waves-light btn-sm" 
                id="btn-modal-sportsman" data-id="'.$row->bill_id.'" data-usersid="'.$row->usersID.'"> ตรวจสอบ  <i class="mdi mdi-file-document-box-search-outline"></i></button></div>';
            })
            ->rawColumns(['order_number','name','payment_type','date_transfered','net_total','payment_status','created_at' ,'button_viwe'])
            ->make(true);
        }
    }

    public function QueryBill(Request $request)
    {
        if(isset($request)){ 
            $Query = new HomeController;  
            return $Query->query_payment($request->bill_id, true, $request->users_id);
        }
    }

    public function generatePDF_bill()
    {  
        $data=array(
            'title' => 'รายการออเดอร์ Farm Chokchai Outdoor Sports', 
            'Query_bill' => $this->Query_bill($_GET['event_id'], $_GET['status_id'], $_GET['orderNumber'], $_GET['daterange']),
        );
        // return view('myPDF.bill', compact('data'));
        $pdf = PDF::loadView('myPDF.bill', compact('data')); 
        return @$pdf->stream(); 
    }  

    public function generatePDF_sportman()
    {   
        $data=array(
            'title' => 'รายการผู้สมัครเข้าแข่งขัน', 
            'Query_Sportsman' => $this->Query_Sportsman($_GET['sport_id'], $_GET['keyword'], $_GET['race_id'], NULL),
        ); 
        // return view('myPDF.sportman', compact('data'));
        $pdf = PDF::loadView('myPDF.sportman', compact('data')); 
        return @$pdf->stream(); 
    }   

    public function generatePDF_invoice()
    {  
        $bill_id=null;
        if(isset($_GET['bill_id'])){
            $bill_id=$_GET['bill_id'];
        }
        $tems_id=null;
        if(isset($_GET['tems_id'])){
            $tems_id=$_GET['tems_id'];
        }

        $Query = new HomeController;   
        $data=array(
            'title' => 'ใบเสร็จรับเงิน/ใบกำกับภาษี',  
            'Query_invoice' => $this->Query_invoice($bill_id, $tems_id),
        ); 
        // return view('myPDF.invoice', compact('data'));
        $pdf = PDF::loadView('myPDF.invoice', compact('data')); 
        return @$pdf->stream(); 
    }

    public function Query_invoice($bill_id, $tems_id)
    {
        $where=""; $id="";
        if(!empty($bill_id)){
            $where="cart_sport_tems.bill_id";
            $id=$bill_id;
        }
        if(!empty($tems_id)){
            $where="cart_sport_tems.id";
            $id=$tems_id;
        }

        $data=DB::table('cart_sport_tems') 
        ->select('tournaments.name_th as tournamentName', 'tournament_types.name_th as tournament_type_name',  
            'bill_tems.order_number as order_number',
            'users_team.name as users_team_fname',  'users_team.lname as users_team_lname',
            'users_team.address as dl_address', 'users_team.district as dl_district', 'users_team.amphoe as dl_amphoe',
            'users_team.province as dl_province', 'users_team.zipCode as dl_zipCode', 'users_team.telphone as dl_phone', 'users_team.citizen as dl_citizen',
            'tournament_types.price as dl_price', 
            'cart_sport_tems.price_total as tems_price', 'cart_sport_tems.price_discount as tems_discount', 'cart_sport_tems.net_total as temsNet_total',
        )      
        ->leftJoin('users as users_team', 'cart_sport_tems.user_id', '=', 'users_team.id') 
        ->leftJoin('tournaments', 'cart_sport_tems.sport_id', '=', 'tournaments.id') 
        ->leftJoin('tournament_types', 'cart_sport_tems.sporttype_id', '=', 'tournament_types.id')  
        ->leftJoin('bill_tems', 'cart_sport_tems.bill_id', '=', 'bill_tems.id')  
        ->where($where, $id)  
        ->get(); 
        
        return $data;
    }

    public function confirm_bill(Request $request)
    {
        $result=[];
        if(isset($request)){ 
            $bill=DB::table('bill_tems')->select('bill_tems.users_id as users_id')   
            ->where('bill_tems.id', $request->bill_id)  
            ->first(); 
            $data=array(
                "check_payment" => 1,
                "note" => $request->note,
                "updated_at" => new \DateTime(),
            );
            $result=DB::table('bill_tems') 
            ->where('bill_tems.id', $request->bill_id)  
            ->update($data); 
            // ==================== Send Data Bill ==================== // 
            $ClassTournaments=new TournamentsController;
            $ClassTournaments->confirm_bill_sendemail($request->bill_id);
            // ==================== Send Data Bill ==================== // 
            $result=array(
                "bill_id"  => $request->bill_id,
                "users_id" => $bill->users_id,
            ); 
        }
        return $result;
    }
 
    public function cancelCheck_bill(Request $request)
    {
        $result=[];
        if(isset($request)){ 
            $bill=DB::table('bill_tems')->select('bill_tems.users_id as users_id')   
            ->where('bill_tems.id', $request->bill_id)  
            ->first(); 
            $data=array(
                "payment_status" => 4, 
                "check_payment"  => 1, 
                "updated_at" => new \DateTime(),
            );
            $result=DB::table('bill_tems') 
            ->where('bill_tems.id', $request->bill_id)  
            ->update($data);
            $result=array(
                "bill_id"  => $request->bill_id,
                "users_id" => $bill->users_id,
            ); 
        }
        return $result;
    }

    public function ajaxSelete_sport_type(Request $request)
    {
        if(isset($request)){
            $data=DB::table('tournament_types') 
            ->where('tournament_types.tournament_id', $request->id)  
            ->get(); 
        } 
        return $data;
    }

    public function applySport($get_id)
    {  
        $Query = new HomeController;  
        $data = array(  
            'contestant' => $Query->contestant(1, $get_id),
            'QueryTournaments' => $Query->Query_tournaments_type($get_id),
            'Query_option'     => $Query->Query_option($get_id),
            'first_tournaments' => $Query->first_tournaments($get_id),
        );    
        return view('admin.applySport', compact('data'));
    }  

    public function saveApplySportman(Request $request)
    { 
        if(isset($request)){
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
             
            // ==================SAVE USER================== //
            $firstUsers=DB::table('users') 
            ->select('users.id as users_id',
            DB::raw('count(users.id) as count'))
            ->where('users.is_users', 1)
            ->where('users.deleted_at', NULL)
            ->where('users.email', $request->email)
            ->groupBy('users.id')
            ->first();   
            $count_user=0; $users_id=null;
            if(!empty($firstUsers)){ $count_user=$firstUsers->count; $users_id=$firstUsers->users_id;}  
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
            }

            if(isset($request->code)){ 
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

            if(count($request->option)>0){
                foreach($request->option as $row){
                    $option[]=$row[0];
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
                'type_register'     => 1,  
                'check_is'          => 2,
                'created_at'        => new \DateTime(),   
            ); 
            $tems_id=DB::table('cart_sport_tems')->insertGetId($data);
            if(!empty($tems_id)){
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
            
            //=======================Created Bill Order=======================//
            $file_name=NULL;
            if(!empty($request->file('file_upload'))){
                $uploade_location = 'images/payment/'; $itmes=[]; 
                $file = $request->file('file_upload');
                $file_gen = hexdec(uniqid());
                $file_ext = strtolower($file->getClientOriginalExtension()); 
                $file_name = $file_gen.'.'.$file_ext;
                $file->move($uploade_location, $file_name); 
            } 

            $order_number=date("Ymd");  
            $data=array(
                "order_number"      => $order_number, 
                "price_total"       => $price,
                "price_discount"    => $discount,
                "net_total"         => $nettotal,
                "users_id"          => $last_id, 
                
                "date_transfered" => $request->date_transferred." ".$request->time_transferred, 
                "payment_status"  => 1,
                "payment_type"    => 1,
                "bank_id"         => 1,
                "check_payment"   => 1, 
                "file_transfered" => $file_name,

                "created_at"    => new \DateTime(),  
            );
            $bill_id=DB::table('bill_tems')->insertGetId($data); 
            if(!empty($bill_id)){
                $num=$order_number.$bill_id;
                $data_number=array("order_number" => $num); 
                DB::table('bill_tems')
                ->where('bill_tems.id', $bill_id) 
                ->update($data_number);  
                $data_tems=array('bill_id'  => $bill_id); 
                DB::table('cart_sport_tems')
                ->where('cart_sport_tems.sport_id', $request->sport_id) 
                ->where('cart_sport_tems.id', $tems_id) 
                ->update($data_tems);
            }

            //=======================ต้องผ่านการตรวจสอบจากเจ้าหน้าที่=======================//
            $bill_first=DB::table('bill_tems')->select('users.email as email')  
            ->leftJoin('users', 'bill_tems.users_id', '=', 'users.id')  
            ->where('bill_tems.id', $bill_id) 
            ->where('bill_tems.users_id', $last_id)   
            ->first(); 

            if(!empty($bill_first->email)){
                $QueryTournaments=new TournamentsController;
                $QueryTournaments->transfer_contestantInfo($bill_id); 
                $data_race=array(
                    "status" => 2,
                    "receiver_name" => "Admin",
                    "receiver_tel" => "-",
                    "created_at" => new \DateTime(),
                );
                DB::table('race_programs')
                ->where('race_programs.bill_id', $bill_id) 
                ->where('race_programs.tems_id', $tems_id) 
                ->update($data_race);
                Mail::to($bill_first->email)->send(new storeMail_Order($bill_id));  
            } 
        }

        return redirect()->route('applysuccess', [$bill_id, $last_id])->with('success', 'Save data successfully.'); 
    }

    public function datatableadmin(Request $request)
    { 
        if($request->ajax()) {     
            $data = DB::select('select * 
            from `users`  
            where users.is_users = 2 
            order by users.id DESC'); 

            return Datatables::of($data)
            ->addIndexColumn()
            ->addColumn('id', function($row){    
                return $row->id;
            }) 
            ->addColumn('name', function($row){    
                return $row->name." ".$row->lname;
            })  
            ->addColumn('email', function($row){    
                return $row->email;
            })  
            ->addColumn('created_at', function($row){    
                return date("m/d/Y", strtotime($row->created_at));
            })  
            ->addColumn('is_users', function($row){      
                return  "ผู้ใช้งานระบบ";
            }) 
            ->addColumn('bntDelete', function($row){    
                $disabled="";
                if($row->id==Auth::user()->id){
                    $disabled="disabled";
                }
                return  '<div class="text-right"><button type="button" class="btn btn-primary waves-effect waves-light btn-sm" 
                data-id="'.$row->id.'" id="deleteAdmin" '.$disabled.'> <span class="txt-deleteAdmin-'.$row->id.'"> ลบข้อมูล </span> </button></div>';
            }) 
            ->rawColumns(['id','name','email','created_at','is_users', 'bntDelete'])
            ->make(true);
        } 
    }

    public function registerAdmin(Request $request)
    {
        $validatedData = $request->validate(
            [  
                'name' => ['required', 'string', 'max:255'],
                'email' => ['required', 'string', 'email', 'max:255', 'unique:users'],
                'password' => ['required', 'string', 'min:8', 'confirmed'],
            ] 
        );   
        $data=array(
            'name'  => $request->name,
            'email' => $request->email,
            'is_users' => 2,
            'password' => Hash::make($request->password), 
            "created_at"    => new \DateTime(),  
        );
        DB::table('users')->insert($data);  
        return redirect()->route('settings')->with('success', 'Save data successfully.'); 
    }
    
    public function deleteAdmin(Request $request)
    {
        if(isset($request)){
            $data=DB::table('users')
            ->where('users.id', $request->id)  
            ->delete();
        }
        return $data;
    }

    public function sponsorslist()
    {    
        $data=array(); 
        return view('admin.sponsorslist', compact('data'));
    } 
     
    public function datatableSponsorsmg(Request $request)
    {    
        if($request->ajax()) {     
            $keywrodSQL=""; $daterangeSQL="";
            if(isset($request->keywrod)){
                if(!empty($request->keywrod)){
                    $keywrodSQL="and sponsors.name LIKE '%".$request->keywrod."%'  
                    or sponsors.detail LIKE '%".$request->keywrod."%'";
                }
            }

            if(!empty($request->daterange)){ 
                $daterangeSQL=" and (sponsors.created_at BETWEEN '".$request->daterange." 00:00:00 ' AND '".$request->daterange." 23:59:59 ') ";
            }

            $data = DB::select('select * 
            from `sponsors`    
            where sponsors.deleted_at in (0,1)
           '.$keywrodSQL.' '.$daterangeSQL.'
            order by sponsors.order_number asc'); 

            return Datatables::of($data)
            ->addIndexColumn() 
            ->addColumn('img', function($row){    
                $img='<img src="'.asset("images/sponsors/".$row->filename).'" style="width: 100px;height: 70px;border-radius: 0.25rem;">';
                return $img;
            })    
            ->addColumn('name', function($row){    
                return $row->name;
            })   
            ->addColumn('status', function($row){
                $status='<span class="badge badge-info"> เปิดการแสดงผล </span>';  
                if($row->deleted_at=="1"){
                    $status='<span class="badge badge-danger"> ปิดการแสดงผล </span>';
                }
                return $status;
            })  
            ->addColumn('created_at', function($row){    
                return date("m/d/Y", strtotime($row->created_at));
            }) 
            ->addColumn('buttonMg', function($row){     
                return '<div class="text-right"><button type="button" class="btn btn-primary waves-effect waves-light btn-sm" id="sponsors-edit" data-id="'.$row->id.'">ตรวจสอบ  <i class="mdi mdi-file-document-box-search-outline"></i></button></div>';
            })
            ->rawColumns(['img', 'name', 'status', 'created_at', 'buttonMg'])
            ->make(true);
        }
    }  

    public function sponsorsSave(Request $request)
    {
        if(isset($request)){ 
            $msg="";
            if(isset($request->statusDatas)){
                if($request->statusDatas=="C"){
                    $file_name=NULL;  
                    $DateTime="created_at"; 
                    $msg='Save data successfully.';
                } else if($request->statusDatas=="U"){
                    $file_name=$request->hid_file_upload; 
                    $DateTime="updated_at"; 
                    $msg='Update data successfully.';
                }
            } 
            if($request->file('file_upload')){
                if(!empty($request->file('file_upload'))){ 
                    $uploade_location = 'images/sponsors/'; 
                    if($request->statusDatas=="U"){
                        unlink($uploade_location.$file_name);
                    } 
                    $file = $request->file('file_upload');
                    $file_gen = hexdec(uniqid());
                    $file_ext = strtolower($file->getClientOriginalExtension()); 
                    $file_name = $file_gen.'.'.$file_ext;
                    $file->move($uploade_location, $file_name); 
                } 
            }

            $data=array(
                "order_number"  => $request->sponsors_ordernumber,
                "name"          => $request->sponsors_name,
                "detail"        => $request->sponsors_detail,
                "filename"      => $file_name,

                "deleted_at"      => $request->sponsors_status,

                $DateTime    => new \DateTime(),
            );
            if(isset($request->statusDatas)){
                if($request->statusDatas=="C"){
                    DB::table('sponsors')->insert($data);
                } else if($request->statusDatas=="U"){ 
                    DB::table('sponsors')
                    ->where('sponsors.id', $request->sponsors_id)  
                    ->update($data);
                }
            }   
        }
        return redirect()->route('sponsorslist')->with('success', $msg); 
    }

    public function datasponsorsedit(Request $request)
    {
        if(isset($request)){
            $data=DB::table('sponsors') 
            ->where('sponsors.id', $request->id)  
            ->first(); 
        }  
        return $data;
    }

    public function closeSponsors(Request $request)
    {
        if(isset($request)){
            $data=DB::table('sponsors')
            ->where('sponsors.id', $request->id)  
            ->delete();
        }
        return $data;
    }
    
}
