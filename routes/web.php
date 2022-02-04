<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Session;
use App\Http\Controllers\HomeController;
use App\Http\Controllers\TournamentsController;
use App\Http\Controllers\ManageController;

use App\Http\Controllers\MainController;
use App\Http\Controllers\Auth\LoginController;
use App\Http\Controllers\ReportmatchController;
use App\Http\Controllers\PromotioncodeController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/
 
Auth::routes();
Route::get('change/{locale}', function ($locale) {
    Session::put("locale", $locale);
    return Redirect::back();
});
Route::get('/', [HomeController::class, 'index'])->name('home')->middleware('is_verify_information');   
Route::get('/about', [HomeController::class, 'about'])->name('about');
Route::get('/contact', [HomeController::class, 'contact'])->name('contact');
Route::get('/checkapplication', [HomeController::class, 'checkapplication'])->name('checkapplication');
Route::get('/joinus', [HomeController::class, 'joinus'])->name('joinus');
Route::get('/privacpolicy', [HomeController::class, 'privacpolicy'])->name('privacpolicy');
Route::get('/conditions', [HomeController::class, 'conditions'])->name('conditions');
Route::get('/event', [HomeController::class, 'event'])->name('event');  
  

Route::post('check_promotion_code', [TournamentsController::class, 'check_promotion_code'])->name('check_promotion_code.post');

Route::middleware(['is_users'])->group(function () { 
    Route::get('/member', [HomeController::class, 'member'])->name('member'); 
    Route::post('saveuser', [HomeController::class, 'saveuser'])->name('saveuser.post'); 
    Route::get('/candidacy1/{id}', [HomeController::class, 'candidacy1'])->name('candidacy1'); 
    Route::get('/candidacy2/{id}', [HomeController::class, 'candidacy2'])->name('candidacy2'); 
    Route::get('/order', [HomeController::class, 'order'])->name('order');  
    Route::get('/registerform/{id}', [HomeController::class, 'registerform'])->name('registerform');  
    
    // การสมัครการแข่งขัน //
    Route::post('recrod_tems1', [TournamentsController::class, 'recrod_tems1'])->name('recrod_tems1.post');  
    Route::post('remove_users_register', [TournamentsController::class, 'remove_users_register'])->name('remove_users_register.post'); 
    Route::post('preview_cart_sport', [TournamentsController::class, 'preview_cart_sport'])->name('preview_cart_sport.post');  
    Route::post('create', [TournamentsController::class, 'create'])->name('create.post');
    Route::post('createOne', [TournamentsController::class, 'createOne'])->name('createOne.post'); 
    Route::post('closeOrder', [TournamentsController::class, 'closeOrder'])->name('closeOrder.post'); 
    Route::post('remove_listOrder', [TournamentsController::class, 'remove_listOrder'])->name('remove_listOrder.post');  
    Route::post('close_cartOrder', [TournamentsController::class, 'close_cartOrder'])->name('close_cartOrder.post');  

    // PAYMENT //
    Route::get('/payment/{id}', [HomeController::class, 'payment'])->name('payment');  
    Route::get('/transfer/{id}', [HomeController::class, 'transfer'])->name('transfer');  
    Route::post('transfersave', [TournamentsController::class, 'transfersave'])->name('transfersave.post'); 
    Route::get('/psuccess', [TournamentsController::class, 'psuccess'])->name('psuccess');
    Route::get('/pwarning', [TournamentsController::class, 'pwarning'])->name('pwarning');
    Route::post('ordersave', [TournamentsController::class, 'ordersave'])->name('ordersave.post'); 
    Route::get('/history', [HomeController::class, 'history'])->name('history');
    
    Route::post('rangGenerations', [TournamentsController::class, 'rangGenerations'])->name('rangGenerations.post');  
    Route::get('/playerinfo/{code}', [HomeController::class, 'playerinfo'])->name('playerinfo');  
}); 
Route::get('/orderview/{id}', [HomeController::class, 'orderview'])->name('orderview');   
Route::post('search_order', [HomeController::class, 'search_order'])->name('search_order.post'); 

Route::post('checkemail', [HomeController::class, 'checkemail'])->name('checkemail.post'); 


Route::get('/testOrder/{id}', [TournamentsController::class, 'testOrder'])->name('testOrder'); 
// Route::get('/transfer_contestantInfo/{id}', [TournamentsController::class, 'transfer_contestantInfo'])->name('transfer_contestantInfo'); 
  
// ==============================================LOGIN-SOCIAL============================================================//
Route::get('/login/google', [LoginController::class, 'redirectToGoogle'])->name('login.google'); 
Route::get('/login/google/callback', [LoginController::class, 'handleGoogleCallback']); 
 
Route::get('/login/facebook', [LoginController::class, 'redirectToFacebook'])->name('login.facebook'); 
Route::get('/login/facebook/callback', [LoginController::class, 'handleFacebookCallback']);

// Line Login //
Route::get('/auth/liff', function () {
    return view('/auth/liff');
})->name('login.liff'); 
Route::post('/login/line', [LoginController::class, 'redirectToLine'])->name('login.line'); 

// ==============================================Manage Backend============================================================//
Route::middleware(['isAdmin'])->group(function () {
    Route::get('/settings', [ManageController::class, 'settings'])->name('settings'); 
    Route::get('datatableadmin', [ManageController::class, 'datatableadmin'])->name('datatableadmin.post');  
    Route::post('deleteAdmin', [ManageController::class, 'deleteAdmin'])->name('deleteAdmin.post'); 
    Route::post('registerAdmin', [ManageController::class, 'registerAdmin'])->name('registerAdmin.post'); 
    

    Route::get('/dashboard', [ManageController::class, 'dashboard'])->name('dashboard'); 
    Route::get('/checkOrderslist', [ManageController::class, 'checkOrderslist'])->name('checkOrderslist');
    Route::get('/sportmanlist', [ManageController::class, 'sportmanlist'])->name('sportmanlist'); 
    
    Route::get('/racePrograms/{id}', [ManageController::class, 'racePrograms'])->name('racePrograms'); 
    Route::get('/registerQRcode/{id}', [ManageController::class, 'registerQRcode'])->name('registerQRcode'); 
    Route::post('detailSports', [ManageController::class, 'detailSports'])->name('detailSports.post'); 
    Route::post('registerSave', [ManageController::class, 'registerSave'])->name('registerSave.post'); 
    Route::post('closeRegister', [ManageController::class, 'closeRegister'])->name('closeRegister.post');  
    Route::get('datatableSportsman', [ManageController::class, 'datatableSportsman'])->name('datatableSportsman.post'); 
    Route::get('datatableReportSportsman', [ManageController::class, 'datatableReportSportsman'])->name('datatableReportSportsman.post'); 
    Route::get('datatableBill', [ManageController::class, 'datatableBill'])->name('datatableBill.post'); 
    Route::post('QueryBill', [ManageController::class, 'QueryBill'])->name('QueryBill.post');
    Route::get('generatePDF_bill', [ManageController::class, 'generatePDF_bill'])->name('generatePDF_bill.post');
    Route::get('generatePDF_sportman', [ManageController::class, 'generatePDF_sportman'])->name('generatePDF_sportman.post'); 
    Route::get('generatePDF_invoice', [ManageController::class, 'generatePDF_invoice'])->name('generatePDF_invoice.post'); 
    Route::post('confirm_bill', [ManageController::class, 'confirm_bill'])->name('confirm_bill.post');
    Route::post('cancelCheck_bill', [ManageController::class, 'cancelCheck_bill'])->name('cancelCheck_bill.post');  
    Route::post('ajaxSelete_sport_type', [ManageController::class, 'ajaxSelete_sport_type'])->name('ajaxSelete_sport_type.post'); 
     
    Route::get('/applySport/{id}', [ManageController::class, 'applySport'])->name('applySport');  
    Route::get('/applysuccess/{bill_id}/{users_id}', [ManageController::class, 'applysuccess'])->name('applysuccess');  
    Route::post('saveApplySportman', [ManageController::class, 'saveApplySportman'])->name('saveApplySportman.post');  

    // =============== รายงานการแข่งขัน =============== //
    Route::get('/statisticsRegis', [ReportmatchController::class, 'statisticsRegis'])->name('statisticsRegis'); 
    
    // =============== จัดการโปรโมรชั่น Code =============== //
    Route::get('/promotionlist', [PromotioncodeController::class, 'promotionlist'])->name('promotionlist');  
    Route::get('datatablePromocode', [PromotioncodeController::class, 'datatablePromocode'])->name('datatablePromocode.post'); 
});
