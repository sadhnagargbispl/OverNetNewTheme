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
<link href="assets/css" rel="stylesheet">
<link href="assets/css(1)" rel="stylesheet">
<link href="assets/cssfile/style_responsive.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="assets/cssfile/added_css_rohit.css" rel="stylesheet">


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
        
         
        
        <div>
        
        
             
              <div class="row-fluid panelpart">
                <div class="row">
                
                <div class="span2"><p> Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, </p> </div>
                <div class="span2"><p> Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, </p> </div>
                <div class="span2"><p> Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, </p> </div>
                <div class="span2"><p> Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, </p> </div>
                <div class="span2"><p> Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, </p> </div>
                <div class="span2"><p> Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, </p> </div>
                  
              </div>
              
             
              
              
              
              <div class="clearfix"></div>
              <p>&nbsp;</p>
              <hr>
              
              
              <div class="row">                
              <div class="span3"> Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae,  </div>
               <div class="span3"> Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae,  </div>
               <div class="span3"> Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae,  </div>                 
               <div class="span3"> Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae,  </div>
              </div>
              
              
              
              <div class="clearfix"></div>
              <p>&nbsp;</p>
              <hr>
              
              
              
              
              <div class="row">                
              <div class="span4"> Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae,  </div>
              
              <div class="span4"> Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae,  </div>
              
              <div class="span4"> Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae,  </div>

              </div>
              
              
              
              <div class="clearfix"></div>
              <p>&nbsp;</p>
              <hr>
              
              
              
              <div class="row">                
              <div class="span6"> Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae,  </div>
              
              <div class="span6"> Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae,  </div>
  
              </div>
              
              
              
              <div class="clearfix"></div>
              <p>&nbsp;</p>
              <hr>
              
              
              
              <div class="row">                
              <div class="span12"> Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae,  Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, </div>
              

              </div>
              
              
              
              <div class="clearfix"></div>
              <p>&nbsp;</p>
              <hr>
              
              
              
               <div class="row">                
              <div class="span12">
                <h1>Heading 1</h1>
	            <h2>Heading 2</h2>
    	        <h3>Heading 3</h3>
        	    <h4>Heading 4</h4>
            	<h5>Heading 5</h5>
	            <h6>Heading 6</h6>
            
            </div> 
            
            
            <div class="clearfix"></div>
              <p>&nbsp;</p>
              <hr>
              
             <div class="row">                
             <div class="span12">
                 <button type="button" class="btn btn-default">Default</button>
                <button type="button" class="btn btn-primary">Primary</button>
                <button type="button" class="btn btn-success">Success</button>
                <button type="button" class="btn btn-info">Info</button>
                <button type="button" class="btn btn-warning">Warning</button>
                <button type="button" class="btn btn-danger">Danger</button>
                <button type="button" class="btn btn-link">Link</button>
                
                <hr>
             
            
            </div> 
            
            </div> 
            
            
            
            
            <div class="clearfix"></div>
              <p>&nbsp;</p>
              <hr>
              
             <div class="row">                
             <div class="span4">
               <div class="btn-group">
              <button type="button" class="btn btn-primary">Apple</button>
              <button type="button" class="btn btn-primary">Samsung</button>
              <button type="button" class="btn btn-primary">Sony</button>
            </div>
            
            </div> 
            
            </div> 
            
            
    
              
             <div class="clearfix"></div>
              <p>&nbsp;</p>
              <hr>
              
             <div class="row">                
             <div class="span12">
             
 

             <table class="table table-bordered ">
            <thead>
              <tr class="bg-info">
                <th>Firstname</th>
                <th>Lastname</th>
                <th>Email</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>John</td>
                <td>Doe</td>
                <td>john@example.com</td>
              </tr>
              <tr>
                <td>Mary</td>
                <td>Moe</td>
                <td>mary@example.com</td>
              </tr>
              <tr>
                <td>July</td>
                <td>Dooley</td>
                <td>july@example.com</td>
              </tr>
            </tbody>
          </table>
             
            </div> 
            
            </div> 
            
            
            
             <div class="clearfix"></div>
              <p>&nbsp;</p>
              <hr>
              
             <div class="row">                
             <div class="span12">
             <table class="table table-bordered">
            <thead>
              <tr>
                <th>Firstname</th>
                <th>Lastname</th>
                <th>Email</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>John</td>
                <td>Doe</td>
                <td>john@example.com</td>
              </tr>
              <tr>
                <td>Mary</td>
                <td>Moe</td>
                <td>mary@example.com</td>
              </tr>
              <tr>
                <td>July</td>
                <td>Dooley</td>
                <td>july@example.com</td>
              </tr>
            </tbody>
          </table>
             
            </div> 
            
            </div> 
            
 
 
            
            
            
            
             <div class="clearfix"></div>
              <p>&nbsp;</p>
              <hr>
              
             <div class="row">                
             <div class="span6">
             <table class="table table-hover table-bordered">
    <thead>
      <tr>
        <th>Firstname</th>
        <th>Lastname</th>
        <th>Email</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>John</td>
        <td>Doe</td>
        <td>john@example.com</td>
      </tr>
      <tr>
        <td>Mary</td>
        <td>Moe</td>
        <td>mary@example.com</td>
      </tr>
      <tr>
        <td>July</td>
        <td>Dooley</td>
        <td>july@example.com</td>
      </tr>
    </tbody>
  </table>
             
            </div> 
            
             <div class="span6">
             <table class="table table-hover table-bordered">
    <thead>
      <tr>
        <th>Firstname</th>
        <th>Lastname</th>
        <th>Email</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>John</td>
        <td>Doe</td>
        <td>john@example.com</td>
      </tr>
      <tr>
        <td>Mary</td>
        <td>Moe</td>
        <td>mary@example.com</td>
      </tr>
      <tr>
        <td>July</td>
        <td>Dooley</td>
        <td>july@example.com</td>
      </tr>
    </tbody>
  </table>
             
            </div> 
            
            </div> 
            
 
                
           
           
             <div class="clearfix"></div>
              <p>&nbsp;</p>
              <hr>
              
             <div class="row">                
             <div class="span12">
              <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">Open Modal Popup </button>

                <!-- Modal Start -->
                <div id="myModal" class="modal fade" role="dialog">
                  <div class="modal-dialog">
                
                     <div class="modal-content">
                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Modal Header</h4>
                      </div>
                      <div class="modal-body">
                        <p>Some text in the modal.</p>
                      </div>
                      <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                      </div>
                    </div>
                
                  </div>
                </div>  
                <!-- Modal End -->
             
            </div> 
            
            </div> 
            
            
            
             
            
            
            
       
            
            
            
            
            
           
            
            
             
            
            
            
            
            

              </div>
              
              
              
            
              
              
              
              
              
              
              
               
             
              
              
              
              
              
              
              
              
            </div>
            
            
            </div>
           
         <!-- END PAGE CONTAINER-->
      </div>
      <!-- END PAGE -->
    </div>
    
	<script type="text/javascript" src="assets/jquery.gritter.js"></script>
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
