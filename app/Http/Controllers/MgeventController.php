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
 
    public function eventcreate()
    {     
        $data=array(); 
        return view('admin.eventcreate', compact('data'));
    }   

    public function event_viwe($get_id)
    {     
        $first=DB::table('tournaments') 
        ->where('tournaments.id', $get_id)  
        ->first(); 
        $data=array(
            "get_id" => $get_id,
            'first_tournaments' => $first 
        ); 
        return view('admin.event_viwe', compact('data'));
    }   

    public function optioncreate($get_id)
    {
        $first=DB::table('tournaments') 
        ->where('tournaments.id', $get_id)  
        ->first(); 
        $Getsponsors=DB::table('tournaments_sponsors')
        ->select('tournaments_sponsors.sponsors_id as sponsors_id', 'tournaments_sponsors.id as id', 'sponsors.name as sponsors_name')   
        ->leftJoin('sponsors', 'tournaments_sponsors.sponsors_id', '=', 'sponsors.id')   
        ->where('tournaments_sponsors.deleted_at', 0)   
        ->where('tournaments_sponsors.tournament_id', $get_id) 
        ->get();
        $data=array(
            "get_id" => $get_id,
            'firsttournaments' => $first->name_th,
            'Getsponsors'      => $Getsponsors,
        ); 
        return view('admin.optioncreate', compact('data'));
    }

    public function eventsave(Request $request)
    {   
        if(isset($request)){
            $validatedData = $request->validate(
                [  
                    'race_type'          => 'required',
                    'abbreviation'       => 'required', 'string', 'max:100',    
                    'status_event'       => 'required',
                    'daterange_event'    => 'required', 'string', 'max:100',    
                    'event_name_th'      => 'required', 'string', 'max:100',    
                    'event_name_en'      => 'required', 'string', 'max:100',    
                    'title_th'           => 'required', 'string', 'max:200',    
                    'title_en'           => 'required', 'string', 'max:200',    
                    'detail_th'          => 'required', 'string', 'max:255',
                    'detail_en'          => 'required', 'string', 'max:255',
                    'address_th'         => 'required', 'string', 'max:255',    
                    'address_en'         => 'required', 'string', 'max:255',    
                    'location'           => 'required', 'string', 'max:255',    
                    'status_register'    => 'required',
                    'daterange_register' => 'required', 'string', 'max:255',
                    'status_pomotion'    => 'required',
                    'daterange_pomotion' => 'required', 'string', 'max:255', 
                    'summernote'         => 'required', 'string', 'max:255',  
                ],
                [ 
                    'race_type'          => 'This value is required.',
                    'abbreviation'       => 'This value is required.',    
                    'status_event'       => 'This value is required.',
                    'daterange_event'    => 'This value is required.',    
                    'event_name_th'      => 'This value is required.',    
                    'event_name_en'      => 'This value is required.',    
                    'title_th'           => 'This value is required.',    
                    'title_en'           => 'This value is required.',    
                    'detail_th'          => 'This value is required.',
                    'detail_en'          => 'This value is required.',
                    'address_th'         => 'This value is required.',    
                    'address_en'         => 'This value is required.',    
                    'location'           => 'This value is required.',    
                    'status_register'    => 'This value is required.',
                    'daterange_register' => 'This value is required.',
                    'status_pomotion'    => 'This value is required.',
                    'daterange_pomotion' => 'This value is required.', 
                    'summernote'         => 'This value is required.',  
                ]
            );    
            
            $event_date=explode("-", $request->daterange_event);
            $register_date=explode("-", $request->daterange_register);
            $pomotion_date=explode("-", $request->daterange_pomotion);

            $DateTime=""; $msg="";
            if(isset($request->statusDatas)){
                if($request->statusDatas=="C"){
                    $file_name=NULL; 
                    $file_name_bolg=NULL;
                    $DateTime="created_at";
                    $msg="สร้างรายการอีเวนท์สำเร็จ ขั้นตอนต่อมาโปรดระบุระบุอุปกรณ์ที่ได้รับ และสปอนเซอร์.";
                } else if($request->statusDatas=="U"){
                    $file_name=$request->hid_file_upload;
                    $file_name_bolg=$request->hid_file_upload_bolg;
                    $DateTime="updated_at";
                    $msg="อัพเดทรายการอีเวนท์สำเร็จ ขั้นตอนต่อมาโปรดระบุระบุอุปกรณ์ที่ได้รับ และสปอนเซอร์.";
                }
            } 
            
            // Images Save // 
            if($request->file('file_upload')){
                if(!empty($request->file('file_upload'))){ 
                    $uploade_location = 'images/event/icon/';

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

            if($request->file('file_upload_bolg')){
                if(!empty($request->file('file_upload_bolg'))){
                    $uploade_location_bolg = 'images/event/';  

                    if($request->statusDatas=="U"){
                        unlink($uploade_location_bolg.$file_name_bolg);
                    }

                    $file_bolg = $request->file('file_upload_bolg');
                    $file_gen_bolg = hexdec(uniqid());
                    $file_ext_bolg = strtolower($file_bolg->getClientOriginalExtension()); 
                    $file_name_bolg = $file_gen_bolg.'.'.$file_ext_bolg;
                    $file_bolg->move($uploade_location_bolg, $file_name_bolg); 
                } 
            } 

            $data=array(
                "race_type"     =>  $request->race_type,
                "abbreviation"  =>  $request->abbreviation,
                "status_event"  =>  $request->status_event,
                "event_start"   =>  date("Y-m-d", strtotime($event_date[0])),
                "event_end"     =>  date("Y-m-d", strtotime($event_date[1])),
                "name_th"       =>  $request->event_name_th,
                "name_en"       =>  $request->event_name_en,
                "title_th"      =>  $request->title_th,
                "title_en"      =>  $request->title_en,
                "detail_th"     =>  $request->detail_th,
                "detail_en"     =>  $request->detail_en,
                "address_th"    =>  $request->address_th,
                "address_en"    =>  $request->address_en, 
                
                "icon"      =>  $file_name,
                "imgname"   =>  $file_name_bolg, 
                "location"  =>  $request->location,
                "status_register"   =>  $request->status_register,
                "register_start"    =>  date("Y-m-d", strtotime($register_date[0])),
                "register_end"      =>  date("Y-m-d", strtotime($register_date[1])),
                "status_pomotion"   =>  $request->status_pomotion,
                "promotion_start"   =>  date("Y-m-d", strtotime($pomotion_date[0])),
                "promotion_end"     =>  date("Y-m-d", strtotime($pomotion_date[1])),
                "remark"  =>  $request->summernote,

                $DateTime    => new \DateTime(),
            ); 

            if(isset($request->statusDatas)){
                if($request->statusDatas=="C"){
                    $last_id=DB::table('tournaments')->insertGetId($data);
                } else if($request->statusDatas=="U"){
                    $last_id=$request->sport_id;
                    DB::table('tournaments')
                    ->where('tournaments.id', $request->sport_id)  
                    ->update($data);
                }
            }  

            if(isset($request->tournament)){
                if(count($request->tournament)>0){
                    $index=1;
                    foreach($request->tournament as $row){
                        $data_t=array(
                            "order_num" => $index,
                            
                            "tournament_id" => $last_id,
                            "name_th"       => $row['nameth'],
                            "name_en"       => $row['nameen'],
                            "detail_th"     => $row['detailth'],
                            "detail_en"     => $row['detailen'],

                            "price"         => $row['price'],
                            "distance"      => $row['distance'],
                            "unit"          => $row['unit'],
                            "function"      => $row['function'],
                            "type"          => $request->race_type,
                            "release_start" => $row['release_start'], 

                            $DateTime    => new \DateTime(),
                        );
                        $index++;
                        
                        if(isset($request->statusDatas)){
                            if($request->statusDatas=="C"){
                                $last_type_id=DB::table('tournament_types')->insertGetId($data_t);
                            } else if($request->statusDatas=="U"){
                                if($row['id']=="0"){
                                    $last_type_id=DB::table('tournament_types')->insertGetId($data_t);
                                } else {
                                    $last_type_id=$row['id'];
                                    DB::table('tournament_types')
                                    ->where('tournament_types.tournament_id', $request->sport_id)  
                                    ->where('tournament_types.id', $row['id'])  
                                    ->update($data_t);
                                } 
                            }
                        }  

                        if(isset($row['generationsarr'])){
                            if(count($row['generationsarr'])>0){
                                $index_g=1;
                                foreach($row['generationsarr'] as $row_g){
                                    $data_g=array(
                                        "order_num" => $index_g,
                                        
                                        "tournament_id"      => $last_id,
                                        "tournament_type_id" => $last_type_id,
                                        "name_th"   => $row_g['hid-generations-name-th'],
                                        "name_en"   => $row_g['hid-generations-name-en'],
                                        "age_min"   => $row_g['hid-generations-age'],
                                        "age_max"   => $row_g['hid-generations-age-to'], 

                                        "sex"           => $row_g['hid-generations-sex'],  
                                        $DateTime    => new \DateTime(),
                                    );
                                    $index_g++;

                                    if(isset($request->statusDatas)){
                                        if($request->statusDatas=="C"){
                                            DB::table('generations')->insert($data_g);
                                        } else if($request->statusDatas=="U"){ 
                                            if($row_g['hid-generations-id']=="0"){
                                                DB::table('generations')->insert($data_g);
                                            } else {
                                                DB::table('generations')
                                                ->where('generations.tournament_id', $request->sport_id)  
                                                ->where('generations.tournament_type_id', $row['id'])  
                                                ->where('generations.id', $row_g['hid-generations-id'])  
                                                ->update($data_g);
                                            } 
                                        }
                                    }  
                                   
                                }
                            }
                        }
                    } 
                }
            } 
        }
        return redirect()->route('optioncreate', [$last_id])->with('success', $msg);
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
                $icon='<img src="'.asset("images/event/icon/".$row->icon).'" style="width: 40px;border-radius: 0.25rem;">';
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

    public function datatableTournaments(Request $request)
    {    
        if($request->ajax()) {     
            $data = DB::select('select * 
            from `tournament_types`    
            where tournament_types.tournament_id='.$request->sport_id.'
            order by tournament_types.id DESC'); 
    
            return Datatables::of($data)
            ->addIndexColumn()  
            ->addColumn('buttonMg', function($row){ 
                $input="";
                $input='<button type="button" class="btn btn-icon waves-effect waves-light btn-danger btn-xs delete-tournament" data-id="'.$row->id.'"> <i class="fas fa-times"></i> </button>'; 
                $input.='<input type="hidden" id="id-tournament_type_id" class="hid-tournament_type_id" name="tournament['.$row->id.'][id]" value="'.$row->id.'">';
                $input.='<input type="hidden" id="id-tournament_type_th" class="hid-tournament_type_th" name="tournament['.$row->id.'][nameth]" value="'.$row->name_th.'">';
                $input.='<input type="hidden" id="id-tournament_type_en" class="hid-tournament_type_en" name="tournament['.$row->id.'][nameen]" value="'.$row->name_en.'">';
                $input.='<input type="hidden" id="id-tournament_type_detail_th" class="hid-tournament_type_detail_th" name="tournament['.$row->id.'][detailth]" value="'.$row->detail_th.'">';
                $input.='<input type="hidden" id="id-tournament_type_detail_en" class="hid-tournament_type_detail_en" name="tournament['.$row->id.'][detailen]" value="'.$row->detail_en.'">';
                $input.='<input type="hidden" id="id-tournament_price" class="hid-tournament_price" name="tournament['.$row->id.'][price]" value="'.$row->price.'">';
                $input.='<input type="hidden" id="id-tournament_distance" class="hid-tournament_distance" name="tournament['.$row->id.'][distance]" value="'.$row->distance.'">';
                $input.='<input type="hidden" id="id-tournament_unit" class="hid-tournament_unit" name="tournament['.$row->id.'][unit]" value="'.$row->unit.'">';
                $input.='<input type="hidden" id="id-tournament_function" class="hid-tournament_function" name="tournament['.$row->id.'][function]" value="'.$row->function.'">';
                $input.='<input type="hidden" id="id-release_start" class="hid-release_start" name="tournament['.$row->id.'][release_start]" value="'.$row->release_start.'">';
                 
                $get_generations=DB::table('generations') 
                ->where('generations.tournament_id', $row->tournament_id)  
                ->where('generations.tournament_type_id', $row->id)  
                ->get(); 

                if(isset($get_generations)){
                    foreach($get_generations as $row_g){  
                        $input.='<input type="hidden" name="tournament['.$row->id.'][generationsarr]['.$row_g->id.'][hid-generations-id]" value="'.$row_g->id.'">';
                        $input.='<input type="hidden" name="tournament['.$row->id.'][generationsarr]['.$row_g->id.'][hid-generations-name-th]" value="'.$row_g->name_th.'">';
                        $input.='<input type="hidden" name="tournament['.$row->id.'][generationsarr]['.$row_g->id.'][hid-generations-name-en]" value="'.$row_g->name_en.'">';
                        $input.='<input type="hidden" name="tournament['.$row->id.'][generationsarr]['.$row_g->id.'][hid-generations-age]" value="'.$row_g->age_min.'">';
                        $input.='<input type="hidden" name="tournament['.$row->id.'][generationsarr]['.$row_g->id.'][hid-generations-age-to]" value="'.$row_g->age_max.'">';
                        $input.='<input type="hidden" name="tournament['.$row->id.'][generationsarr]['.$row_g->id.'][hid-generations-sex]" value="'.$row_g->sex.'">';
                    }
                } 

                return $input;
            })  
            ->addColumn('nameth', function($row){ 
                return $row->name_th.' <span data-id="'.$row->id.'" class="tournament-modal-edit"> <i class="icon-note"></i> </span>';
            })
            ->addColumn('price', function($row){ 
                return $row->price;
            })
            ->addColumn('distance', function($row){ 
                return $row->distance." ".$row->unit;
            }) 
            ->addColumn('function', function($row){ 
                $function="";
                if($row->function=="T"){
                    $function="จับเวลาแข่งขัน";
                } else {
                    $function="ไม่จับเวลาแข่งขัน";
                } 
                return $function;
            })
            ->addColumn('count_generations', function($row){ 
                $count_generations=1;
                return $count_generations." รุ่น";
            })
            ->rawColumns(['buttonMg', 'nameth', 'price', 'distance', 'function', 'count_generations'])
            ->make(true);
        }
    }  

    public function closeTournamentType(Request $request)
    {
        if(isset($request)){
            $id=$request->id;
            $count=DB::table('tournament_types') 
            ->where('tournament_types.id', $id)  
            ->count(); 
            if($count>0){
                DB::delete('DELETE FROM `tournament_types` WHERE tournament_types.id= '.$id);
                DB::delete('DELETE FROM `generations` WHERE generations.tournament_type_id= '.$id); 
            }
        }
        
        return true;
    }

    public function optionSave(Request $request)
    {    
        if(isset($request)){
            if(isset($request->statusDatas)){
                if($request->statusDatas=="C"){
                    $file_name=NULL;  
                    $DateTime="created_at"; 
                } else if($request->statusDatas=="U"){
                    $file_name=$request->hid_option_file_upload; 
                    $DateTime="updated_at"; 
                }
            } 

            // Images Save // 
            if($request->file('tbl_option_file_upload')){
                if(!empty($request->file('tbl_option_file_upload'))){ 
                    $uploade_location = 'images/event/option/';

                    if($request->statusDatas=="U"){
                        unlink($uploade_location.$file_name);
                    }

                    $file = $request->file('tbl_option_file_upload');
                    $file_gen = hexdec(uniqid());
                    $file_ext = strtolower($file->getClientOriginalExtension()); 
                    $file_name = $file_gen.'.'.$file_ext;
                    $file->move($uploade_location, $file_name); 
                } 
            }

            $data=array(
                "sport_id"  => $request->sport_id,
                "name"      => $request->tbl_option_name,
                "detail"    => $request->tbl_option_detail,
                "filename"  => $file_name,
                "status"    => $request->tbl_option_status,

                $DateTime   => new \DateTime(),
            );

            if(isset($request->statusDatas)){
                if($request->statusDatas=="C"){
                    $last_id=DB::table('options')->insertGetId($data);
                } else if($request->statusDatas=="U"){ 
                   $last_id=$request->option_id;
                   DB::table('options')
                   ->where('options.id', $request->option_id)  
                   ->update($data);
                }
            }  

            if(isset($request->optionsub)){
                if(count($request->optionsub)>0){
                    foreach($request->optionsub as $row){
                        $data_sub=array(
                            "option_id" => $last_id,
                            "topic"     => $row['name'],
                            "detail"    => $row['detail'], 
            
                            $DateTime   => new \DateTime(),
                        );

                        if(isset($request->statusDatas)){
                            if($request->statusDatas=="C"){
                                DB::table('option_items')->insert($data_sub);
                            } else if($request->statusDatas=="U"){ 
                                if($row['id']=='0'){
                                    DB::table('option_items')->insert($data_sub);
                                } else { 
                                    DB::table('option_items')
                                    ->where('option_items.option_id', $last_id)  
                                    ->where('option_items.id', $row['id'])  
                                    ->update($data_sub);
                                } 
                            }
                        }  
                    }
                }
            } 
        }
        
        return redirect()->route('optioncreate', [$request->sport_id])->with('success', '');
    }

    public function datatableOption(Request $request)
    {    
        if($request->ajax()) {     
            $data = DB::select('select * 
            from `options`    
            where options.sport_id='.$request->sport_id.'
            order by options.id DESC'); 
    
            return Datatables::of($data)
            ->addIndexColumn()  
            ->addColumn('buttonMg', function($row){  
                $input='<button type="button" class="btn btn-icon waves-effect waves-light btn-danger btn-xs delete-option" data-id="'.$row->id.'"> <i class="fas fa-times"></i> </button>';
                return $input;
            })  
            ->addColumn('name', function($row){ 
                return $row->name.' <span data-id="'.$row->id.'" class="options-modal-edit"> <i class="icon-note"></i> </span>';
            })
            ->addColumn('detail', function($row){ 
                return $row->detail;
            })
            ->addColumn('status', function($row){ 
                $status="";
                if($row->status==1){
                    $status=" มีตัวเลือก ";
                } else {
                    $status=" ไม่มีตัวเลือก ";
                }
                return $status;
            })  
            ->rawColumns(['buttonMg', 'name', 'detail', 'status'])
            ->make(true);
        }
    }  
    

    public function closeOptionType(Request $request)
    {
        if(isset($request)){
            $id=$request->id;
            DB::delete('DELETE FROM `options` WHERE options.id= '.$id);
            DB::delete('DELETE FROM `option_items` WHERE option_items.option_id= '.$id); 
        }
        
        return true;
    } 

    public function createTournamentsSponsors(Request $request)
    {
        if(isset($request)){ 
            $data=array(
                "tournament_id" => $request->sport_id,
                "sponsors_id"   => $request->id,
                "created_at"    => new \DateTime(),
            );
            DB::table('tournaments_sponsors')->insert($data);
        }
        return true;
    }

    public function removeTournamentsSponsors(Request $request)
    {
        if(isset($request)){
            $id=$request->id;
            DB::delete('DELETE FROM `tournaments_sponsors` WHERE tournaments_sponsors.id= '.$id); 
        }
        return true;
    }

    public function tournamentdataedit(Request $request)
    {
        if(isset($request)){
            $data=DB::table('tournament_types') 
            ->where('tournament_types.id', $request->id)  
            ->first(); 
        }  
        return $data;
    }

    public function optiondataedit(Request $request)
    {
        if(isset($request)){
            $data=DB::table('options') 
            ->where('options.id', $request->id)  
            ->first(); 
        }  
        return $data;
    }
 
    public function datatableGenerations(Request $request)
    {
        if($request->ajax()) {     
            $data = DB::select('select * 
            from `generations`    
            where generations.tournament_id="'.$request->sport_id.'"
            and generations.tournament_type_id="'.$request->type_id.'"');  
            return Datatables::of($data)
            ->addIndexColumn()  
            ->addColumn('buttonMg', function($row){  
                $input='<button type="button" class="btn btn-icon waves-effect waves-light btn-danger btn-xs delete-generations" data-id="'.$row->id.'"> <i class="fas fa-times"></i> </button>'; 
                $input.='<input type="hidden" id="id-generations-id" class="hid-generations-id" name="generations['.$row->id.'][id]" value="'.$row->id.'">';
                $input.='<input type="hidden" id="id-generations-name-th" class="hid-generations-name-th" name="generations['.$row->id.'][nameth]" value="'.$row->name_th.'">';
                $input.='<input type="hidden" id="id-generations-name-en" class="hid-generations-name-en" name="generations['.$row->id.'][nameen]" value="'.$row->name_en.'">';
                $input.='<input type="hidden" id="id-generations-age" class="hid-generations-age" name="generations['.$row->id.'][age]" value="'.$row->age_min.'">';
                $input.='<input type="hidden" id="id-generations-age-to" class="hid-generations-age-to" name="generations['.$row->id.'][ageto]" value="'.$row->age_max.'">';
                $input.='<input type="hidden" id="id-generations-sex" class="hid-generations-sex" name="generations['.$row->id.'][sex]" value="'.$row->sex.'">';
                return $input;
            })  
            ->addColumn('name', function($row){ 
                return $row->name_th;
            })
            ->addColumn('age', function($row){ 
                return $row->age_min." - ".$row->age_max." ปี";
            }) 
            ->addColumn('sex', function($row){ 
                $sex="";
                if($row->sex=="M"){
                    $sex="เพศชาย";
                } else if($row->sex=="F"){
                    $sex="เพศหญิง";
                } 
                return $sex;
            })
            ->rawColumns(['buttonMg', 'name', 'age', 'sex'])
            ->make(true);
        }
    }

    public function closeGenerations(Request $request)
    {
        if(isset($request)){
            $id=$request->id;
            DB::delete('DELETE FROM `generations` WHERE generations.id= '.$id); 
        }
        return true; 
    }

    public function closeOptionSubs(Request $request)
    {
        if(isset($request)){
            $id=$request->id;
            DB::delete('DELETE FROM `option_items` WHERE option_items.id= '.$id); 
        }
        return true; 
    } 

    public function datatableOptionsubs(Request $request)
    {
        if($request->ajax()) {     
            $data = DB::select('select * 
            from `option_items`    
            where option_items.option_id="'.$request->id.'"');  
            return Datatables::of($data)
            ->addIndexColumn()  
            ->addColumn('buttonMg', function($row){  
                $input='<button type="button" class="btn btn-icon waves-effect waves-light btn-danger btn-xs delete-option-sub" data-id="'.$row->id.'"> <i class="fas fa-times"></i> </button>';
                $input.='<input type="hidden" id="id-option-sub-id" class="hid-option-sub-name" name="optionsub['.$row->id.'][id]" value="'.$row->id.'">';
                $input.='<input type="hidden" id="id-option-sub-name" class="hid-option-sub-name" name="optionsub['.$row->id.'][name]" value="'.$row->topic.'">';
                $input.='<input type="hidden" id="id-option-sub-detail" class="hid-option-sub-detail" name="optionsub['.$row->id.'][detail]" value="'.$row->detail.'">';
                return $input;
            })  
            ->addColumn('name', function($row){ 
                return $row->topic;
            })
            ->addColumn('detail', function($row){ 
                return $row->detail;
            }) 
            ->rawColumns(['buttonMg', 'name', 'detail'])
            ->make(true);
        }
    } 
}
