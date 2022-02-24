<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB; 

class storeMail_Order extends Mailable
{
    use Queueable, SerializesModels;

    /**
     * Create a new message instance.
     *
     * @return void
     */
    public function __construct($id)
    {
        $this->id = $id;  
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        $id=$this->id;  
        $row=$this->Order_number($id);
        $data=array(
            "QueryOrder" => $this->QueryOrder($id),
        );
        return $this->subject('Confirm payment transaction #'.$row->orderNumber.' is successful. - ยืนยันการชำระเงินรายการ #'.$row->orderNumber.' สำเร็จ.')
        ->view('Mail.email', compact('data')); 
    }

    public function Order_number($id)
    {
        $data=DB::table('bill_tems')->select('bill_tems.order_number as orderNumber')
        ->where('bill_tems.id', $id) 
        ->first();
        return $data;
    }

    public function QueryOrder($get_id)
    {
        $id=Auth::user()->id;  
        $data=DB::table('bill_tems') 
        ->select('bill_tems.id as bill_id', 'bill_tems.order_number as order_number', 
        'bill_tems.price_total as price_total', 'bill_tems.price_discount as price_discount', 'bill_tems.net_total as net_total',
        'bill_tems.created_at as created_at', 'tournaments.name_th as tournamentName', 'tournaments.race_type as raceType',
        'users.name as users_fname',  'users.lname as users_lname', 'cart_sport_tems.id as cart_sport_id', 'cart_sport_tems.code as code',
        'users_team.name as users_team_fname',  'users_team.lname as users_team_lname', 'users_team.sex as sex', 'users_team.id as users_tems_id',
        'tournament_types.name_th as tournament_type_name', 'generations.name_th as generations', 'cart_sport_tems.option_id as option_id',
        'bill_tems.payment_status as payment_status', 'bill_tems.payment_type as payment_type', 'bill_tems.date_transfered as date_transfered',
        'bill_tems.check_payment as check_payment', 'cart_sport_tems.sport_id as sport_id', 'cart_sport_tems.sporttype_id as sporttype_id',
        'race_programs.BIB as BIB', 'race_programs.status as race_status', 'tournaments.abbreviation as abbreviation')   
        ->leftJoin('users', 'bill_tems.users_id', '=', 'users.id')    
        ->leftJoin('cart_sport_tems', 'bill_tems.id', '=', 'cart_sport_tems.bill_id') 
        ->leftJoin('users as users_team', 'cart_sport_tems.user_id', '=', 'users_team.id') 
        ->leftJoin('tournaments', 'cart_sport_tems.sport_id', '=', 'tournaments.id') 
        ->leftJoin('tournament_types', 'cart_sport_tems.sporttype_id', '=', 'tournament_types.id')  
        ->leftJoin('generations', 'cart_sport_tems.generation_id', '=', 'generations.id') 
        
        ->leftJoin('race_programs', 'cart_sport_tems.id', '=', 'race_programs.tems_id') 
        
        ->where('bill_tems.deleted_at', NULL)
        // ->where('bill_tems.users_id', $id)
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
                $items[$row->bill_id]['created_at'] = $row->created_at;

                $items[$row->bill_id]['payment_status'] = $row->payment_status;
                $items[$row->bill_id]['payment_type'] = $row->payment_type;
                $items[$row->bill_id]['date_transfered'] = $row->date_transfered;
                $items[$row->bill_id]['check_payment'] = $row->check_payment;
                 
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
                $items[$row->bill_id]['datalist'][$row->cart_sport_id]['raceType'] = $raceType; 
                $items[$row->bill_id]['datalist'][$row->cart_sport_id]['code'] = $row->code;
                $items[$row->bill_id]['datalist'][$row->cart_sport_id]['users_team_fname'] = $row->users_team_fname;
                $items[$row->bill_id]['datalist'][$row->cart_sport_id]['users_team_lname'] = $row->users_team_lname; 
                $items[$row->bill_id]['datalist'][$row->cart_sport_id]['tournament_type_name'] = $row->tournament_type_name;
                $items[$row->bill_id]['datalist'][$row->cart_sport_id]['generations'] = $row->generations;
                $items[$row->bill_id]['datalist'][$row->cart_sport_id]['option'] = $option_arr;

                $items[$row->bill_id]['datalist'][$row->cart_sport_id]['BIB'] = $row->BIB;
                $items[$row->bill_id]['datalist'][$row->cart_sport_id]['race_status'] = $row->race_status; 
            }
        }   
        return $items; 
    }
}
