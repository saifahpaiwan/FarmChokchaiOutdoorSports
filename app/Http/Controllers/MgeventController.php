<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB; 
use Illuminate\Support\Facades\Auth;
use App\Http\Controllers\ManageController;
use DataTables;  
use PDF;

class MgeventController extends Controller
{
    public function event_list()
    {    
        $Query = new ManageController; 
        $data=array(
            "Querytournaments" => $Query->Query_event(null),
        ); 
        return view('admin.event_list', compact('data'));
    }  

    public function event_viwe($get_id)
    {     
        $data=array(
            "get_id" => $get_id,
        ); 
        return view('admin.event_viwe', compact('data'));
    }   

    public function Query_event($daterange, $event_id, $type_id, $keywrod)
    {
        $keywrodSQL=""; $event_idSQL=""; $type_idSQL=""; $daterangeSQL="";
         
        if(isset($keywrod)){
            if(!empty($keywrod)){
                $keywrodSQL="and tournaments.name_th LIKE '%".$keywrod."%' 
                or tournaments.name_en LIKE '%".$keywrod."%' 
                or tournaments.abbreviation LIKE '%".$keywrod."%'";
            }
        }
        
        if(isset($event_id)){
            if(!empty($event_id)){
                $event_idSQL=" and tournaments.id = ".$event_id;
            }
        } 

        if(isset($type_id)){
            if(!empty($type_id)){
                $type_idSQL=" and tournaments.race_type = ".$type_id;
            }
        } 

        if(!empty($daterange)){ 
            $daterangeSQL=" and (tournaments.created_at BETWEEN '".$daterange." 00:00:00 ' AND '".$daterange." 23:59:59 ') ";
        }

        $data = DB::select('select * 
        from `tournaments`    
        where tournaments.id!=""
        '.$event_idSQL.' '.$keywrodSQL.' '.$type_idSQL.' '.$daterangeSQL.'
        order by tournaments.id DESC'); 
        return $data;
    }

    public function datatableEventlist(Request $request)
    {    
        if($request->ajax()) {     
            $data=$this->Query_event($request->daterange, $request->event_id, $request->type_id, $request->keywrod);  
            return Datatables::of($data)
            ->addIndexColumn() 
            ->addColumn('icon', function($row){    
                $icon='<img src="'.asset("images/event/icon/".$row->icon).'" style="width: 40px;">';
                return $icon;
            })    
            ->addColumn('event_name', function($row){    
                return $row->name_th;
            }) 
            ->addColumn('race_type', function($row){   
                $race_type="";
                if($row->race_type==1){
                    $race_type="กีฬาประเภทวิ่ง";
                } else {
                    $race_type="กีฬาประเภทปันจักยาน";
                }
                return $race_type;
            }) 
            ->addColumn('status_register', function($row){   
                $status_register="";
                if($row->status_register==0){
                    $status_register="ปิดการสมัครการแข่งขัน";
                } else if($row->status_register==1){
                    $status_register="เปิดการสมัครการแข่งขัน";
                }
                return $status_register;
            }) 
            ->addColumn('status_event', function($row){   
                $status_event="";
                if($row->status_event==0){
                    $status_event="<span class='badge badge-dark'> ปิดการแข่งขัน </span>";
                } else if($row->status_event==1){
                    $status_event="<span class='badge badge-info'> เปิดการแข่งขัน </span>";
                } else if($row->status_event==2){
                    $status_event="<span class='badge badge-success'> จบการแข่งขัน </span>";
                }
                return $status_event;
            }) 
            ->addColumn('register_date', function($row){   
                $register_start=date("m/d/Y", strtotime($row->register_start));
                $register_end=date("m/d/Y", strtotime($row->register_end));
                return $register_start." - ".$register_end;
            }) 
            ->addColumn('created_at', function($row){    
                return date("m/d/Y", strtotime($row->created_at));
            }) 
            ->addColumn('bntmag', function($row){     
                return '<div class="text-right"><a href="'.url("/event_viwe/".$row->id).'" class="btn btn-primary waves-effect waves-light btn-sm"> 
                ตรวจสอบ  <i class="mdi mdi-file-document-box-search-outline"></i></a></div>';
            })
            ->rawColumns(['icon', 'event_name', 'race_type', 'status_register', 'status_event', 'register_date', 'created_at', 'bntmag'])
            ->make(true);
        }
    }
}
