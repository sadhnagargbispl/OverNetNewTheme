<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AppComplain.aspx.cs" Inherits="AppComplain" %>

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
                        <%-- <h3 class="page-title">Change Password </h3>--%>
                        <ul class="breadcrumb">
                            <li><a href="#"><i class="icon-home"></i></a><span class="divider">&nbsp;</span> </li>
                            <li><a href="#">Raise Ticket</a><span class="divider-last">&nbsp;</span></li>
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
                                            <h4><i class="icon-credit-card"></i>RAISE TICKET</h4>
                                            <span class="tools">
                                                <a href="javascript:;" class="icon-chevron-down"></a>
                                            </span>
                                        </div>
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
                                                        Username :<span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                                    <div class="controls">
                                                        <asp:TextBox ID="TxtDirectSeller" Enabled="false" runat="server" CssClass="input-xxlarge"
                                                            PlaceHolder="Username" AutoPostBack="true" OnTextChanged="TxtDirectSeller_TextChanged"></asp:TextBox>
                                                    </div>
                                                </div>

                                                <div class="control-group ">
                                                    <label class="control-label">
                                                        Name <span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                                    <div class="controls">
                                                        <asp:TextBox ID="TxtName" Enabled="false" runat="server" CssClass="input-xxlarge" PlaceHolder="Name"
                                                            ValidationGroup="Save"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="control-group ">
                                                    <label class="control-label">
                                                        Mobile No<span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                                    <div class="controls">
                                                        <%--<asp:TextBox ID="TxtDoj" CssClass="input-xxlarge" runat="server" ValidationGroup="eInformation"
                                            ReadOnly="true"></asp:TextBox>--%>
                                                        <asp:TextBox ID="TxtMobl" Enabled="false" runat="server" CssClass="input-xxlarge" PlaceHolder="Mobile No"
                                                            ValidationGroup="Save"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="col-sm-12" style="display: none;">
                                                    <div class="col-sm-6">
                                                        Email ID : *
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <asp:TextBox ID="TxtEmail" Enabled="false" runat="server" CssClass="input-xxlarge" PlaceHolder="Email Id"
                                                            ValidationGroup="Save"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="control-group ">
                                                    <label class="control-label">
                                                        Nature of Grievance <span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                                    <div class="controls">
                                                        <asp:DropDownList ID="CmbCmplntType" runat="server" placeholder="Nature of Grievance "
                                                            class="input-xxlarge">
                                                        </asp:DropDownList>
                                                    </div>
                                                </div>
                                                <div class="col-sm-12" style="display: none;">
                                                    <div class="col-sm-6">
                                                        Subject : *
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <asp:TextBox ID="TxtSubject" runat="server" CssClass="input-xxlarge validate[required]"
                                                            PlaceHolder="Subject" ValidationGroup="Save" Text="aa"></asp:TextBox>
                                                        <%--  <input type="email" class="input-xxlarge" id="email" placeholder="Subject">--%>
                                                    </div>
                                                </div>
                                                <div class="control-group ">
                                                    <label class="control-label">
                                                        Description<span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                                    <div class="controls">
                                                        <asp:TextBox ID="TxtDesc" runat="server" TextMode="MultiLine" CssClass="input-xxlarge validate[required]"
                                                            placeholder="Description" ValidationGroup="Save" onkeyup="CountChar();" MaxLength="500"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="control-group ">
                                                    <asp:Button ID="BtnSubMit" runat="server" Text="Submit" class="btn" ValidationGroup="Save" OnClick="BtnSubMit_Click" />
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
