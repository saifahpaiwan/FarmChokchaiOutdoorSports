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
use App\Http\Controllers\MgeventController;
use App\Http\Controllers\MgwebsiteController;
use App\Http\Controllers\DashboardController;

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
    Route::get('/applicantlist', [ManageController::class, 'applicantlist'])->name('applicantlist'); 
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
    Route::get('generatePDF_applicant', [ManageController::class, 'generatePDF_applicant'])->name('generatePDF_applicant.post'); 
    Route::get('generatePDF_sportman', [ManageController::class, 'generatePDF_sportman'])->name('generatePDF_sportman.post'); 
    Route::get('generatePDF_invoice', [ManageController::class, 'generatePDF_invoice'])->name('generatePDF_invoice.post'); 
    Route::post('confirm_bill', [ManageController::class, 'confirm_bill'])->name('confirm_bill.post');
    Route::post('cancelCheck_bill', [ManageController::class, 'cancelCheck_bill'])->name('cancelCheck_bill.post');  
    Route::post('ajaxSelete_sport_type', [ManageController::class, 'ajaxSelete_sport_type'])->name('ajaxSelete_sport_type.post'); 
     
    Route::get('/applySport/{id}', [ManageController::class, 'applySport'])->name('applySport');  
    Route::get('/applysuccess/{bill_id}/{users_id}', [ManageController::class, 'applysuccess'])->name('applysuccess');  
    Route::post('saveApplySportman', [ManageController::class, 'saveApplySportman'])->name('saveApplySportman.post');  

    // =============== สถิติรายงานการแข่งขัน =============== //
    Route::get('/statisticsRegis', [ReportmatchController::class, 'statisticsRegis'])->name('statisticsRegis'); 
    
    // =============== จัดการโปรโมรชั่น Code =============== //
    Route::get('/promotionlist', [PromotioncodeController::class, 'promotionlist'])->name('promotionlist');  
    Route::get('/promotion_exportcode', [PromotioncodeController::class, 'promotion_exportcode'])->name('promotion_exportcode');  
    Route::get('datatablePromocode', [PromotioncodeController::class, 'datatablePromocode'])->name('datatablePromocode.post'); 
    Route::post('ajaxPreviwePromocode', [PromotioncodeController::class, 'ajaxPreviwePromocode'])->name('ajaxPreviwePromocode.post');  
    Route::get('/promotioncreate', [PromotioncodeController::class, 'promotioncreate'])->name('promotioncreate'); 
    Route::get('/promotionupdate/{id}', [PromotioncodeController::class, 'promotionupdate'])->name('promotionupdate');   
    Route::post('promotioncodesave', [PromotioncodeController::class, 'promotioncodesave'])->name('promotioncodesave.post'); 
    Route::post('promotioncodeupdate', [PromotioncodeController::class, 'promotioncodeupdate'])->name('promotioncodeupdate.post');   
    Route::post('promotioncodedelete', [PromotioncodeController::class, 'promotioncodedelete'])->name('promotioncodedelete.post');   
    Route::get('datatableSponsors', [PromotioncodeController::class, 'datatableSponsors'])->name('datatableSponsors.post');  
    Route::get('generatePDF_promocode', [PromotioncodeController::class, 'generatePDF_promocode'])->name('generatePDF_promocode.post');
    
    
    // =============== จัดการงาน Event =============== //
    Route::get('/event_list', [MgeventController::class, 'event_list'])->name('event_list');  
    Route::get('datatableEventlist', [MgeventController::class, 'datatableEventlist'])->name('datatableEventlist.post'); 
    Route::get('/event_viwe/{id}', [MgeventController::class, 'event_viwe'])->name('event_viwe');

    Route::get('/eventcreate', [MgeventController::class, 'eventcreate'])->name('eventcreate');
    Route::post('eventsave', [MgeventController::class, 'eventsave'])->name('eventsave.post');  
    Route::get('/optioncreate/{id}', [MgeventController::class, 'optioncreate'])->name('optioncreate');
    Route::get('datatableTournaments', [MgeventController::class, 'datatableTournaments'])->name('datatableTournaments.post'); 
    Route::post('closeTournamentType', [MgeventController::class, 'closeTournamentType'])->name('closeTournamentType.post');  
    Route::post('optionSave', [MgeventController::class, 'optionSave'])->name('optionSave.post');  
    Route::get('datatableOption', [MgeventController::class, 'datatableOption'])->name('datatableOption.post'); 
    Route::post('closeOptionType', [MgeventController::class, 'closeOptionType'])->name('closeOptionType.post');
    Route::post('createTournamentsSponsors', [MgeventController::class, 'createTournamentsSponsors'])->name('createTournamentsSponsors.post');
    Route::post('removeTournamentsSponsors', [MgeventController::class, 'removeTournamentsSponsors'])->name('removeTournamentsSponsors.post');
    Route::post('tournamentdataedit', [MgeventController::class, 'tournamentdataedit'])->name('tournamentdataedit.post');  
    Route::get('datatableGenerations', [MgeventController::class, 'datatableGenerations'])->name('datatableGenerations.post'); 
    Route::post('closeGenerations', [MgeventController::class, 'closeGenerations'])->name('closeGenerations.post');
    Route::post('optiondataedit', [MgeventController::class, 'optiondataedit'])->name('optiondataedit.post');  
    Route::get('datatableOptionsubs', [MgeventController::class, 'datatableOptionsubs'])->name('datatableOptionsubs.post'); 
    Route::post('closeOptionSubs', [MgeventController::class, 'closeOptionSubs'])->name('closeOptionSubs.post');
    Route::post('closeEvent', [MgeventController::class, 'closeEvent'])->name('closeEvent.post');  

    // =============== จัดการ Sponsors =============== //
    Route::get('/sponsorslist', [ManageController::class, 'sponsorslist'])->name('sponsorslist'); 
    Route::get('datatableSponsorsmg', [ManageController::class, 'datatableSponsorsmg'])->name('datatableSponsorsmg.post'); 
    Route::post('sponsorsSave', [ManageController::class, 'sponsorsSave'])->name('sponsorsSave.post');
    Route::post('datasponsorsedit', [ManageController::class, 'datasponsorsedit'])->name('datasponsorsedit.post');   
    Route::post('closeSponsors', [ManageController::class, 'closeSponsors'])->name('closeSponsors.post');     

    // =============== จัดการหน้าเว็บไซต์ =============== //
    Route::get('/mgWebsite', [MgwebsiteController::class, 'mgWebsite'])->name('mgWebsite'); 
    Route::post('websitesave', [MgwebsiteController::class, 'websitesave'])->name('websitesave.post'); 
 
});
