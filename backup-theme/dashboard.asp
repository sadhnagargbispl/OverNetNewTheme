<!DOCTYPE html>
<html lang="en">
<!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Welcome</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta name="description">
<meta name="author">

<!-- -------------------- Start CSS Files --------------------  -->
<link href="assets/cssfile/bootstrap.min.css" rel="stylesheet">
<link href="assets/cssfile/bootstrap-responsive.min.css" rel="stylesheet">
<link href="assets/cssfile/font-awesome.css" rel="stylesheet">
<link href="assets/cssfile/style.css" rel="stylesheet">
<link id="ctl00_style_color" href="assets/cssfile/style_navy-blue.css" rel="stylesheet">
<link rel="stylesheet" href="assets/cssfile/font-awesome.min.css">
<link href="assets/cssfile/jquery.fancybox.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="assets/cssfile/uniform.default.css">
<link rel="stylesheet" type="text/css" href="assets/cssfile/jquery.gritter.css">
<link rel="stylesheet" href="assets/cssfile/font-awesome.min.css">

<link href="assets/cssfile/style_responsive.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<link href="assets/cssfile/added_css_rohit.css" rel="stylesheet">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=El+Messiri&display=swap" rel="stylesheet">


<!-- -------------------- End CSS Files --------------------  -->

<!-- -------------------- Start JS Files --------------------  -->

<!--<script src="assets/jsfile/jquery.dataTables.min.js" type="text/javascript"></script>-->
<!-- BEGIN JAVASCRIPTS -->
<!-- Load javascripts at bottom, this will reduce page load time -->

<script src="assets/jsfile/jquery-1.8.3.min.js"></script>
<script src="assets/jsfile/bootstrap.min.js"></script>
<script src="assets/jsfile/jquery.blockui.js"></script>
<script src="assets/jsfile/progress.js"></script>
<script src="assets/jsfile/SearchJScript.js" type="text/javascript"></script>
<script type="text/javascript">
        function dothis() {
            alert('You can not request e-Pin, first purchasing/retailing a package !');
        }
        function dothis1() {
            alert('You activation request is pending !');
        }     
    </script>
    
 
<!--<script src="assets/jsfile/scripts.js"></script>-->
<script>
        var loginid = null;
        jQuery(document).ready(function () {
            // initiate layout and plugins
            App.init();
            loginid = 'companyid'

        });


        /* this code use for active menu in run time 
        when menu put on master page then not hhightligted the sub menu so Write this code and highligth menu
        Created By  : Fida Husain
        */
        $(document).ready(function () {
            var url = window.location.pathname,
        urlRegExp = new RegExp(url.replace(/\/$/, '') + "$");
            $('.has-sub li a').each(function () {
                if (urlRegExp.test(this.href.replace(/\/$/, ''))) {
                    var _pagename = url.substring(url.lastIndexOf('/') + 1);
                    $('a[href="' + _pagename + '"]').parent('li').parent('ul').parent('li').removeClass().addClass('has-sub active');
                    $('a[href="' + _pagename + '"]').parent('li').addClass('active');

                }
            });
        })
    </script>

<script>
 
        //_____________________________ Link Click on Change Passsword

        function link_changepassword() {
            document.getElementById("btSubmit").disabled = false;
            $('#ErrorDiv_Popup').html("<button data-dismiss='alert' class='close'>×</button> Are You Sure Change Paswssword to this user '<strong>" + ViewstateUsername + "<strong>'  ?");
            $('#ErrorDiv_Popup').removeClass().addClass("alert alert-warning");
            $('#ErrorDiv_Popup').show();
         }

        //______________________________________ Submit Button Change Password

         function changepassword() {

            if ($("span").hasClass("input-error")) {
                $('#ErrorDiv_Popup').html(" <button data-dismiss='alert' class='close'>×</button> * Please  Fill Correct Information. !");
                $('#ErrorDiv_Popup').removeClass().addClass("alert alert-error");
                $('#ErrorDiv_Popup').show();
            }
            else {
                $('#ErrorDiv_Popup').hide();
                updatePassword();
            }

        }
        function updatePassword() {
            var oldpassword = $("#ctl00_txt_p_old").val();
            var newPassword = $("#ctl00_txt_p_new").val();
            $.ajax({
                type: "POST",
                url: "Getdata_member.asmx/UpdatePasswordMember",
                data: "{loginid:'" + loginid + "',oldpassword:'" + oldpassword + "' ,newpassword:'" + newPassword + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: updatepasswordSuccess,
                error: function (xhr, status, error) {
                    $('#ErrorDiv_Popup').html("<button data-dismiss='alert' class='close'>×</button> Sorry, There are techinical error please try again. !!");
                    $('#ErrorDiv_Popup').removeClass().addClass("alert alert-error");
                    $('#ErrorDiv_Popup').show();
                    alert("UpdatePasswordMember");
                }
            });
        }
        function updatepasswordSuccess(ResultUpdatePassword) {
            var jsonData = ResultUpdatePassword.d;
            $('#ErrorDiv_Popup').html("<button data-dismiss='alert' class='close'>×</button>  Congratulations,   Your Password Successfully Changed. !!");
            $('#ErrorDiv_Popup').removeClass().addClass("alert alert-success");
            $('#ErrorDiv_Popup').show();
            switch (ResultUpdatePassword.d) {
                case "false":
                    $('#ErrorDiv_Popup').html("<button data-dismiss='alert' class='close'>×</button> Failed, Password Not Changed. !!");
                    $('#ErrorDiv_Popup').removeClass().addClass("alert alert-error");
                    $('#ErrorDiv_Popup').show();
                    break;
                case "true":
                    document.getElementById("btSubmit").disabled = true;
                    $('#ErrorDiv_Popup').html("<button data-dismiss='alert' class='close'>×</button> Congratulations, <strong>" + loginid + "</strong> Your Password Successfully Changed. !!");
                    $('#ErrorDiv_Popup').removeClass().addClass("alert alert-success");
                    $('#ErrorDiv_Popup').show();
                    break;
            }
        }

        function NewPassword() {
            pass = $("#ctl00_txt_p_new").val();
            if (pass == "") {
                $('#div1_new').removeClass().addClass("control-group error");
                $('#span1_new').removeClass().addClass("input-error tooltips");
                $('#i1_new').removeClass().addClass("icon-exclamation-sign");
                return false;
            }
            if (pass.length <= 3) {
                $('#div1_new').removeClass().addClass("control-group warning");
                $('#span1_new').removeClass().addClass("input-warning tooltips");
                $('#i1_new').removeClass().addClass("icon-warning-sign");
                return false;
            }
            else {
                $('#div1_new').removeClass().addClass("control-group success");
                $('#span1_new').removeClass().addClass("input-success tooltips");
                $('#i1_new').removeClass().addClass("icon-ok");
                return false;
            }
        }
        //________________________________________________ Check Previoue Password _________________________________


        function checkoldPassword() {
            var old_password = $("#ctl00_txt_p_old").val();
            $.ajax({
                type: "POST",
                url: "Getdata_member.asmx/CheckOldPassword",
                data: "{ loginid:'" + loginid + "',oldpassword:'" + old_password + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: checkoldPasswordSuccess,
                error: function (xhr, status, error) {
                    alert("CheckOldPassword");
                }

            });
        }
        function checkoldPasswordSuccess(Resultold) {
            var jsonData = Resultold.d;
            switch (Resultold.d) {
                case "true":
                    $('#div1_old').removeClass().addClass("control-group success");
                    $('#span1_old').removeClass().addClass("input-success tooltips");
                    $('#i1_old').removeClass().addClass("icon-ok");

                    break;
                case "false":
                    $('#div1_old').removeClass().addClass("control-group error");
                    $('#span1_old').removeClass().addClass("input-error tooltips");
                    $('#i1_old').removeClass().addClass("icon-exclamation-sign");

                    break;
            }

        }
        //________________________________________________ Check Repassword  Password _________________________________
        function RepasswordP() {
            repa = $("#ctl00_txt_p_re").val();
            pass = $("#ctl00_txt_p_new").val();
            if (pass != repa) {
                $('#div1_repassword').removeClass().addClass("control-group error");
                $('#span1_repassword').removeClass().addClass("input-error tooltips");
                $('#i1_repassword').removeClass().addClass("icon-exclamation-sign");
                return false;
            }
            if (repa.length <= 3) {
                $('#div1_repassword').removeClass().addClass("control-group warning");
                $('#span1_repassword').removeClass().addClass("input-warning tooltips");
                $('#i1_repassword').removeClass().addClass("icon-warning-sign");
                return false;
            }
            else {
                $('#div1_repassword').removeClass().addClass("control-group success");
                $('#span1_repassword').removeClass().addClass("input-success tooltips");
                $('#i1_repassword').removeClass().addClass("icon-ok");
                return false;
            }
        }

    </script>
<!-- END JAVASCRIPTS -->

 
<!--<script>
jQuery(document).ready(function($) {
	$(".hppop_close, .hppop").click(function(){
		$(".hppop_bg").fadeOut(500);
		$(".hppop").fadeOut(500);	
	});
});
</script>-->
 

<!-- -------------------- End JS Files --------------------  -->
 
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body class="fixed-top" data-new-gr-c-s-check-loaded="14.996.0" data-gr-ext-installed="" cz-shortcut-listen="true">

<!-- BEGIN HEADER -->
<!--#include file="inc_header.html"-->
<!-- END HEADER -->
 <!-- BEGIN CONTAINER -->
<div id="container" class="row-fluid blueclr">
  <!-- BEGIN SIDEBAR -->
  <!--#include file="inc_sidemenu.html"-->
  <!-- END SIDEBAR -->
     
    
  <!--<div class="hppop_bg"></div>-->
  <!--<div class="hppop">
  <div class="hppop_pic"><a href="#" target="_self"><img src="bg.png"  alt="" border="0"></a>
  <img src="offer.gif" style="margin-left:66.5%; margin-top:-48.9%; width:196px; position:absolute" />
  </div>
	
    
</div>-->
    
    
    <!-- BEGIN PAGE -->
    <div id="main-content">
      <!-- BEGIN PAGE CONTAINER-->
      <div class="container-fluid">
        <!-- BEGIN PAGE HEADER-->
        <div class="row-fluid">
          <div class="span12">
            <!-- BEGIN THEME CUSTOMIZER-->
            <!-- END THEME CUSTOMIZER-->
            <!-- BEGIN PAGE TITLE & BREADCRUMB-->
            <h3 class="page-title"> Dashboard </h3>
            <ul class="breadcrumb">
              <li><a href="#"><i class="icon-home"></i></a><span class="divider">&nbsp;</span> </li>
              <li><a href="#">Dashboard</a><span class="divider-last">&nbsp;</span></li>
            </ul>
            <!-- END PAGE TITLE & BREADCRUMB-->
          </div>
        </div>
        <!--<div id="ctl00_ContentPlaceHolder1_Div2" class="alert alert-info">
                <b>
            <span id="ctl00_ContentPlaceHolder1_Label2">Limited period special offer to activate/upgrade on purchasing of 'Impact Garments combo Rs.3500/- with 5100BV'</span></b></div>-->
                 
        <div class="row-fluid panelpart">
          <div class="span12">
          
             <div class="span3">
                <div class="small-box bg-aqua">
                <div class="inner">
                  <h3> <span id="ctl00_ContentPlaceHolder1_lblTotalMember">3</span></h3>
                  <p>Direct Member </p>
                  <div class="progress my-3" style="height: 3px;">
                    <div class="progress-bar" style="width: 55%"></div>
                  </div>
                </div>
                <div class="icon"> <i class="icon-user" aria-hidden="true"></i> </div>
              </div>
             </div>
              
             <div class="span3"> 
             
              <div class="small-box bg-greena">
                <div class="inner two">
                  <h3> <span id="ctl00_ContentPlaceHolder1_lblTodayMember">1852</span> </h3>
                  <p>Team Member</p>
                  <div class="progress my-3" style="height: 3px;">
                    <div class="progress-bar" style="width: 55%"></div>
                  </div>
                </div>
                <div class="icon"> <i class="fa fa-users" aria-hidden="true"></i> </div>
              </div>
                </div>
             <div class="span3">  
             
              <div class="small-box bg-sds">
                <div class="inner">
                  <h3> <span id="ctl00_ContentPlaceHolder1_lblmessage">0</span> </h3>
                  <p>Total Member</p>
                  <div class="progress my-3" style="height: 3px;">
                    <div class="progress-bar" style="width: 55%"></div>
                  </div>
                </div>
                <div class="icon"> <i class="fa fa-envelope" aria-hidden="true"></i> </div>
              </div>
             </div>
             <div class="span3">
             
              <div class="small-box bg-aquas4">
                <div class="inner">
                  <h3> <span id="ctl00_ContentPlaceHolder1_lbltotalincome">1080.00</span></h3>
                  <p>Total Income</p>
                  <div class="progress my-3" style="height: 3px;">
                    <div class="progress-bar" style="width: 55%"></div>
                  </div>
                  <div class="icon"> <i class="fa fa-calculator"></i> </div>
                </div>
              </div>
             </div>
             
             
             <!--<div class="span3">
               <div class="small-box bg-aquas3">
                <div class="inner">
                  <h3> <span id="ctl00_ContentPlaceHolder1_lblWithdraw">0.00</span></h3>
                  <p>Total Withdraw</p>
                  <div class="progress my-3" style="height: 3px;">
                    <div class="progress-bar" style="width: 55%"></div>
                  </div>
                  <div class="icon"> <i class="fa fa-money" aria-hidden="true"></i> </div>
                </div>
              </div>
             </div> -->
            
             <div class="span2">
             
             <!-- <div class="small-box bg-aqua2">
                <div class="inner">
                  <h3> <span id="ctl00_ContentPlaceHolder1_lblnetincome">68.00</span></h3>
                  <p> Net Income</p>
                  <div class="progress my-3" style="height: 3px;">
                    <div class="progress-bar" style="width: 55%"></div>
                  </div>
                  <div class="icon"> <i class="icon-bar-chart" aria-hidden="true"></i> </div>
                </div>
              </div> -->
              <div class="span2" style="display:none;"> <a href="#">
                <!-- small box -->
                <div class="small-box bg-sdsa">
                  <div class="inner">
                    <h3> <span id="ctl00_ContentPlaceHolder1_lblKycstatus">NO Kyc</span></h3>
                    <p>member</p>
                    <div class="progress my-3" style="height: 3px;">
                      <div class="progress-bar" style="width: 55%"></div>
                    </div>
                  </div>
                  <div class="icon"> <i class="fa fa-user-plus" aria-hidden="true"></i> </div>
                </div>
                </a> </div>
            </div>
          </div>
          <div class="row-fluid panelpart" style="display:none;">
            <div class="span12">
              <div class="span3" style="display: none;">
                <!-- small box -->
                <div class="small-box bg-sds">
                  <div class="inner">
                    <h3> <span id="ctl00_ContentPlaceHolder1_Label3"></span> <span id="ctl00_ContentPlaceHolder1_Label4"></span> &nbsp;INR</h3>
                    <p>Total Income</p>
                  </div>
                  <div class="icon"> <i class="fa fa-user-plus" aria-hidden="true"></i> </div>
                  <a href="#" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a> </div>
              </div>
              <div class="span3" style="display: none;">
                <!-- small box -->
                <div class="small-box bg-sds">
                  <div class="inner">
                    <h3>&nbsp;INR</h3>
                    <p>Total Income</p>
                  </div>
                  <div class="icon"> <i class="fa fa-user-plus" aria-hidden="true"></i> </div>
                  <a href="#" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a> </div>
              </div>
            </div>
          </div>
          <div class="row" style="margin-bottom: 0em;">
            <div class="span12">
              
              <div class="span2 packeviti">
                 <div class="box box-widget widget-user-2 box2">
                  <!-- Add the bg color to the header using any of the bg-* classes -->
                   <div class="widget-user-header bg-aqua" style="background:#97b85d!important;">
                    <div class="widget-user-image"> <i class="fa fa-user" aria-hidden="true" style="font-size: 60px; color: rgb(247, 247, 248); background: #2f90d9; padding: 10px 20px; position: absolute; top: -41px; left: 38%; border-radius: 50%; border: 2px solid rgba(48, 95, 182, 0.14); opacity: .8;"></i> </div>
                    <!-- /.widget-user-image -->
                    <h3 class="widget-user-username headd">Total Withdraw </h3>
                  </div>
                   <div class="widgetleftright barset">
                    <div class="span12">
                      <div class="description-block">
                        <h5 class="description-header"><span id=""> <span id="ctl00_ContentPlaceHolder1_lblreturnhelp">157500.00</span> </span></h5>
                       <!-- <span class="description-text">TOTAL</span> --> </div>
                      <!-- /.description-block -->
                    </div>
                  </div>
                </div>
              </div>
              
              
               <div class="span2 packeviti">
                 <div class="box box-widget widget-user-2 box2">
                  <!-- Add the bg color to the header using any of the bg-* classes -->
                   <div class="widget-user-header bg-aqua" style="background:#97b85d!important;">
                    <div class="widget-user-image"> <i class="fa fa-user" aria-hidden="true" style="font-size: 60px; color: rgb(247, 247, 248); background: #2f90d9; padding: 10px 20px; position: absolute; top: -41px; left: 38%; border-radius: 50%; border: 2px solid rgba(48, 95, 182, 0.14); opacity: .8;"></i> </div>
                    <!-- /.widget-user-image -->
                    <h3 class="widget-user-username headd">Referral Income</h3>
                  </div>
                   <div class="widgetleftright barset">
                    <div class="span12">
                      <div class="description-block">
                        <h5 class="description-header"><span id=""> <span id="ctl00_ContentPlaceHolder1_lblreturnhelp">40600.00</span> </span></h5>
                       <!-- <span class="description-text">TOTAL</span> --> </div>
                      <!-- /.description-block -->
                    </div>
                  </div>
                </div>
              </div>
              
              
              
              <div class="span2 packeviti">
                 <div class="box box-widget widget-user-2 box2">
                  <!-- Add the bg color to the header using any of the bg-* classes -->
                   <div class="widget-user-header bg-aqua" style="background:#97b85d!important;">
                    <div class="widget-user-image"> <i class="fa fa-user" aria-hidden="true" style="font-size: 60px; color: rgb(247, 247, 248); background: #2f90d9; padding: 10px 20px; position: absolute; top: -41px; left: 38%; border-radius: 50%; border: 2px solid rgba(48, 95, 182, 0.14); opacity: .8;"></i> </div>
                    <!-- /.widget-user-image -->
                    <h3 class="widget-user-username headd">Level Income</h3>
                  </div>
                   <div class="widgetleftright barset">
                    <div class="span12">
                      <div class="description-block">
                        <h5 class="description-header"><span id=""> <span id="ctl00_ContentPlaceHolder1_lblreturnhelp">120940.00</span> </span></h5>
                       <!-- <span class="description-text">TOTAL</span> --> </div>
                      <!-- /.description-block -->
                    </div>
                  </div>
                </div>
              </div>
               
              <div class="span2 packeviti">
                 <div class="box box-widget widget-user-2 box2">
                  <!-- Add the bg color to the header using any of the bg-* classes -->
                   <div class="widget-user-header bg-aqua" style="background:#97b85d!important;">
                    <div class="widget-user-image"> <i class="fa fa-user" aria-hidden="true" style="font-size: 60px; color: rgb(247, 247, 248); background: #2f90d9; padding: 10px 20px; position: absolute; top: -41px; left: 38%; border-radius: 50%; border: 2px solid rgba(48, 95, 182, 0.14); opacity: .8;"></i> </div>
                    <!-- /.widget-user-image -->
                    <h3 class="widget-user-username headd">Repurchase Income</h3>
                  </div>
                   <div class="widgetleftright barset">
                    <div class="span12">
                      <div class="description-block">
                        <h5 class="description-header"><span id=""> <span id="ctl00_ContentPlaceHolder1_lblreturnhelp">0.00</span> </span></h5>
                       <!-- <span class="description-text">TOTAL</span> --> </div>
                      <!-- /.description-block -->
                    </div>
                  </div>
                </div>
              </div>
              
              <div class="span2 packeviti">
                 <div class="box box-widget widget-user-2 box2">
                  <!-- Add the bg color to the header using any of the bg-* classes -->
                   <div class="widget-user-header bg-aqua" style="background:#97b85d!important;">
                    <div class="widget-user-image"> <i class="fa fa-user" aria-hidden="true" style="font-size: 60px; color: rgb(247, 247, 248); background: #2f90d9; padding: 10px 20px; position: absolute; top: -41px; left: 38%; border-radius: 50%; border: 2px solid rgba(48, 95, 182, 0.14); opacity: .8;"></i> </div>
                    <!-- /.widget-user-image -->
                    <h3 class="widget-user-username headd">Reward Income</h3>
                  </div>
                   <div class="widgetleftright barset">
                    <div class="span12">
                      <div class="description-block">
                        <h5 class="description-header"><span id=""> <span id="ctl00_ContentPlaceHolder1_lblreturnhelp">0.00</span> </span></h5>
                       <!-- <span class="description-text">TOTAL</span> --> </div>
                      <!-- /.description-block -->
                    </div>
                  </div>
                </div>
              </div>
              
              <div class="span2 packeviti">
                 <div class="box box-widget widget-user-2 box2">
                  <!-- Add the bg color to the header using any of the bg-* classes -->
                   <div class="widget-user-header bg-aqua" style="background:#97b85d!important;">
                    <div class="widget-user-image"> <i class="fa fa-user" aria-hidden="true" style="font-size: 60px; color: rgb(247, 247, 248); background: #2f90d9; padding: 10px 20px; position: absolute; top: -41px; left: 38%; border-radius: 50%; border: 2px solid rgba(48, 95, 182, 0.14); opacity: .8;"></i> </div>
                    <!-- /.widget-user-image -->
                    <h3 class="widget-user-username headd">Royalty Income</h3>
                  </div>
                   <div class="widgetleftright barset">
                    <div class="span12">
                      <div class="description-block">
                        <h5 class="description-header"><span id=""> <span id="ctl00_ContentPlaceHolder1_lblreturnhelp">0.00</span> </span></h5>
                       <!-- <span class="description-text">TOTAL</span> --> </div>
                      <!-- /.description-block -->
                    </div>
                  </div>
                </div>
              </div>
              
              
              
              
             	<!-- <div class="span3 packeviti">
                 <div class="box box-widget widget-user-2 box2">
                   <a href="#">
                  <div class="widget-user-header bg-aqua" style="background:#97b85d!important;">
                    <div class="widget-user-image"> <i class="fa fa-user" aria-hidden="true" style="font-size: 60px; color: rgb(247, 247, 248); background: #2f90d9; padding: 10px 20px; position: absolute; top: -41px; left: 38%; border-radius: 50%; border: 2px solid rgba(48, 95, 182, 0.14); opacity: .8;"></i> </div>
                     <h3 class="widget-user-username headd">Total PV</h3>
                  </div>
                  </a>
                  <div class="widgetleftright barset">
                    <div class="span4 border-right">
                      <div class="description-block">
                        <h5 class="description-header"><span id=""> <span id="ctl00_ContentPlaceHolder1_LPVT">0000.00</span> </span></h5>
                        <span class="description-text">Left</span> </div>
                     </div>
                    <div class="span4 border-right">
                      <div class="description-block">
                        <h5 class="description-header"><span id=""> <span id="ctl00_ContentPlaceHolder1_RPVT">0000.00</span></span></h5>
                        <span class="description-text">Right</span> </div>
                    </div>
                    <div class="span4">
                      <div class="description-block">
                        <h5 class="description-header"><span id=""> <span id="ctl00_ContentPlaceHolder1_totalPV">0000.00</span> </span></h5>
                        <span class="description-text">TOTAL</span> </div>
                     </div>
                  </div>
                </div>
               </div> -->
              
               
              
               
              
            </div>
          </div>
 
          <div class="row" style="margin-bottom: 0em;">
            <div class="span12">
              <div class="span4 packeviti">
                <!-- Widget: user widget style 1 -->
                <div class="box box-widget widget-user-2"> <a href="#">
                  <!-- Add the bg color to the header using any of the bg-* classes -->
                  <div class="widget-user-header bg-green gradientclr">
                    <div class="widget-user-image"> <i class="fa fa-gift" aria-hidden="true"></i> </div>
                    <!-- /.widget-user-image -->
                    <h3 class="widget-user-username">Main Wallet</h3>
                  </div>
                  </a>
                  <div class="widgetleftright barset">
                    <div class="span4 border-right">
                      <div class="description-block">
                        <h5 class="description-header"><span id="ctl00_ContentPlaceHolder1_lblleftgroup"> <span id="ctl00_ContentPlaceHolder1_lblleftgroup">00</span> </span></h5>
                        <span class="description-text">Credit</span> </div>
                      <!-- /.description-block -->
                    </div>
                    <div class="span4 border-right">
                      <div class="description-block">
                        <h5 class="description-header"><span id="ctl00_ContentPlaceHolder1_lblrightgroup"> <span id="ctl00_ContentPlaceHolder1_lblrightgroup">00</span></span></h5>
                        <span class="description-text">Debit </span> </div>
                      <!-- /.description-block -->
                    </div>
                    <div class="span4">
                      <div class="description-block">
                        <h5 class="description-header"><span id="ctl00_ContentPlaceHolder1_lbltotalgroup"> <span id="ctl00_ContentPlaceHolder1_lbltotalgroup">00</span></span></h5>
                        <span class="description-text">Balance</span> </div>
                      <!-- /.description-block -->
                    </div>
                  </div>
                </div>
                <!-- /.widget-user -->
              </div>
              <div class="span4 packeviti">
                <!-- Widget: user widget style 1 -->
                <div class="box box-widget widget-user-2">
                  <!-- Add the bg color to the header using any of the bg-* classes -->
                  <a href="#">
                  <div class="widget-user-header bg-aqua gradientclr">
                    <div class="widget-user-image"> <i class="fa fa-user" aria-hidden="true" style="font-size: 60px; color: rgb(247, 247, 248); background: #2f90d9; padding: 10px 20px; position: absolute; top: -41px; left: 38%; border-radius: 50%; border: 2px solid rgba(48, 95, 182, 0.14); opacity: .8;"></i> </div>
                    <!-- /.widget-user-image -->
                    <h3 class="widget-user-username">Shopping Wallet</h3>
                  </div>
                  </a>
                  <div class="widgetleftright barset">
                    <div class="span4 border-right">
                      <div class="description-block">
                        <h5 class="description-header"><span id="ctl00_ContentPlaceHolder1_lblleftgroup"> <span id="ctl00_ContentPlaceHolder1_lblleftgroup">00</span> </span></h5>
                        <span class="description-text">Credit</span> </div>
                      <!-- /.description-block -->
                    </div>
                    <div class="span4 border-right">
                      <div class="description-block">
                        <h5 class="description-header"><span id="ctl00_ContentPlaceHolder1_lblrightgroup"> <span id="ctl00_ContentPlaceHolder1_lblrightgroup">00</span></span></h5>
                        <span class="description-text">Debit </span> </div>
                      <!-- /.description-block -->
                    </div>
                    <div class="span4">
                      <div class="description-block">
                        <h5 class="description-header"><span id="ctl00_ContentPlaceHolder1_lbltotalgroup"> <span id="ctl00_ContentPlaceHolder1_lbltotalgroup">00</span></span></h5>
                        <span class="description-text">Balance</span> </div>
                      <!-- /.description-block -->
                    </div>
                  </div>
                </div>
                <!-- /.widget-user -->
              </div>
              <div class="span4 packeviti">
                <!-- Widget: user widget style 1 -->
                <div class="box box-widget widget-user-2">
                  <!-- Add the bg color to the header using any of the bg-* classes -->
                  <a href="#">
                  <div class="widget-user-header bg-aqua gradientclr">
                    <div class="widget-user-image"> <i class="fa fa-users" aria-hidden="true" style="font-size: 60px; color: rgb(247, 247, 248); background: #4f9030; padding: 10px 9px; position: absolute; top: -41px; left: 34%; border-radius: 50%; border: 2px solid rgba(48, 95, 182, 0.14); opacity: .8;"></i> </div>
                    <!-- /.widget-user-image -->
                    <h3 class="widget-user-username">Repurchase Wallet</h3>
                  </div>
                  </a>
                  <div class="widgetleftright barset">
                    <div class="span4 border-right">
                      <div class="description-block">
                        <h5 class="description-header"><span id="ctl00_ContentPlaceHolder1_lblleftgroup"> <span id="ctl00_ContentPlaceHolder1_lblleftgroup">00</span> </span></h5>
                        <span class="description-text">Credit</span> </div>
                      <!-- /.description-block -->
                    </div>
                    <div class="span4 border-right">
                      <div class="description-block">
                        <h5 class="description-header"><span id="ctl00_ContentPlaceHolder1_lblrightgroup"> <span id="ctl00_ContentPlaceHolder1_lblrightgroup">00</span></span></h5>
                        <span class="description-text">Debit </span> </div>
                      <!-- /.description-block -->
                    </div>
                    <div class="span4">
                      <div class="description-block">
                        <h5 class="description-header"><span id="ctl00_ContentPlaceHolder1_lbltotalgroup"> <span id="ctl00_ContentPlaceHolder1_lbltotalgroup">00</span></span></h5>
                        <span class="description-text">Balance</span> </div>
                      <!-- /.description-block -->
                    </div>
                  </div>
                </div>
                <!-- /.widget-user -->
              </div>
              <div class="span3 packeviti" style="display:none;">
                <!-- Widget: user widget style 1 -->
                <div class="box box-widget widget-user-2">
                  <!-- Add the bg color to the header using any of the bg-* classes -->
                  <a href="#">
                  <div class="widget-user-header bg-aqua" style="background: linear-gradient(50deg,#b31615,#df0f0d)!important;">
                    <div class="widget-user-image"> <i class="fa fa-users" aria-hidden="true" style="font-size: 60px; color: rgb(247, 247, 248); background: #c31413; padding: 10px 9px; position: absolute; top: -41px; left: 34%; border-radius: 50%; border: 2px solid rgba(48, 95, 182, 0.14); opacity: .8;"></i> </div>
                    <!-- /.widget-user-image -->
                    <h3 class="widget-user-username">Level Member Status</h3>
                  </div>
                  </a>
                  <div class="widgetleftright barset">
                    <div class="span4 border-right">
                      <div class="description-block">
                        <h5 class="description-header"><span id="ctl00_ContentPlaceHolder1_lblleftgroup"> <span id="ctl00_ContentPlaceHolder1_lbllevelmem">0</span> </span></h5>
                        <span class="description-text">Level</span> </div>
                      <!-- /.description-block -->
                    </div>
                    <div class="span4 border-right">
                      <div class="description-block">
                        <h5 class="description-header"><span id="ctl00_ContentPlaceHolder1_lblrightgroup"> <span id="ctl00_ContentPlaceHolder1_lblpercentage">0</span></span></h5>
                        <span class="description-text">%</span> </div>
                      <!-- /.description-block -->
                    </div>
                    <div class="span4">
                      <div class="description-block">
                        <h5 class="description-header"><span id="ctl00_ContentPlaceHolder1_lbltotalgroup"> <span id="ctl00_ContentPlaceHolder1_Label5"></span></span></h5>
                        <span class="description-text"></span> </div>
                      <!-- /.description-block -->
                    </div>
                  </div>
                </div>
                <!-- /.widget-user -->
              </div>
            </div>
          </div>
          
          <div class="row-fluid panelpart">          
           <div class="span12 packeviti">
                 <div class="box box-widget widget-user-2">
                  <!-- Add the bg color to the header using any of the bg-* classes -->
                  
                  <div class="widget-user-header bg-aqua gradientclr">
                    <div class="widget-user-image"> <i class="fa fa-user" aria-hidden="true" style="font-size: 60px; color: rgb(247, 247, 248); background: #2f90d9; padding: 10px 20px; position: absolute; top: -41px; left: 38%; border-radius: 50%; border: 2px solid rgba(48, 95, 182, 0.14); opacity: .8;"></i> </div>
                     <h3 class="widget-user-username">Triple Seven : Referral Link </h3>
                  </div>
                  
                  <div class="widgetleftright barset">
                  <div class="span8 border-right">
                  <div class="description-block">
                  <h5 class="description-header"><span id="ctl00_ContentPlaceHolder1_lblleftgroup"> https://tripleseven.life/Newjoining1.aspx?ref=UEAbJ/MQ/C/9rgHMhOD2dA==  </span></h5>
                  </div>
                  </div>
                  <div class="span4 border-right">
                  <div class="description-block">
                  <h5 class="description-header">
                  <span id="ctl00_ContentPlaceHolder1_lblrightgroup">
                  <span id="ctl00_ContentPlaceHolder1_lblrightgroup"><button type="button" class="btn btn-danger">Copy URL</button> </span>
                  </span>
                  </h5>
                  </div>
                  </div>   
                  </div>
           </div>
              
           </div>
           
           
           <div class="clearfix"></div>
              
              
              
              
          <div class="row-fluid panelpart">
            <div class="span12">
              <div id="ctl00_ContentPlaceHolder1_Distributor1_TbBoard">
                <div class="row-fluid">
                  <div class="span12">
                    <div class="widget">
                      <div class="widget-title">
                        <h4> <i class="icon-user"></i>Distributor Details</h4>
                        <span class="tools"><a href="javascript:;" class="icon-chevron-down"></a></span> </div>
                      <div class="widget-body">
                        <div class="row-fluid"> <span class="span12">
                          <table class="table table-striped table-bordered table-advance table-hover">
                            <tbody>
                              <tr>
                                <td width="15%"><strong>Username / User Id</strong> </td>
                                <td width="35%"><span id="ctl00_ContentPlaceHolder1_Distributor1_lbl_userid"> BHILWARA</span> / <span id="ctl00_ContentPlaceHolder1_Distributor1_lblusername">00112233</span> </td>
                                <td width="15%"><strong> Name</strong> </td>
                                <td width="35%"><span id="ctl00_ContentPlaceHolder1_Distributor1_lbl_usrename"> Rohit Kumar Sahu</span> </td>
                              </tr>
                              <tr>
                                <td><strong>Date of Joining </strong> </td>
                                <td><span id="ctl00_ContentPlaceHolder1_Distributor1_lbl_doj">09/05/2020</span> </td>
                                <td><strong>Designation </strong> </td>
                                <td><span id="ctl00_ContentPlaceHolder1_Distributor1_lbl_designation">Distributor</span> </td>
                              </tr>
                              <tr>
                                <td><strong>Sponsor Username</strong> </td>
                                <td><span id="ctl00_ContentPlaceHolder1_Distributor1_lbl_suserid">N/A</span> </td>
                                <td><strong>Sponsor Name</strong> </td>
                                <td><span id="ctl00_ContentPlaceHolder1_Distributor1_lbl_susername">N/A</span> </td>
                              </tr>
                              <tr>
                                <td><strong>Direct Member</strong> </td>
                                <td><span id="ctl00_ContentPlaceHolder1_Distributor1_lbldirectred">3</span>/<span id="ctl00_ContentPlaceHolder1_Distributor1_lblgreen">3</span> </td>
                                <td></td>
                                <td></td>
                              </tr>
                            </tbody>
                          </table>
                          </span> </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="row-fluid" style="display: none;">
            <div class="span12">
              <div class="widget ">
                <div class="widget-title">
                  <h4> <i class="icon-globe"></i>News</h4>
                  <div class="row-fluid">
                    <div class="span12">
                      <marquee behavior="alternate" onMouseOver="this.stop()" onMouseOut="this.start()" style="background: #7dbc00; font-family: Book Antiqua; color: #FFFFFF" bgcolor="#a20a3a" scrollamount="5">
                      <span id="ctl00_ContentPlaceHolder1_lblmarquee" style="color:White;font-size:Medium;"><span> <span id="ctl00_ContentPlaceHolder1_lblannocument">Announcement</span></span></span>
                      </marquee>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="row-fluid circle-state-overview hidden-phone" style="display: none;">
            <div class="span4 responsive clearfix" data-tablet="span3" data-desktop="span4">
              <div class="circle-wrap">
                <div class="stats-circle turquoise-color"> <i class="icon-group"></i> </div>
                <p> <strong></strong>Total Sponsor </p>
              </div>
            </div>
            <div class="span4 responsive" data-tablet="span3" data-desktop="span4">
              <div class="circle-wrap">
                <div class="stats-circle red-color"> <i class="icon-user"></i> </div>
                <p> <strong></strong> Total Team Size </p>
              </div>
            </div>
            <div class="span4 responsive" data-tablet="span3" data-desktop="span4">
              <div class="circle-wrap">
                <div class="stats-circle green-color"> <i class="icon-bar-chart"></i> </div>
                <p> <strong></strong>Total Income </p>
              </div>
            </div>
          </div>
          <!-- END OVERVIEW STATISTIC -->
          <!--BEGIN AutoShip NOTIFICATION-->
          <!--END AutoShip NOTIFICATION-->
          <!-- BEGIN OVERVIEW STATISTIC FOR MOBILE-->
          <div class="row-fluid" style="display: none;">
            <div class="span12">
              <table class="table" style="display: none;">
                <tbody>
                  <tr>
                    <td><div class="stats-circle turquoise-color"> <i class="icon-group"></i> </div>
                      <p> <strong> <span id="ctl00_ContentPlaceHolder1_lblTotal">3</span> </strong> <br>
                        Total Sponser Member </p></td>
                    <td><div class="stats-circle red-color"> <i class="icon-user"></i> </div>
                      <p> <strong> <span id="ctl00_ContentPlaceHolder1_lblToday">1852</span></strong><br>
                        Total team Size </p></td>
                    <td><div class="stats-circle green-color"> <i class="icon-shopping-cart"></i> </div>
                      <p> <strong> <span id="ctl00_ContentPlaceHolder1_lblTotalLiveBoardM">+80</span> &nbsp;INR </strong> <br>
                        Total Income </p></td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
          <!-- END OVERVIEW STATISTIC FOR MOBILE-->
          <!-- RECENT MEMBER LIST AND BOARD DETAILS -->
          <div class="row-fluid">
            <!--- RECENT MEMBER LIST ENDS -->
            <div class="span6">
              <div class="widget">
                <div class="widget-title">
                  <h4> <i class="icon-list-ol"></i>Sponsor Members</h4>
                  <span class="tools"><a href="javascript:;" class="icon-chevron-down"></a></span> </div>
                <div class="widget-body">
                  <table class="table table-striped table-bordered table-advance table-hover">
                    <thead>
                      <tr>
                        <th> <i class="icon-list"></i> </th>
                        <th> <i class="icon-user"></i>User Name </th>
                        <th> <i class="icon-user-md"></i>Name </th>
                        <th> <i class="icon-tags"></i>Date </th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr>
                        <td> 1 </td>
                        <td> 00000 </td>
                        <td> Sample Text here.. </td>
                        <td> 27-02-2021 </td>
                      </tr>
                      <tr>
                        <td> 2 </td>
                        <td> 00000 </td>
                        <td> Sample Text here.. </td>
                        <td> 27-02-2021 </td>
                      </tr>
                      <tr>
                        <td> 3 </td>
                        <td> 00000 </td>
                        <td> Sample Text here.. </td>
                        <td> 27-02-2021 </td>
                      </tr>
                    </tbody>
                  </table>
                  <div class="space7"> </div>
                  <div class="clearfix"> <a href="#" class="btn btn-mini pull-right">More</a> </div>
                </div>
              </div>
            </div>
            <!--- RECENT MEMBER LIST ENDS -->
            <!-- BOARD ACHIEVERS-->
            <div class="span6 column sortable">
              <div class="widget">
                <div class="widget-title">
                  <h4> <i class="fa fa-envelope"></i>Latest News</h4>
                  <span class="tools"><a href="javascript:;" class="icon-chevron-down"></a></span> </div>
                <div class="widget-body">
                
	               <marquee direction="up" scrollamount="3" style="height:165px;">                   
                   <h4>Triple Seven News Heading  </h4>
                   <p>The soul objective of Triple Seven foundation is to enhance the life experience for us all. Triple seven is backed by actual professionals with more than two decades of business and development experience.</p>
                   <hr>
                   <h4>Triple Seven News Heading  </h4>
                   <p>The soul objective of Triple Seven foundation is to enhance the life experience for us all. Triple seven is backed by actual professionals with more than two decades of business and development experience.</p>
                   </marquee>
                   
                  <div class="space7"> </div>
                  <div class="clearfix">   </div>
                </div>
              </div>
            </div>
            <!-- END BOARD ACHIEVERS -->
          </div>
          <div class="row-fluid" style="display: none;">
            <div class="span12">
              <div class="widget">
                <div class="widget-title">
                  <h4> <i class="icon-external-link"></i>Top Achievers</h4>
                  <span class="tools"><a href="javascript:;" class="icon-chevron-down"></a></span> </div>
                <div class="widget-body">
                  <div class="space7"> </div>
                  <div class="clearfix"> <a href="#" class="btn btn-mini pull-right">More</a> </div>
                </div>
              </div>
            </div>
          </div>
          <!-- END RECENT MEMBER AND BOARD DETAILS -->
          <!-- GENERAL CONTENT -->
          <div class="row-fluid" style="display: none;">
            <div class="span12">
              <div class="widget ">
                <div class="widget-title">
                  <h4> <i class="icon-globe"></i>Announcement</h4>
                  <span class="tools"><a href="javascript:;" class="icon-chevron-down"></a>
                  <!--<a href="javascript:;" class="icon-remove"></a>-->
                  </span> </div>
              
              </div>
            </div>
          </div>
          <!-- END GENERAL CONTENT -->
          <!-- END PAGE CONTENT-->
        </div>
        <!-- END PAGE CONTAINER-->
      </div>
      <!-- END PAGE -->
    </div>
    <script type="text/jsfile/javascript" src="assets/jsfile/jquery.gritter.js"></script>
    <script src="assets/jsfile/scripts.js"></script>
    
     
 </div>
<!-- END CONTAINER -->
<!-- BEGIN FOOTER -->
<div id="footer">  © 2021 | Triple Seven  
  <div class="span pull-right"> <span class="go-top"><i class="icon-arrow-up"></i></span> </div>
</div>
<!-- END FOOTER -->
<!-- END BODY -->



 
<div id="GOOGLE_INPUT_CHEXT_FLAG" input="" input_stat="{&quot;tlang&quot;:true,&quot;tsbc&quot;:true,&quot;pun&quot;:true,&quot;mk&quot;:true,&quot;ss&quot;:true}" style="display: none;"></div>
</body>
</html>
