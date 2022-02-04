<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB; 
use Illuminate\Support\Facades\Session; 

class ReportmatchController extends Controller
{ 
    public function statisticsRegis($get_id)
    { 
        $tournament_id=$get_id;
        $countSumsportman = DB::select('select count(race_programs.id) as count 
        from `race_programs` 
        left join `bill_tems` on `race_programs`.`bill_id` = `bill_tems`.`id`  
        where `race_programs`.`tournaments_id` = '.$tournament_id.' 
        and `bill_tems`.`payment_status` = 1
        and `bill_tems`.`check_payment` = 1');   
        $countRegissportman = DB::select('select count(race_programs.id) as count
        from `race_programs` 
        left join `bill_tems` on `race_programs`.`bill_id` = `bill_tems`.`id`  
        where `race_programs`.`tournaments_id` = '.$tournament_id.' 
        and `bill_tems`.`payment_status` = 1
        and `bill_tems`.`check_payment` = 1
        and `race_programs`.`status` = 2');   
        
        $items=[];   
        $items[1]['title']="สถิติการลงทะเบียน"; 
        $items[1]['rang'][0]['topic']="จำนวนผู้เข้าแข่งขันทั้งหมด "; 
        $items[1]['rang'][0]['count']=number_format($countSumsportman[0]->count)." คน"; 
        $items[1]['rang'][1]['topic']="จำนวนผู้มาลงทะเบียน "; 
        $items[1]['rang'][1]['count']=number_format($countRegissportman[0]->count)." คน"; 

        $items[2]['title']="จำนวนผู้เข้าแข่งขันตามระยะการแข่งขันทั้งหมด";  
        $tournament = DB::select('select count(`tournament_types`.`id`) as `count`, 
        `tournament_types`.`name_th` as `tournament_name` 
        from `tournament_types` 
        left join `race_programs` on `tournament_types`.`id` = `race_programs`.`tournamentTypes_id` 
        left join `bill_tems` on `race_programs`.`bill_id` = `bill_tems`.`id` 
        where `tournament_types`.`tournament_id` = '.$tournament_id.'
        and `bill_tems`.`payment_status` = 1
        and `bill_tems`.`check_payment` = 1
        GROUP BY  `tournament_types`.`name_th`');
        
        if(isset($tournament)){
            foreach($tournament as $key=>$row){
                $items[2]['rang'][$key]['topic']=$row->tournament_name; 
                $items[2]['rang'][$key]['count']=$row->count." คน";
            }
        }    
        return $items;
    }
    
}
