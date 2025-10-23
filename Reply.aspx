<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Reply.aspx.cs" Inherits="Reply" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
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
    <link href="assets/cssfile/newstyle.css" rel="stylesheet">
</head>
<body class="fixed-top" data-new-gr-c-s-check-loaded="14.996.0" data-gr-ext-installed="" cz-shortcut-listen="true">

    <!-- END HEADER -->
    <!-- BEGIN CONTAINER -->
    <div id="container" class="row-fluid blueclr">
        <!-- BEGIN SIDEBAR -->
        <!-- END SIDEBAR -->
        <form name="aspnetForm" method="post" action="#" id="aspnetForm" runat="server">

            <link rel="stylesheet" href="assets/font-awesome.min.css">

            <!-- BEGIN PAGE -->
            <div id="main-content">
                <!-- BEGIN PAGE CONTAINER-->
        

                        <div class="row-fluid panelpart">
                        
                            <div class="clearfix"></div>
                            <p>&nbsp;</p>
                            <hr>
                            <div class="row-fluid panelpart">

                                <div class="row">

                                    <div class="span12">

                                        <div class="widget">
                                            <div class="widget-title">
                                                <h4><i class="icon-credit-card"></i>Raise Ticket</h4>
                                                <span class="tools">
                                                    <a href="javascript:;" class="icon-chevron-down"></a>
                                                </span>
                                            </div>
                                            <asp:HiddenField ID="HiddenField1" runat="server" />
                                            <div class="widget-body">
                                                <div class="form-horizontal">
                                                    <div style="margin-bottom: 30px;">
                                                        <div class="clr">
                                                            <asp:Label ID="Label2" runat="server" CssClass="error"></asp:Label>
                                                            <asp:HiddenField ID="HdnCheckTrnns" runat="server" />
                                                        </div>
                                                    </div>
                                                    <div id="DivError" runat="server" visible="false">
                                                        <span id="spanError" runat="server"></span>
                                                    </div>
                                                    <div class="span12">
                                                        <asp:Label ID="LblCompalin" runat="server" Visible="false"></asp:Label>
                                                        <asp:Label ID="Lblgroup" runat="server" Visible="false"></asp:Label>
                                                    </div>

                                                    <div class="control-group">
                                                        <label class="control-label">
                                                            Complaint type :<span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                                        <div class="controls">
                                                            <asp:Label class="input-xxlarge" ID="LblCType" runat="server"></asp:Label>
                                                        </div>
                                                    </div>

                                                    <div class="control-group ">
                                                        <label class="control-label">
                                                            Complaint <span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                                        <div class="controls">
                                                            <asp:TextBox class="input-xxlarge" ID="TxtComplaint" ReadOnly="true" TextMode="MultiLine" runat="server"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="control-group ">
                                                        <label class="control-label">
                                                            Previous Reply<span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                                        <div class="controls">
                                                            <asp:TextBox class="input-xxlarge" ID="TxtPreReply" ReadOnly="true" TextMode="MultiLine" runat="server"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>



                                    </div>

                                </div>


                            </div>

                        </div>


























                        <!-- END PAGE -->
                    </div>

                    <script type="text/jsfile/javascript" src="assets/jquery.gritter.js"></script>
                    <script src="assets/scripts.js"></script>
        </form>
    </div>

</body>
</html>
