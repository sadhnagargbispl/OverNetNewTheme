<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AppPinTransferDetails.aspx.cs" Inherits="AppPinTransferDetails" %>

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
                            <li><a href="#">Send Pin Detail</a><span class="divider-last">&nbsp;</span></li>
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
                                            <h4><i class="icon-credit-card"></i>SEND PIN DETAIL</h4>
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

                                                        <div class="control-group " id="lbllevel" runat="server">
                                                            <label class="control-label">
                                                                Package Wise Detail
                                                            </label>
                                                            <div class="controls">
                                                                <asp:DropDownList ID="CmbKit" class="form-control" runat="server">
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
                                                <div id="DivSideA" runat="server">
                                                    <asp:Label ID="Label1" runat="server" Text="Total Records"></asp:Label>
                                                    <asp:Label ID="lbltotal" runat="server"></asp:Label>
                                                    <div style="overflow: scroll;">
                                                        <table id="customers2" class="table table-bordered table-striped table-actions">
                                                            <thead>
                                                                <tr>
                                                                    <th>SNo
                                                                    </th>
                                                                    <th>Transfer To Id
                                                                    </th>
                                                                    <th>Transfer To Entrepreneur
                                                                    </th>
                                                                    <th>Package Name
                                                                    </th>
                                                                    <th>Pin No
                                                                    </th>
                                                                    <th>Date
                                                                    </th>

                                                                    <th>Status
                                                                    </th>
                                                                    <th>Remark </th>
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
                                                                                <%#Eval("ToIdno")%>
                                                                            </td>
                                                                            <td>
                                                                                <%#Eval("ToMemname")%>
                                                                            </td>
                                                                            <td>
                                                                                <%#Eval("KitName")%>
                                                                            </td>
                                                                            <td>
                                                                                <%#Eval("ScratchNo")%>
                                                                            </td>
                                                                            <td>
                                                                                <%#Eval("PinDate")%>
                                                                            </td>
                                                                            <td>
                                                                                <%#Eval("PinStatus")%>
                                                                            </td>
                                                                            <td><%#Eval("Remark")%></td>
                                                                        </tr>
                                                                    </ItemTemplate>
                                                                </asp:Repeater>
                                                            </tbody>
                                                        </table>
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
