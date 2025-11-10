<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AppPinTransfer.aspx.cs" Inherits="AppPinTransfer" %>

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
                            <li><a href="#">Pin Transfer</a><span class="divider-last">&nbsp;</span></li>
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
                                            <h4><i class="icon-credit-card"></i>PIN TRANSFER</h4>
                                            <span class="tools">
                                                <a href="javascript:;" class="icon-chevron-down"></a>
                                            </span>
                                        </div>
                                        <div class="widget-body">
                                            <div class="form-horizontal">

                                                <div class="control-group">
                                                    <label class="control-label">
                                                        ID No.<span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                                    <div class="controls">
                                                        <asp:TextBox ID="TxtSerialno" runat="server" class="input-xxlarge validate[required]"
                                                            AutoPostBack="true" OnTextChanged="TxtSerialno_TextChanged"></asp:TextBox>
                                                        <asp:Label ID="lblFormno" runat="server" Visible="false"></asp:Label>
                                                        <asp:Label ID="LblMobl" runat="server" Visible="false"></asp:Label>
                                                    </div>
                                                </div>
                                                <div class="control-group " id="DivMemberName" runat="server">
                                                    <label class="control-label">
                                                        Distributor Name <span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                                    <div class="controls">

                                                        <asp:TextBox ID="TxtSpName" runat="server" CssClass="input-xxlarge" Enabled="false"></asp:TextBox>
                                                        <asp:HiddenField ID="HdnCheckTrnns" runat="server" />
                                                    </div>
                                                </div>
                                                <div class="control-group " id="Div1" runat="server">
                                                    <label class="control-label">
                                                        Select kit <span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                                    <asp:DropDownList ID="cmbFillItem" CssClass="input-xxlarge" runat="server" AutoPostBack="true">
                                                    </asp:DropDownList>
                                                </div>
                                                <div class="control-group " runat="server">
                                                    <label class="control-label">
                                                        Quantity <span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                                    <div class="controls">
                                                        <asp:TextBox ID="txtNormalPin" runat="server" class="input-xxlarge" Text="0" onkeypress="return isNumberKey(event);"></asp:TextBox>
                                                        <asp:Label ID="LblAmount" runat="server" Visible="false"></asp:Label>
                                                        <asp:Label ID="LblAmountUse" runat="server" Visible="false"></asp:Label>
                                                    </div>
                                                </div>
                                                <div class="control-group ">
                                                    <label class="control-label">Remarks <span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                                    <div class="controls">
                                                        <asp:TextBox ID="TxtRemarks" runat="server" CssClass="input-xxlarge" TextMode="MultiLine"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="control-group ">
                                                    <label class="control-label">Transaction Password:<span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                                    <div class="controls">
                                                        <asp:TextBox ID="TxtPassword" runat="server" CssClass="input-xxlarge" TextMode="Password"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="control-group ">
                                                    <asp:Button ID="cmdSave1" runat="server" Text="Submit" class="btn" ValidationGroup="Validation" OnClick="cmdSave1_Click" />
                                                    <asp:Label ID="LblError" runat="server" Visible="false"></asp:Label>
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
