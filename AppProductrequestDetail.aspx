<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AppProductrequestDetail.aspx.cs" Inherits="AppProductrequestDetail" %>

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

    <script type="text/javascript" src="highslide/highslide-full.js"></script>

<link rel="stylesheet" type="text/css" href="highslide/highslide.css" />
<style type="text/css">
    .page {
        margin: 2%;
    }
</style>

<script type="text/javascript">
    hs.graphicsDir = 'highslide/graphics/';
    hs.align = 'center';
    hs.transitions = ['expand', 'crossfade'];
    hs.fadeInOut = true;
    hs.dimmingOpacity = 0.8;
    hs.outlineType = 'rounded-white';
    hs.marginTop = 60;
    hs.marginBottom = 40;
    hs.numberPosition = '';
    hs.wrapperClassName = 'custom';
    hs.width = 600;
    hs.height = 500;
    hs.number = 'Page %1 of %2';
    hs.captionOverlay.fade = 0;

    // Add the slideshow providing the controlbar and the thumbstrip

</script>

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
                            <li><a href="#">Shopping</a><span class="divider-last">&nbsp;</span></li>
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
                                            <h4><i class="icon-credit-card"></i>SHOPPING</h4>
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



                                                <div id="DivSideA" runat="server">
                                                    <div style="overflow: scroll;">
                                                        <table id="customers2" class="table datatable">
                                                            <thead>
                                                                <tr>
                                                                    <th>SNo
                                                                    </th>
                                                                    <th>OrderNo
                                                                    </th>
                                                                    <th>Order Date
                                                                    </th>
                                                                    <th>Total Amount
                                                                    </th>
                                                                    <th>Quantity
                                                                    </th>
                                                                    <th>Type
                                                                    </th>
                                                                    <th>Status
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
                                                                                <a href='<%# "AppViewProductDetail.aspx?Reqno=" + Eval("orderno") %>'
                                                                                    onclick="return hs.htmlExpand(this, { objectType: 'iframe', width: 420, height: 350, marginTop: 0 });"
                                                                                    style="color: Blue;">
                                                                                    <%# Eval("OrderNo") %>
                                                                                </a>
                                                                            </td>
                                                                            <td>
                                                                                <%#Eval("OrderDate")%>
                                                                            </td>
                                                                            <td>
                                                                                <%#Eval("OrderAmt")%>
                                                                            </td>
                                                                            <td>
                                                                                <%#Eval("TotalQty")%>
                                                                            </td>
                                                                            <td>
                                                                                <%#Eval("OrderType")%>
                                                                            </td>
                                                                            <td>
                                                                                <%#Eval("Status")%>
                                                                            </td>
                                                                        </tr>
                                                                    </ItemTemplate>
                                                                </asp:Repeater>
                                                            </tbody>
                                                        </table>
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
