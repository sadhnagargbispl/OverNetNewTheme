<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AppAllWalletReport.aspx.cs" Inherits="AppAllWalletReport" %>

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
        <style>
            body {
                font-family: 'Segoe UI', Arial, sans-serif;
                background-color: #f6f7fb;
                color: #333;
            }

            #dvContents {
                background: #fff;
                padding: 40px 30px;
                border-radius: 12px;
                box-shadow: 0 0 12px rgba(0, 0, 0, 0.12);
                max-width: 900px;
                margin: 30px auto;
                font-size: 16px;
                line-height: 1.6;
            }

                #dvContents h3 {
                    font-weight: 700;
                    color: #b8860b;
                    font-size: 28px;
                    text-align: center;
                }

                #dvContents h5 {
                    font-size: 20px;
                    margin-top: 25px;
                    color: #444;
                    border-bottom: 2px solid #b8860b;
                    display: inline-block;
                    padding-bottom: 5px;
                }

                #dvContents p {
                    text-align: justify;
                    margin-bottom: 12px;
                }

                #dvContents table {
                    width: 100%;
                    border-collapse: collapse;
                    margin-top: 15px;
                    font-size: 15px;
                }

                    #dvContents table th,
                    #dvContents table td {
                        border: 1px solid #777;
                        padding: 8px 10px;
                        vertical-align: middle;
                    }

                    #dvContents table th {
                        background-color: #f8f8f8;
                        font-weight: 600;
                        text-align: left;
                    }

            .btn {
                padding: 8px 20px;
                border-radius: 5px;
                font-size: 15px;
                font-weight: 500;
                cursor: pointer;
                margin: 5px;
            }

            /* ✅ Hide buttons only when printing */
            @media print {
                .noprint {
                    display: none !important;
                    visibility: hidden !important;
                }

                body {
                    background: white !important;
                    margin: 0;
                }

                #dvContents {
                    box-shadow: none;
                    border: none;
                    margin: 0;
                    padding: 0;
                }
            }

            /* ✅ Responsive layout */
            @media (max-width: 767px) {
                #dvContents {
                    padding: 20px 15px;
                    font-size: 15px;
                }

                    #dvContents h3 {
                        font-size: 22px;
                    }

                    #dvContents h5 {
                        font-size: 18px;
                    }

                    #dvContents table th,
                    #dvContents table td {
                        font-size: 14px;
                        padding: 6px;
                    }

                /*.btn {
        width: 100%;
        margin-top: 8px;
    }*/
            }
        </style>

        <script>
            // ✅ Print only #dvContents section
            function PrintDiv() {
                var printContent = document.getElementById('dvContents').innerHTML;
                var WinPrint = window.open('', '', 'width=900,height=700');
                WinPrint.document.write('<html><head><title>Welcome Letter</title>');
                WinPrint.document.write('<style>');
                WinPrint.document.write(`
        body{font-family:Segoe UI,Arial,sans-serif;font-size:14px;margin:20px;}
        table{width:100%;border-collapse:collapse;font-size:14px;}
        th,td{border:1px solid #777;padding:8px;}
        th{background-color:#f8f8f8;}
        h3{color:#b8860b;text-align:center;}
        .noprint{display:none !important;}
    `);
                WinPrint.document.write('</style></head><body>');
                WinPrint.document.write(printContent);
                WinPrint.document.write('</body></html>');
                WinPrint.document.close();
                WinPrint.focus();
                WinPrint.print();
                WinPrint.close();
                return false;
            }
        </script>

        <div id="main-content">
            <div class="container-fluid">
    <!-- BEGIN PAGE HEADER-->
    <div class="row-fluid">
        <div class="span12">
            <%--  <h3 class="page-title">Change Withdrawal Password   </h3>--%>
            <ul class="breadcrumb">
                <li><a href="#"><i class="icon-home"></i></a><span class="divider">&nbsp;</span> </li>
                <li><a href="#">All Wallet Report</a><span class="divider-last">&nbsp;</span></li>
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
                                <h4><i class="icon-credit-card"></i>ALL WALLET REPORT</h4>
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

                                        <div class="span6">
                                            <div class="table-responsive">
                                                <table class="table table-hover table-bordered">
                                                    <tr>
                                                        <td>
                                                            <b>Wallet Type :</b>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlVoucherType" runat="server" CssClass="input-xxlarge">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td>
                                                            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-danger" OnClick="btnSearch_Click" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>


                                    </div>
                                    <div class="row">

                                        <div class="span6">
                                            <div class="table-responsive">
                                                <br />
                                                <table class="table table-hover table-bordered">

                                                    <tbody>
                                                        <tr>
                                                            <td>Deposit</td>
                                                            <td>:</td>
                                                            <td id="MCredit" runat="server">0.00</td>
                                                        </tr>
                                                        <tr>
                                                            <td>Used</td>
                                                            <td>:</td>
                                                            <td id="MDebit" runat="server">0.00</td>
                                                        </tr>
                                                        <tr>
                                                            <td>Balance</td>
                                                            <td>:</td>
                                                            <td id="MBal" runat="server">0.00</td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>

                                    </div>
                                    <div id="DivSideA" runat="server">
                                       <%-- <asp:Label ID="Label1" runat="server" Text="Total Records"></asp:Label>
                                        <asp:Label ID="lbltotal" runat="server"></asp:Label>--%>
                                        <br />
                                        <div style="overflow: scroll;">
                                            <asp:GridView ID="RptDirects" runat="server" AutoGenerateColumns="true"
                                                CssClass="table table-bordered" EmptyDataText="No data to display." AllowPaging="true" PageSize="10" OnPageIndexChanging="RptDirects_PageIndexChanging">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="S.No.">
                                                        <ItemTemplate>
                                                            <%#Container.DataItemIndex + 1%>.
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
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














