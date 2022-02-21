<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB; 
use Illuminate\Support\Facades\Auth; 
use App\Http\Controllers\HomeController;
use Illuminate\Support\Facades\Storage;

class MgwebsiteController extends Controller
{
    public function mgWebsite()
    {     
        $homeQ=new HomeController;
        $data=array(
            "Querywebsite" => $homeQ->Querywebsite(),
        ); 
        return view('admin.mgWebsite', compact('data'));
    }  

    public function websitesave(Request $request)
    {
        if(isset($request)){
            $file_name=$request->hid_file_upload;
            if($request->file('file_upload')){
                if(!empty($request->file('file_upload'))){ 
                    $uploade_location = 'images/blog/';
                    unlink($uploade_location.$file_name);
                    $file = $request->file('file_upload');
                    $file_gen = hexdec(uniqid());
                    $file_ext = strtolower($file->getClientOriginalExtension()); 
                    $file_name = $file_gen.'.'.$file_ext; 
                    $file->move($uploade_location, $file_name); 
                } 
            }

            if(!empty($request->summernote_detail)){
                Storage::delete(storage_path().'/app/'.$request->hid_file_detail);
                $file_text=$request->hid_file_detail;  
                Storage::disk('local')->put($file_text, $request->summernote_detail);
            } 

            $data=array(
                "background"    => $file_name,
                "summernote_box1" => $request->summernote_title,
                "summernote_box2" => $file_text,
                "updated_at" => new \DateTime(),
            );
            DB::table('website')
            ->where('website.id', 1)  
            ->update($data);
        }
        return redirect()->route('mgWebsite')->with('success', 'Update data successfully.'); 
    }
}
