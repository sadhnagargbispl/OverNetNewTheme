<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AppMydirects.aspx.cs" Inherits="AppMydirects" %>

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
                            <li><a href="#">Level Wise Direct Report</a><span class="divider-last">&nbsp;</span></li>
                        </ul>
                    </div>
                </div>
                <div>

                    <div class="row-fluid panelpart">

                        <div class="row-fluid panelpart">



                            <div class="span12">

                                <div class="row">
                                    <div class="widget">
                                        <div class="widget-title">
                                            <h4><i class="icon-credit-card"></i>LEVEL WISE DIRECT REPORT</h4>
                                            <span class="tools">
                                                <a href="javascript:;" class="icon-chevron-down"></a>
                                            </span>
                                        </div>
                                        <div class="clr">
                                            <asp:Label ID="errMsg" runat="server" CssClass="error"></asp:Label>
                                        </div>
                                        <div class="widget-body">
                                            <div class="form-vertical">
                                                <div style="margin-bottom: 30px;">
                                                    <span id="ctl00_ContentPlaceHolder1_lblMsg" style="color: #C00000;"></span>
                                                    <asp:Label ID="lblErrorMessage" runat="server" Text="" CssClass="error-message"></asp:Label>
                                                </div>

                                                <div class="row">
                                                    <div class="span3">

                                                        <div class="control-group">
                                                            <label class="control-label">
                                                                Search By</label>
                                                            <div class="controls">
                                                                <asp:DropDownList ID="rbtnsearch" runat="server" class="input-xlarge" OnSelectedIndexChanged="rbtnsearch_SelectedIndexChanged">
                                                                    <asp:ListItem Text="Level Wise" Selected="True" Value="L"></asp:ListItem>
                                                                </asp:DropDownList>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="span3">

                                                        <div class="control-group " id="lbllevel" runat="server">
                                                            <label class="control-label">
                                                                Level
                                                            </label>
                                                            <div class="controls">
                                                                <asp:DropDownList ID="DdlLevel" CssClass="input-xlarge" TabIndex="1" runat="server" OnSelectedIndexChanged="DdlLevel_SelectedIndexChanged">
                                                                </asp:DropDownList>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="span3">
                                                        <div class="control-group " id="divSearch" runat="server">
                                                            <label class="control-label">
                                                                Search</label>
                                                            <div class="controls">
                                                                <asp:DropDownList ID="DDlSearchby" CssClass="input-xlarge" TabIndex="2" runat="server">
                                                                    <asp:ListItem Text="All" Value="" Selected="True"></asp:ListItem>
                                                                    <asp:ListItem Text="Active" Value="Y"></asp:ListItem>
                                                                    <asp:ListItem Text="Inactive" Value="N"></asp:ListItem>
                                                                </asp:DropDownList>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="span3">
                                                        <div class="control-group " style="margin-top: 25px;">
                                                            <div class="controls">
                                                                <asp:Button ID="BtnSubmit" runat="server" Text="Search" TabIndex="3" class="btn" OnClick="BtnSubmit_Click" />
                                                            </div>
                                                        </div>
                                                    </div>

                                                </div>
                                                <br />
                                                <br />
                                                <div class="sda-content-3">
                                                    <table id="table" class="table table-bordered table-striped">
                                                        <tbody>
                                                            <tr>
                                                                <th></th>
                                                                <th style="text-align: center;">Direct
                                                                </th>
                                                                <th style="text-align: center">Indirect
                                                                </th>
                                                                <th style="text-align: center">Total
                                                                </th>
                                                            </tr>
                                                            <tr>
                                                                <td>Joining
                                                                </td>
                                                                <td id="tdDirectleft" runat="server" style="text-align: center">0
                                                                </td>
                                                                <td id="tdDirectright" runat="server" style="text-align: center">0
                                                                </td>
                                                                <td id="TotalDirect" runat="server" style="text-align: center">0
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>Active
                                                                </td>
                                                                <td id="tddirectActive" runat="server" style="text-align: center">0
                                                                </td>
                                                                <td id="tdindirectActive" runat="server" style="text-align: center">0
                                                                </td>
                                                                <td id="TotalActive" runat="server" style="text-align: center">0
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>Total Business
                                                                </td>
                                                                <td id="Directunit" runat="server" style="text-align: center">0
                                                                </td>
                                                                <td id="indirectunit" runat="server" style="text-align: center">0
                                                                </td>
                                                                <td id="totalunit" runat="server" style="text-align: center">0
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </div>
                                                <br />
                                                <br />
                                                <div id="DivSideA" runat="server" class="sda-content-3">
                                                    <asp:Label ID="Label1" runat="server" Text="Total Records"></asp:Label>
                                                    <asp:Label ID="lbltotal" runat="server"></asp:Label>
                                                    <div class="table-responsive" style="overflow: scroll;">
                                                        <table id="customers2" class="table table-bordered table-striped">
                                                            <thead>
                                                                <tr>
                                                                    <th>SNo
                                                                    </th>
                                                                    <th>Level
                                                                    </th>
                                                                    <th>ID No
                                                                    </th>
                                                                    <th>Member Name
                                                                    </th>
                                                                    <th>Sponsor ID
                                                                    </th>
                                                                    <th>Sponsor Name
                                                                    </th>
                                                                    <th>BV
                                                                    </th>
                                                                    <th>Package Name
                                                                    </th>
                                                                    <th>Active Status
                                                                    </th>
                                                                    <th>Activation Date
                                                                    </th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <asp:Repeater ID="RptDirects" runat="server">
                                                                    <ItemTemplate>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Label ID="lblRowNumber" Text='<%# Container.ItemIndex + 1 %>' runat="server" />
                                                                            </td>
                                                                            <td>
                                                                                <%#Eval("MLevel")%>
                                                                            </td>
                                                                            <td>
                                                                                <%#Eval("IDNo")%>
                                                                            </td>
                                                                            <td>
                                                                                <%#Eval("MemName")%>
                                                                            </td>
                                                                            <td>
                                                                                <%#Eval("SponsorId")%>
                                                                            </td>
                                                                            <td>
                                                                                <%#Eval("MemberName")%>
                                                                            </td>
                                                                            <td>
                                                                                <%#Eval("BV")%>
                                                                            </td>
                                                                            <td>
                                                                                <%#Eval("PackageName")%>
                                                                            </td>
                                                                            <td>
                                                                                <%#Eval("Status")%>
                                                                            </td>
                                                                            <td>
                                                                                <%#Eval("UpgradeDate") %>
                                                                            </td>
                                                                        </tr>
                                                                    </ItemTemplate>
                                                                </asp:Repeater>
                                                            </tbody>
                                                        </table>
                                                        <!-- Paging buttons: Table ke bahar hi add karein -->
                                                        <div style="margin-top: 10px; text-align: center;">
                                                            <asp:Button ID="btnPrevious" runat="server" Text="Previous" OnClick="btnPrevious_Click" CssClass="btn" />
                                                            <asp:Label ID="lblPageInfo" runat="server" Text=""></asp:Label>
                                                            <asp:Button ID="btnNext" runat="server" Text="Next" OnClick="btnNext_Click" CssClass="btn" />
                                                        </div>
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
                </div>
            </div>
        </div>
    </form>
</body>
</html>
