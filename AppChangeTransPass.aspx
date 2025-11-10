<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AppChangeTransPass.aspx.cs" Inherits="AppChangeTransPass" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <script type="text/javascript">
        window.history.forward();
        function noBack() {
            window.history.forward();
        }
    </script>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta name="description">
    <meta name="author">
    <title>
        <%=Session["Title"].ToString ()%></title>
    <!-- -------------------- Start CSS Files --------------------  -->
    <link href="assets/cssfile/bootstrap.min.css" rel="stylesheet">
    <link href="assets/cssfile/bootstrap-responsive.min.css" rel="stylesheet">
    <link href="assets/cssfile/font-awesome.css" rel="stylesheet">
    <link href="assets/cssfile/style.css?v=1.5" rel="stylesheet">
    <link id="ctl00_style_color" href="assets/cssfile/style_navy-blue.css?v=1.5" rel="stylesheet">
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



    <link href="assets/cssfile/newstyle.css" rel="stylesheet">

    <link href="assets/cssfile/style.css?v=2.7" rel="stylesheet">
</head>
<body>
    <form id="form1" runat="server">


        <div id="main-content">
            <div class="container-fluid">
                <!-- BEGIN PAGE HEADER-->
                <div class="row-fluid">
                    <div class="span12">
                        <%--  <h3 class="page-title">Change Withdrawal Password   </h3>--%>
                        <ul class="breadcrumb">
                            <li><a href="#"><i class="icon-home"></i></a><span class="divider">&nbsp;</span> </li>
                            <li><a href="#">Change Transaction Password</a><span class="divider-last">&nbsp;</span></li>
                        </ul>
                    </div>
                </div>
                <div>

                    <div class="row-fluid panelpart">

                        <div class="row-fluid panelpart">

                            <div class="row">

                                <div class="span12">

                                    <div class="widget">
                                        <div class="widget-title">
                                            <h4><i class="icon-credit-card"></i>CHANGE TRANSACTION PASSWORD</h4>
                                            <span class="tools">
                                                <a href="javascript:;" class="icon-chevron-down"></a>
                                            </span>
                                        </div>
                                        <div class="widget-body">
                                            <div class="form-horizontal">
                                                <div style="margin-bottom: 30px;">
                                                    <span id="ctl00_ContentPlaceHolder1_lblMsg" style="color: #C00000;"></span>
                                                    <asp:Label ID="lblErrorMessage" runat="server" Text="" CssClass="error-message"></asp:Label>
                                                </div>

                                                <div class="control-group">
                                                    <label class="control-label">
                                                        Old Transaction Password<span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                                    <div class="controls">
                                                        <%-- <asp:TextBox ID="txtReferalId" CssClass="input-xxlarge" runat="server" AutoPostBack="True"></asp:TextBox>--%>
                                                        <asp:TextBox ID="oldpass" class="input-xxlarge" TextMode="Password"
                                                            runat="server"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" Display="Dynamic" ControlToValidate="oldpass"
                                                            runat="server">Old Transaction Password can't left blank</asp:RequiredFieldValidator>
                                                    </div>
                                                </div>

                                                <div class="control-group ">
                                                    <label class="control-label">
                                                        New Transaction Password <span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                                    <div class="controls">
                                                        <asp:HiddenField ID="hdnidno" runat="server"></asp:HiddenField>
                                                        <%-- <asp:TextBox ID="txtFrstNm" CssClass="input-xxlarge validate[custom[onlyLetterNumberChar]]"
                                                runat="server" ValidationGroup="eInformation"></asp:TextBox>--%>

                                                        <asp:TextBox ID="pass1" TextMode="Password" runat="server" class="input-xxlarge"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" Display="Dynamic" ControlToValidate="pass1"
                                                            runat="server" ErrorMessage="RequiredFieldValidator"> New Transaction Password can't left blank</asp:RequiredFieldValidator>
                                                    </div>
                                                </div>
                                                <div class="control-group ">
                                                    <label class="control-label">
                                                        Confirm Transaction Password<span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                                    <div class="controls">
                                                        <%--<asp:TextBox ID="TxtDoj" CssClass="input-xxlarge" runat="server" ValidationGroup="eInformation"
                                                ReadOnly="true"></asp:TextBox>--%>
                                                        <asp:TextBox ID="pass2" class="input-xxlarge"
                                                            TextMode="Password" runat="server"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" Display="Dynamic" ControlToValidate="pass1"
                                                            runat="server" ErrorMessage="RequiredFieldValidator">confirm Transaction New Password can't left blank</asp:RequiredFieldValidator>
                                                        <asp:CompareValidator ID="CompareValidator1" ControlToValidate="Pass1" ControlToCompare="Pass2"
                                                            Type="String" Operator="Equal" Text="Passwords must match!" runat="Server" />
                                                    </div>
                                                </div>
                                                <div class="control-group ">

                                                    <asp:Button ID="BtnUpdate" runat="server" Text="Submit" class="btn" OnClick="BtnUpdate_Click" />

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
                </div>
            </div>
        </div>
    </form>
</body>
</html>


