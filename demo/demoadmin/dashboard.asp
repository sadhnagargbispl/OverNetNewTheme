<!DOCTYPE html>
<html lang="en">
  
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Welcome to Admin Dashboard</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta name="description">
    <meta name="author">

    <!-- -------------------- Start CSS Files --------------------  -->
    <link href="assets/cssfile/bootstrap.min.css" rel="stylesheet">
    <link href="assets/cssfile/bootstrap-responsive.min.css" rel="stylesheet">
    <link href="assets/cssfile/font-awesome.css" rel="stylesheet">
    <link href="assets/cssfile/style.css?v=1.5" rel="stylesheet">
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

    <script>
        var loginid = null;
        jQuery(document).ready(function () {
            App.init();
            loginid = 'companyid'

        });
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
        function link_changepassword() {
            document.getElementById("btSubmit").disabled = false;
            $('#ErrorDiv_Popup').html("<button data-dismiss='alert' class='close'>Ã—</button> Are You Sure Change Paswssword to this user '<strong>" + ViewstateUsername + "<strong>'  ?");
            $('#ErrorDiv_Popup').removeClass().addClass("alert alert-warning");
            $('#ErrorDiv_Popup').show();
        }

        function changepassword() {
            if ($("span").hasClass("input-error")) {
                $('#ErrorDiv_Popup').html(" <button data-dismiss='alert' class='close'>Ã—</button> * Please  Fill Correct Information. !");
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
                    $('#ErrorDiv_Popup').html("<button data-dismiss='alert' class='close'>Ã—</button> Sorry, There are techinical error please try again. !!");
                    $('#ErrorDiv_Popup').removeClass().addClass("alert alert-error");
                    $('#ErrorDiv_Popup').show();
                    alert("UpdatePasswordMember");
                }
            });
        }
        function updatepasswordSuccess(ResultUpdatePassword) {
            var jsonData = ResultUpdatePassword.d;
            $('#ErrorDiv_Popup').html("<button data-dismiss='alert' class='close'>Ã—</button>  Congratulations,   Your Password Successfully Changed. !!");
            $('#ErrorDiv_Popup').removeClass().addClass("alert alert-success");
            $('#ErrorDiv_Popup').show();
            switch (ResultUpdatePassword.d) {
                case "false":
                    $('#ErrorDiv_Popup').html("<button data-dismiss='alert' class='close'>Ã—</button> Failed, Password Not Changed. !!");
                    $('#ErrorDiv_Popup').removeClass().addClass("alert alert-error");
                    $('#ErrorDiv_Popup').show();
                    break;
                case "true":
                    document.getElementById("btSubmit").disabled = true;
                    $('#ErrorDiv_Popup').html("<button data-dismiss='alert' class='close'>Ã—</button> Congratulations, <strong>" + loginid + "</strong> Your Password Successfully Changed. !!");
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
    
  </head>
  
  <body class="fixed-top" data-new-gr-c-s-check-loaded="14.996.0" data-gr-ext-installed="" cz-shortcut-listen="true">

  
    <!--#include file="inc_header.html"-->
  

  <div id="container" class="row-fluid blueclr">

  
      <!--#include file="inc_sidemenu.html"-->
  
      
    <!-- MAIN CONTENT -->
      <div id="main-content">
      <div class="container-fluid">

        <div class="row-fluid">
            <div class="span12">
                <h5 class="page-title">DASHBOARD </h5>
                <hr>
            </div>
        </div>

        <div class="panelpart">

          <div class="row">
          
          <div class="userprofile">
    <h3>User Profile</h3>

    <div class="user-info">
        <div class="info-item">
            <label>ID No.</label>
            <span>USR-001245</span>
        </div>

        <div class="info-item">
            <label>Name</label>
            <span>Rohit Kumar Sahu</span>
        </div>

        <div class="info-item">
            <label>Date Of Joining</label>
            <span>15-Oct-2025</span>
        </div>

        <div class="info-item">
            <label>Pin Level</label>
            <span>Gold Member</span>
        </div>
    </div>
          </div>

          


         



               

            <div class="row">


              
                
          <div class="span3">
            <div class="small-box bg-aqua" style="border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); transition: transform 0.3s;">
              <div class="inner" style="padding: 11px;">
                <h3 style="font-size: 20px; font-weight: 600; margin-bottom: 5px;">
                  <span style="color: #fff;">₹3,175.00</span>
                </h3>
                <p style="font-size: 15px; color: #fff; text-transform: uppercase; letter-spacing: 1px;">
                  EVEREST INCOME
                </p>
                <div class="progress" style="height: 4px; background: rgba(255,255,255,0.2); border-radius: 2px; margin: 15px 0;">
                  <div class="progress-bar" style="width: 55%; height: 100%; background: #fff; border-radius: 2px;"></div>
                </div>
              </div>
              <div class="icon" style="position: absolute; right: 20px; top: 20px; opacity: 0.3;">
                <i class="icon-user" style="font-size: 48px; color: #fff;" aria-hidden="true"></i>
              </div>
            </div>
          </div>

           <div class="span3">
            <div class="small-box bg-aqua" style="border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); transition: transform 0.3s;">
              <div class="inner" style="padding: 11px;">
                <h3 style="font-size: 20px; font-weight: 600; margin-bottom: 10px;">
                  <span style="color: #fff;">₹196400.00</span>
                </h3>
                <p style="font-size: 15px; color: #fff; text-transform: uppercase; letter-spacing: 1px;">
                 DIRECT SPONSOR INCOME
                </p>
                <div class="progress" style="height: 4px; background: rgba(255,255,255,0.2); border-radius: 2px; margin: 15px 0;">
                  <div class="progress-bar" style="width: 55%; height: 100%; background: #fff; border-radius: 2px;"></div>
                </div>
              </div>
              <div class="icon" style="position: absolute; right: 20px; top: 20px; opacity: 0.3;">
                <i class="icon-user" style="font-size: 48px; color: #fff;" aria-hidden="true"></i>
              </div>
            </div>
          </div>



          <div class="span3">
            <div class="small-box bg-aqua" style="border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); transition: transform 0.3s;">
              <div class="inner" style="padding: 11px;">
                <h3 style="font-size: 20px; font-weight: 600; margin-bottom: 10px;">
                  <span style="color: #fff;">₹ 37100.00</span>
                </h3>
                <p style="font-size: 15px; color: #fff; text-transform: uppercase; letter-spacing: 1px;">
                 MATCHING INCOME
                </p>
                <div class="progress" style="height: 4px; background: rgba(255,255,255,0.2); border-radius: 2px; margin: 15px 0;">
                  <div class="progress-bar" style="width: 55%; height: 100%; background: #fff; border-radius: 2px;"></div>
                </div>
              </div>
              <div class="icon" style="position: absolute; right: 20px; top: 20px; opacity: 0.3;">
                <i class="icon-user" style="font-size: 48px; color: #fff;" aria-hidden="true"></i>
              </div>
            </div>
          </div>


          <div class="span3">
            <div class="small-box bg-aqua" style="border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); transition: transform 0.3s;">
              <div class="inner" style="padding: 11px;">
                <h3 style="font-size: 20px; font-weight: 600; margin-bottom: 10px;">
                  <span style="color: #fff;">₹ 25000.00 </span>
                </h3>
                <p style="font-size: 15px; color: #fff; text-transform: uppercase; letter-spacing: 1px;"> DIAMOND CLUB </p>
                <div class="progress" style="height: 4px; background: rgba(255,255,255,0.2); border-radius: 2px; margin: 15px 0;">
                  <div class="progress-bar" style="width: 55%; height: 100%; background: #fff; border-radius: 2px;"></div>
                </div>
              </div>
              <div class="icon" style="position: absolute; right: 20px; top: 20px; opacity: 0.3;">
                <i class="icon-user" style="font-size: 48px; color: #fff;" aria-hidden="true"></i>
              </div>
            </div>
          </div>

          <div class="span3" style="margin-left: 0;">
            <div class="small-box bg-aqua" style="border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); transition: transform 0.3s;">
              <div class="inner" style="padding: 11px;">
                <h3 style="font-size: 20px; font-weight: 600; margin-bottom: 10px;">
                  <span style="color: #fff;">₹ 261675.00 </span>
                </h3>
                <p style="font-size: 15px; color: #fff; text-transform: uppercase; letter-spacing: 1px;"> TOTAL INCOME </p>
                <div class="progress" style="height: 4px; background: rgba(255,255,255,0.2); border-radius: 2px; margin: 15px 0;">
                  <div class="progress-bar" style="width: 55%; height: 100%; background: #fff; border-radius: 2px;"></div>
                </div>
              </div>
              <div class="icon" style="position: absolute; right: 20px; top: 20px; opacity: 0.3;">
                <i class="icon-user" style="font-size: 48px; color: #fff;" aria-hidden="true"></i>
              </div>
            </div>
          </div>

          

                         
                   
                        
                    
                      
                        
                    
            </div>



            <div class="row-fluid panelpart">
                
                        <div class="span4">
                            <div class="box box-widget widget-user-2">
                                <a href="#">
                                    <div class="widget-user-header bg-green gradientclr">
                                        <div class="widget-user-image"><i class="fa fa-gift" aria-hidden="true"></i></div>
                                        <h3 class="widget-user-username" style="text-transform:uppercase;font-weight: bolder;">Main Wallet</h3>
                                    </div>
                                </a>
                                <div class="widgetleftright barset">
                                    <div class="span4 border-right">
                                        <div class="description-block">
                                            <h5 class="description-header"><span><span>22294488.60</span> </span></h5>
                                            <span class="description-text" style="text-transform:uppercase;">Credit</span>
                                        </div>
                                    </div>
                                    <div class="span4 border-right">
                                        <div class="description-block">
                                            <h5 class="description-header"><span><span>87248.00</span></span></h5>
                                            <span class="description-text" style="text-transform:uppercase;">Debit </span>
                                        </div>
                                    </div>
                                    <div class="span4">
                                        <div class="description-block">
                                            <h5 class="description-header"><span><span>22207240.60</span></span></h5>
                                            <span class="description-text" style="text-transform:uppercase;">Balance</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    

                <div class="span8 packeviti">
                    <div class="box box-widget widget-user-2">
                        <div class="widget-user-header bg-aqua gradientclr">
                            <div class="widget-user-image">
                                <i class="fa fa-user" aria-hidden="true" style="font-size: 60px; color: rgb(247, 247, 248); background: #2f90d9; padding: 10px 20px; position: absolute; top: -41px; left: 38%; border-radius: 50%; border: 2px solid rgba(48, 95, 182, 0.14); opacity: .8;"></i>
                            </div>
                            <h3 class="widget-user-username" style="text-transform:uppercase;font-weight: bolder;"> MY REFERRAL LINK </h3>
                        </div>

                        <div class="widgetleftright barset">
                            <div class="span9 border-right">
                                <div class="description-block">
                                  <h5 class="description-header"><span id="ctl00_ContentPlaceHolder1_lblleftgroup">Left: <a href="#" id="ContentPlaceHolder1_aRfLink" target="_blank">
                                  <span id="ContentPlaceHolder1_lblLink"> ................... </span></a></span></h5>
                                </div>
                            </div>
                            
                            <div class="span3 border-right">
                                <div class="description-block">
                                    <h5 class="description-header">
                                        <span id="ctl00_ContentPlaceHolder1_lblrightgroup">
                                            <span id="ctl00_ContentPlaceHolder1_lblrightgroup">
                                                <input type="submit" name="ctl00$ContentPlaceHolder1$btncopy" value="Copy URL" onclick="return copyText();" id="ContentPlaceHolder1_btncopy" class="btn btn-danger">
                                            </span>
                                        </span>
                                    </h5>
                                </div>
                            </div>
                        </div>

                        <div class="widgetleftright barset">
                            <div class="span9 border-right">
                                <div class="description-block">
                                    <h5 class="description-header"><span id="ctl00_ContentPlaceHolder1_lblleftgroup">Right: <a href="#" id="ContentPlaceHolder1_aRfLinkClient" target="_blank">
                                  <span id="ContentPlaceHolder1_lblLink"> ................... </span></a></span></h5>
                                </div>
                            </div>
                            <div class="span3 border-right">
                                <div class="description-block">
                                    <h5 class="description-header">
                                        <span id="ctl00_ContentPlaceHolder1_lblrightgroup">
                                            <span id="ctl00_ContentPlaceHolder1_lblrightgroup">
                                                <input type="submit" name="ctl00$ContentPlaceHolder1$Button2" value="Copy URL" onclick="return copyText1();" id="ContentPlaceHolder1_Button2" class="btn btn-danger">

                                            </span>
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
                                <div class="span4">
                                    <div class="widget">
                                        <div class="widget-title">
                                            <h4 style="text-transform:uppercase;font-weight: bolder;"><i class="icon-user"></i>Distributor Details</h4>
                                            <span class="tools"><a href="javascript:;" class="icon-chevron-down"></a></span>
                                        </div>
                                        <div class="widget-body">
                                            <div class="row-fluid">
                                                <div class="span12" style="display:block; margin-top:20px;">
  <table class="table table-striped table-bordered table-hover">
    <tbody>
      <tr style="background:#f9f9f9; color:#333; text-align:left;">
        <th style="padding:12px 15px; width:15%;">ID No.</th>
        <td style="padding:12px 15px; width:35%; font-weight:600;">4714189</td>
        <th style="padding:12px 15px; width:15%;">Name</th>
        <td style="padding:12px 15px; width:35%; font-weight:600;">ARPANA DEVI</td>
      </tr>

      <tr style="background:#f9f9f9;">
        <th style="padding:12px 15px;">DOJ</th>
        <td style="padding:12px 15px;">24-Jun-2021</td>
        <th style="padding:12px 15px;">Pin Level </th>
        <td style="padding:12px 15px; color:green; font-weight:600;">Active</td>
      </tr>

      <tr style="background:#ffffff;">
        <th style="padding:12px 15px;">Sponsor ID</th>
        <td style="padding:12px 15px;">223344</td>
        <th style="padding:12px 15px;">Sponsor Name</th>
        <td style="padding:12px 15px; font-weight:600;">ANAND KUMAR</td>
      </tr>
    </tbody>
  </table>
</div>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="span8 column sortable">
                                    <div class="widget">
                                        <div class="widget-title">
                                            <h4 style="text-transform:uppercase;font-weight: bolder;"><i class="fa fa-envelope"></i>Latest News</h4>
                                            <span class="tools"><a href="javascript:;" class="icon-chevron-down"></a></span>
                                        </div>
                                        <div class="widget-body">

                                            <marquee direction="up" scrollamount="3" style="height: 165px;">
                                              <p> sample text here.. sample text here..   </p>
                                              <p> sample text here.. sample text here..   </p>
                                              <p> sample text here.. sample text here..   </p>
                                              <p> sample text here.. sample text here..   </p>
                                              <p> sample text here.. sample text here..   </p>

                                            </marquee>

                                            <div class="space7"></div>
                                            <div class="clearfix"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row-fluid">
                    <div class="span6">
                        <div class="widget">
                            <div class="widget-title">
                                <h4 style="text-transform:uppercase;font-weight: bolder;"><i class="icon-list-ol"></i>
                                    My Team Detail
                                </h4>
                                <span class="tools"><a href="javascript:;" class="icon-chevron-down"></a></span>
                            </div>
                            <div class="widget-body">
                                <table id="table" class="table table-hover table-mc-light-blue table-bordered">
                                    <tbody>
                                        <tr class="infoclr">
                                            <th></th>
                                            <th>Left
                                            </th>
                                            <th>Right
                                            </th>
                                            <th>Total
                                            </th>
                                        </tr>
                                        <tr class="backclr">
                                            <td>Current Month Registration
                                            </td>

                                            <td id="ContentPlaceHolder1_crntmonthjoinleft">3210</td>

                                            <td id="ContentPlaceHolder1_crntmonthjoinright">0</td>

                                            <td id="ContentPlaceHolder1_currentmonthtotaljoin">3210</td>

                                        </tr>
                                        <tr>
                                            <td>Current Month Activation
                                            </td>
                                            <td id="ContentPlaceHolder1_curntmothactiveleft">3210</td>

                                            <td id="ContentPlaceHolder1_curentmonthactiveright">0</td>

                                            <td id="ContentPlaceHolder1_crntmonthtotalactive">3210</td>

                                        </tr>
                                        <tr class="backclr" style="display: none;">
                                            <td>Current Month Retopup
                                            </td>
                                            <td id="ContentPlaceHolder1_curntmothretopupleft">0</td>

                                            <td id="ContentPlaceHolder1_curntmothretopupRight">0</td>

                                            <td id="ContentPlaceHolder1_curntmothretopupTotal">0</td>

                                        </tr>
                                        <tr>
                                            <td>Today's Activation
                                            </td>
                                            <td id="ContentPlaceHolder1_TodayDirectActive">203</td>

                                            <td id="ContentPlaceHolder1_TodayIndirectActive">0</td>

                                            <td id="ContentPlaceHolder1_TodayTotalActive">203</td>

                                        </tr>
                                        <tr class="backclr">
                                            <td>Total Activation
                                            </td>
                                            <td id="ContentPlaceHolder1_TotalDirectActivation">25426</td>

                                            <td id="ContentPlaceHolder1_TotalIndirectActivation">1003</td>

                                            <td id="ContentPlaceHolder1_TotalActivation">26429</td>

                                        </tr>
                                        <tr>
                                            <td>Total Direct Active
                                            </td>
                                            <td id="ContentPlaceHolder1_TdLeftDirectActive">3</td>

                                            <td id="ContentPlaceHolder1_TdRightIndirectActive">986</td>

                                            <td id="ContentPlaceHolder1_TdTotalDirectActive">989</td>

                                        </tr>
                                        <tr class="backclr" style="display: none;">
                                            <td>Total Retopup
                                            </td>
                                            <td id="ContentPlaceHolder1_TdLeftTopup">136</td>

                                            <td id="ContentPlaceHolder1_TdRightTopup">0</td>

                                            <td id="ContentPlaceHolder1_TdTotalTopup">136</td>

                                        </tr>
                                        <tr>
                                            <td>Current Month Repurchase Joining PV
                                            </td>
                                            <td id="ContentPlaceHolder1_tdjrpvleft">3210.00</td>

                                            <td id="ContentPlaceHolder1_tdjrpvright">0.00</td>

                                            <td id="ContentPlaceHolder1_tdjrtotal">3210.00</td>

                                        </tr>
                                        <tr>
                                            <td>Total Repurchase Joining PV
                                            </td>
                                            <td id="ContentPlaceHolder1_tdjoinpvleft">25427.11</td>

                                            <td id="ContentPlaceHolder1_tdjoinpvright">1004.00</td>

                                            <td id="ContentPlaceHolder1_tdjointotalpv">26431.11</td>

                                        </tr>
                                        <tr>
                                            <td>Current Month Repurchase PV
                                            </td>
                                            <td id="ContentPlaceHolder1_TdpvSleft">0.00</td>

                                            <td id="ContentPlaceHolder1_TdpvrightS">0.00</td>

                                            <td id="ContentPlaceHolder1_tdtotalSpv">0.00</td>

                                        </tr>
                                        <tr>
                                            <td>Total Repurchase PV
                                            </td>
                                            <td id="ContentPlaceHolder1_Tdpvleft">1.11</td>

                                            <td id="ContentPlaceHolder1_Tdpvright">1.00</td>

                                            <td id="ContentPlaceHolder1_tdtotalpv">2.11</td>

                                        </tr>
                                        <tr>
                                            <td>Current Month Repurchase BV
                                            </td>
                                            <td id="ContentPlaceHolder1_tdBVL">0.00</td>

                                            <td id="ContentPlaceHolder1_tdBVR">0.00</td>

                                            <td id="ContentPlaceHolder1_tdBV">0.00</td>

                                        </tr>
                                        <tr>
                                            <td>Total Repurchase BV
                                            </td>
                                            <td id="ContentPlaceHolder1_TdBVTL">1112.00</td>

                                            <td id="ContentPlaceHolder1_TdBVTR">1000.00</td>

                                            <td id="ContentPlaceHolder1_TdBVTotal">2112.00</td>

                                        </tr>
                                    </tbody>
                                </table>

                                
                            </div>
                        </div>
                    </div>
                    <div class="span6">
                        <div class="widget">
                            <div class="widget-title">
                                <h4 style="text-transform:uppercase;font-weight: bolder;"><i class="icon-list-ol"></i>
                                    My Direct
                                </h4>
                                <span class="tools"><a href="javascript:;" class="icon-chevron-down"></a></span>
                            </div>
                            <div class="widget-body">
                                <table class="table table-striped table-bordered table-advance table-hover">
                                    <thead>
                                        <tr>

                                            <th><i class="icon-user"></i>User Name </th>
                                            <th><i class="icon-user-md"></i>Name </th>
                                            <th><i class="icon-tags"></i>Date </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        
                                                <tr>
                                                    
                                                    <td>4895777</td>
                                                    <td>OVERNET TRADING.PVT.LTD.</td>
                                                    <td>01-Jul-2021</td>
                                                </tr>
                                            
                                                <tr>
                                                    
                                                    <td>8618132</td>
                                                    <td>PINTU KUMAR</td>
                                                    <td>01-Jul-2021</td>
                                                </tr>
                                            
                                                <tr>
                                                    
                                                    <td>7259615</td>
                                                    <td>KISHAN KUMAR</td>
                                                    <td>01-Jul-2021</td>
                                                </tr>
                                            
                                                <tr>
                                                    
                                                    <td>1965789</td>
                                                    <td>AMARJEET BHARTI</td>
                                                    <td>06-Jul-2021</td>
                                                </tr>
                                            
                                                <tr>
                                                    
                                                    <td>3448299</td>
                                                    <td>BIRENDRA SINGH</td>
                                                    <td>14-Sep-2023</td>
                                                </tr>
                                            
                                                <tr>
                                                    
                                                    <td>8989227</td>
                                                    <td>OVERNET NETWORK MARKET</td>
                                                    <td>10-Nov-2023</td>
                                                </tr>
                                            
                                                <tr>
                                                    
                                                    <td>5224884</td>
                                                    <td>CNS GROUP </td>
                                                    <td>11-Feb-2024</td>
                                                </tr>
                                            
                                                <tr>
                                                    
                                                    <td>1213362</td>
                                                    <td>Anikesh kumar</td>
                                                    <td>16-Jul-2024</td>
                                                </tr>
                                            
                                                <tr>
                                                    
                                                    <td>9472656</td>
                                                    <td>NJKHJKKKJBNK</td>
                                                    <td>16-Jul-2024</td>
                                                </tr>
                                            
                                                <tr>
                                                    
                                                    <td>1389689</td>
                                                    <td>JSJSJAKAKAK</td>
                                                    <td>16-Jul-2024</td>
                                                </tr>
                                            

                                    </tbody>
                                </table>
                                <div class="space7"></div>
                                <div class="clearfix"><a href="#" class="btn btn-mini pull-right btn-danger">More</a> </div>
                            </div>
                        </div>
                    </div>

                </div>

                <div class="row-fluid">
                    <div class="span6">
                        <div class="widget">
                            <div class="widget-title">
                                <h4 style="text-transform:uppercase;font-weight: bolder;"><i class="icon-list-ol"></i>Self Repurchase BV</h4>
                                <span class="tools">
                                    <a href="javascript:;" class="icon-chevron-down"></a>
                                </span>
                            </div>

                            <div class="widget-body">
                                <table class="table table-striped table-bordered table-advance table-hover">
                                    <thead>
                                        <tr>
                                            <th>BV Type</th>
                                            <th>Value</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>Current Month BV</td>
                                            <td id="ContentPlaceHolder1_sptotalbv">0.00</td>

                                        </tr>
                                        <tr>
                                            <td>Total BV</td>
                                            <td id="ContentPlaceHolder1_spselfbv">0.00</td>

                                        </tr>
                                    </tbody>
                                </table>

                            </div>
                        </div>
                    </div>

                </div>

                <div class="row-fluid" style="display: none;">
                    <div class="span12">
                        <div class="widget ">
                            <div class="widget-title">
                                <h4><i class="icon-globe"></i>Announcement</h4>
                                <span class="tools"><a href="javascript:;" class="icon-chevron-down"></a></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

            </div>
      </div>
    <!-- MAIN CONTENT -->
      
    <!-- BEGIN FOOTER -->
      <div id="footer">  © 2021 | Company Name Here  
        <div class="span pull-right"> <span class="go-top"><i class="icon-arrow-up"></i></span> </div>
      </div>
    <!-- END FOOTER -->
    
    <div id="GOOGLE_INPUT_CHEXT_FLAG" input="" input_stat="{&quot;tlang&quot;:true,&quot;tsbc&quot;:true,&quot;pun&quot;:true,&quot;mk&quot;:true,&quot;ss&quot;:true}" style="display: none;"></div>
    
    <script type="text/jsfile/javascript" src="assets/jsfile/jquery.gritter.js"></script>
    <script src="assets/jsfile/scripts.js"></script>

    <!-- <script src="../disable.js"></script> -->
    
  </body>
</html>
