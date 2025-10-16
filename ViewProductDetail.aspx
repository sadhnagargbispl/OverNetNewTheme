<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewProductDetail.aspx.cs" Inherits="ViewProductDetail" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link rel="icon" type="image/png" sizes="16x16" href="assets/favicon.ico">
    <!--<link rel="icon" type="image/png" sizes="96x96" href="M/assets/icons/favicon-96x96.png" />createre
    <link rel="icon" type="image/png" sizes="16x16" href="M/assets/icons/favicon-16x16.png" />-->
    <link rel="#" href="#">
    <meta name="msapplication-TileColor" content="#ffffff">
    <!-- <meta name="msapplication-TileImage" content="/assets/icons/ms-icon-144x144.png" />-->
    <meta name="theme-color" content="#ffffff">
    <!-- icons -->
    <link rel="stylesheet" href="assets/font-awesome.css">
    <link href="assets/css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="assets/animate.min.css">
    <link rel="stylesheet" type="text/css" href="assets/font-awesome.min.css">
    <!-- build:css /css/vendor.css -->
    <!-- endbuild -->
    <!-- build:css /css/main.css -->
    <link rel="stylesheet" type="text/css" href="assets/main.css">
    <link rel="stylesheet" type="text/css" href="assets/text-widget-1.css">
    <link rel="stylesheet" type="text/css" href="assets/collapsed-sidebar-1.css">
    <link rel="stylesheet" type="text/css" href="assets/collapsed-left-sidebar-1.css">
    <link rel="stylesheet" type="text/css" href="assets/collapsed-sidebar-heading-1.css">
    <link rel="stylesheet" type="text/css" href="assets/font-awesome(1).css">
    <link rel="stylesheet" type="text/css" href="assets/default-forms.css">
    <link rel="stylesheet" type="text/css" href="assets/default-tables.css">
    <link rel="stylesheet" type="text/css" href="assets/datatable.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body id="dashboards-dashboard" data-layout="top-navigation-1" data-background="light"
    data-sidebar="dark" data-navbar="light" data-top-navigation="light" data-controller="dashboards"
    data-view="dashboard" data-collapsed="false" data-fullscreen="false" data-logo="light"
    class="  pace-done">
    <form id="form1" runat="server">
        <div class="col-md-12">
            <div id="ctl00_ContentPlaceHolder1_divgenexbusiness" class="clearfix gen-profile-box">
                <div class="profile-bar-simple red-border clearfix">
                    <h6>View Order Detail
                    </h6>
                </div>
                <div class="clearfix gen-profile-box" style="min-height: auto;">
                    <div class="profile-bar clearfix" style="background: #fff;">
                        <div class="clearfix">
                            <br>
                            <div class="centered">
                                <div class="clr">
                                    <asp:Label ID="Label2" runat="server" CssClass="error"></asp:Label>
                                </div>
                                <div class="clr">
                                </div>
                                <div class="form-horizontal">
                                    <div>
                                        <asp:Label ID="LblNo" runat="server" ForeColor="Black" Font-Size="14px"></asp:Label>
                                    </div>
                                    <div style="margin-bottom: 20px">
                                        <asp:GridView ID="GvData" runat="server" AutoGenerateColumns="False" RowStyle-Height="25px"
                                            GridLines="Both" AllowPaging="true" CssClass="table table-striped table-advance table-hover"
                                            PagerStyle-CssClass="pgr" AlternatingRowStyle-CssClass="alt" ShowHeader="true"
                                            PageSize="20" EmptyDataText="No data to display.">
                                            <Columns>


                                                <asp:BoundField DataField="ProductName" HeaderText="Product Name" />
                                                <asp:BoundField DataField="Rate" HeaderText="Rate" />

                                                <asp:BoundField DataField="Qty" HeaderText="Qty" />
                                                <asp:BoundField DataField="TotalAmount" HeaderText="Amount" />




                                            </Columns>
                                        </asp:GridView>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
