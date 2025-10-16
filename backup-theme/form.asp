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
<link href="assets/cssfile/style_responsive.css" rel="stylesheet">
<link id="ctl00_style_color" href="assets/cssfile/style_navy-blue.css" rel="stylesheet">
<link rel="stylesheet" href="assets/cssfile/font-awesome.min.css">
<link href="assets/cssfile/jquery.fancybox.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="assets/cssfile/uniform.default.css">
<link rel="stylesheet" type="text/css" href="assets/cssfile/jquery.gritter.css">
<link rel="stylesheet" href="assets/cssfile/font-awesome.min.css">
<link href="assets/css" rel="stylesheet">
<link href="assets/css(1)" rel="stylesheet">
<link href="assets/cssfile/added_css_rohit.css" rel="stylesheet">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">


<!-- -------------------- End CSS Files --------------------  -->

<!-- -------------------- Start JS Files --------------------  -->

<script src="assets/jsfile/jquery.dataTables.min.js" type="text/javascript"></script>
<!-- BEGIN JAVASCRIPTS -->
<!-- Load javascripts at bottom, this will reduce page load time -->
<script src="assets/jsfile/jquery-1.8.3.min.js"></script>
<script src="assets/jsfile/bootstrap.min.js"></script>
<script src="assets/jsfile/jquery.blockui.js"></script>
<script src="assets/jsfile/progress.js"></script>
<script src="assets/jsfile/jquery-2.0.3.js"></script>
<script src="assets/jsfile/SearchJScript.js" type="text/javascript"></script>
<script type="text/javascript">
        function dothis() {
            alert('You can not request e-Pin, first purchasing/retailing a package !');
        }
        function dothis1() {
            alert('You activation request is pending !');
        }     
    </script>
    
 
<script src="assets/jsfile/scripts.js"></script>
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
  <form name="aspnetForm" method="post" action="#" id="aspnetForm">
    <div>
      <input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE" value="#">
    </div>
    <div>
      <input type="hidden" name="__VIEWSTATEGENERATOR" id="__VIEWSTATEGENERATOR" value="D95A9C4B">
      <input type="hidden" name="__EVENTVALIDATION" id="__EVENTVALIDATION" value="/wEdAASSIk2+24wqgSltBm5OohXTua693jsrQxraiSZwRFBJYcKj7me18Lu1iF+8m/4yDoUcxc1UjF+KP1iO0rNd/6XsTCNQYJYqWG5Wt7a9ct8MTeRA5siJUBU20MdxwjdkwDk=">
    </div>
    <!--<div class="hppop_bg"></div>-->
    <!--<div class="hppop">
	<div class="hppop_pic"><a href="#" target="_self"><img src="bg.png"  alt="" border="0"></a>
      <img src="offer.gif" style="margin-left:66.5%; margin-top:-48.9%; width:196px; position:absolute" />
    </div>
	
    
</div>-->
    <link rel="stylesheet" href="assets/font-awesome.min.css">
    
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
         
        <div>
        
              <div class="row-fluid panelpart">
              <div class="row">
              <div class="span12"><p> Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, </p> </div>
              </div>
               
              <div class="clearfix"></div>
              <p>&nbsp;</p>
              <hr>
              <div class="row-fluid panelpart">
               
              <div class="row">
                
              <div class="span12"> 
                 
                <div class="widget">
                        <div class="widget-title">
                            <h4><i class="icon-credit-card"></i>e-Pin details</h4>
                             <span class="tools">
                                <a href="javascript:;" class="icon-chevron-down"></a>
                            </span>
                        </div>
                        <div class="widget-body" style="display: ">
                            <div class="form-horizontal">
                                <div style="margin-bottom: 30px;">
                                    <span id="ctl00_ContentPlaceHolder1_lblMsg" style="color:#C00000;"></span>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">Name</label>
                                    <div class="controls">
                                        <input name="ctl00$ContentPlaceHolder1$lbldisname" type="text" value="Mr. Click Trade" id="ctl00_ContentPlaceHolder1_lbldisname" disabled="disabled" class="input-xlarge">
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">Select Package Code</label>
                                    <div class="controls">
                                        <select name="ctl00$ContentPlaceHolder1$dropdownpackage" onChange="javascript:setTimeout('__doPostBack(\'ctl00$ContentPlaceHolder1$dropdownpackage\',\'\')', 0)" id="ctl00_ContentPlaceHolder1_dropdownpackage" class="input-xlarge">
	<option value="--Select Kit Code--">--Select Kit Code--</option>
	<option value="1">Package 01</option>
	<option value="2">Package 02</option>
	<option selected="selected" value="3">HFCA001</option>
	<option value="4">1122334455</option>
	<option value="6">A</option>
	<option value="10">Huk</option>
	<option value="11">Kit1</option>

</select>
                                       
                                    </div>
                                </div>
                                <div class="control-group" style="display: none;">
                                    <label class="control-label">Package Description</label>
                                    <div class="controls">
                                        <label for="a" id="lblkitdiscription"></label>
                                    </div>
                                </div>
                                <div class="control-group" style="display: none;">
                                    <label class="control-label">Package Price</label>
                                    <div class="controls">
                                        <label for="a" id="epinprice"></label>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">Available e-Pins</label>
                                    <div class="controls">
                                     
                                        <input name="ctl00$ContentPlaceHolder1$maxepin" type="text" id="ctl00_ContentPlaceHolder1_maxepin" disabled="disabled" class="input-xlarge">
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">No. of e-Pins</label>
                                    <div class="controls">
                                        <input name="ctl00$ContentPlaceHolder1$txtEpin" type="text" id="ctl00_ContentPlaceHolder1_txtEpin" class="input-xlarge" onKeyUp="javascript: return enterNumeric(this);">
                                        <span id="ctl00_ContentPlaceHolder1_RequiredFieldValidator1" style="color:Red;visibility:hidden;">*</span>
                                        <span id="ctl00_ContentPlaceHolder1_RangeValidator1" style="color:Red;visibility:hidden;">*</span>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">Enter Username/User id</label>
                                    <div class="controls">
                                        <input name="ctl00$ContentPlaceHolder1$txtloginid" type="text" id="ctl00_ContentPlaceHolder1_txtloginid" class="input-xlarge" onKeyUp="CheckusernameaAvailbilty();" autocomplete="off">
                                        <span id="ctl00_ContentPlaceHolder1_RequiredFieldValidator2" style="color:Red;visibility:hidden;">*</span>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"> Name</label>
                                    <div class="controls">
                                        <input name="ctl00$ContentPlaceHolder1$userFnameLname" type="text" readonly id="ctl00_ContentPlaceHolder1_userFnameLname" disabled="disabled" class="input-xlarge">
                                    </div>

                                </div>
                                <div class="control-group">
                                    <label class="control-label"></label>
                                    <div class="controls">
                                        
                                        <input type="submit" name="ctl00$ContentPlaceHolder1$Button1" value="Transfer" onClick="javascript:WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions(&quot;ctl00$ContentPlaceHolder1$Button1&quot;, &quot;&quot;, true, &quot;g1&quot;, &quot;&quot;, false, false))" id="ctl00_ContentPlaceHolder1_Button1" class="btn btn-success">
                                        <input type="submit" name="ctl00$ContentPlaceHolder1$btncancel" value="Cancel" id="ctl00_ContentPlaceHolder1_btncancel" class="btn btn-danger">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    

				</div>

              </div>
   
               
              <div class="clearfix"></div>
              <p>&nbsp;</p>
              <hr>
              
              
              
              
              
              
              <div class="clearfix"></div>
                        
            
            
            </div>
           
       </div>
      
      
      
      
       
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
      <!-- END PAGE -->
    </div>
    
	<script type="text/jsfile/javascript" src="assets/jquery.gritter.js"></script>
    <script src="assets/scripts.js"></script>
    
     
  </form>
</div>
<!-- END CONTAINER -->
<!-- BEGIN FOOTER -->
<div id="footer"> 2019 ©  Click Trade
  <div class="span pull-right"> <span class="go-top"><i class="icon-arrow-up"></i></span> </div>
</div>
<!-- END FOOTER -->
<!-- END BODY -->
 
 
</body>
</html>
