<%@ Page Title="Welcome Letter" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="Welcomeletter.aspx.cs" Inherits="Welcomeletter" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

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

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container-fluid">
 
        <div class="row-fluid panelpart">
            <div class="span12">
                <div class="widget">
             <%--       <div class="widget-title">
                        <h4><i class="icon-credit-card"></i>WELCOME</h4>
                        <span class="tools"><a href="javascript:;" class="icon-chevron-down"></a></span>
                    </div>--%>

                    <div class="widget-body">
                        <div id="dvContents">
                            <div class="text-center mb-4">
                                <img src="<%= Session["LogoUrl"] %>" alt="Company Logo" style="max-height: 90px; width: auto;">
                                <h3 class="mt-3 text-uppercase">Welcome Letter</h3>
                                <%--<p style="font-size: 15px; color: #555;">
                                    Letter No: <span id="LblId" runat="server"></span>/<span id="LblYear" runat="server"></span>
                                </p>--%>
                                <p style="font-size: 17px; color: #222; font-weight: 600; background: #fff8dc; display: inline-block; padding: 6px 16px; border-radius: 8px; border: 1px solid #b8860b; margin-top: 10px;">
                                    Letter No: <span id="LblId" runat="server"></span>/<span id="LblYear" runat="server"></span>
                                </p>
                            </div>

                            <p><strong>Dear Clients / Participants & Families,</strong></p>
                            <p>We are <strong><%= Session["CompName"] %></strong>, pleased to welcome you as our new client and take this opportunity to extend our warm greetings to you.</p>
                            <p>We assure you that you will find it enjoyable and professionally beneficial to avail our services or to associate with us.</p>
                            <p>We, at <strong><%= Session["CompName"] %></strong>, respect the concern of our clients and associates and observe the highest degree of corporate ethics. We sincerely hope and believe that our services will exceed your expectations and add your name to our long list of satisfied clients and associates.</p>
                            <p>We are confident that our customized packages will win your trust and appreciation. Our representatives are always available 24×7 with dedication to address all your concerns. We look forward to serving you for a long time.</p>

                            <h5>Enrollment Details</h5>

                            <div class="table-responsive" style="overflow: scroll;">
                                <table class="table table-bordered">
                                    <tbody>
                                        <tr>
                                            <th>ID No</th>
                                            <td>
                                                <asp:Label ID="LblIdno" runat="server"></asp:Label></td>
                                            <th>Name</th>
                                            <td>
                                                <asp:Label ID="LblName" runat="server"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <th>Address</th>
                                            <td>
                                                <asp:Label ID="LblAddress" runat="server"></asp:Label></td>
                                            <th>City</th>
                                            <td>
                                                <asp:Label ID="LblCity" runat="server"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <th>District</th>
                                            <td>
                                                <asp:Label ID="LblDistrict" runat="server"></asp:Label></td>
                                            <th>State</th>
                                            <td>
                                                <asp:Label ID="LblState" runat="server"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <th>Mobile No</th>
                                            <td>
                                                <asp:Label ID="LblMobl" runat="server"></asp:Label></td>
                                            <th>Joining Date</th>
                                            <td>
                                                <asp:Label ID="lblDoj" runat="server"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <th>Sponsor ID</th>
                                            <td>
                                                <asp:Label ID="LblPlacementid" runat="server"></asp:Label></td>
                                            <th>Sponsor Name</th>
                                            <td>
                                                <asp:Label ID="LblPlacementName" runat="server"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <th>Joining Kit</th>
                                            <td>
                                                <asp:Label ID="LblKitName" runat="server"></asp:Label></td>
                                            <th>Kit Amount</th>
                                            <td>
                                                <asp:Label ID="LblKitAmount" runat="server"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <th>Email ID</th>
                                            <td>
                                                <asp:Label ID="LblEmail" runat="server"></asp:Label></td>
                                            <th>Pan No</th>
                                            <td>
                                                <asp:Label ID="LblPanno" runat="server"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <th>Password</th>
                                            <td>
                                                <asp:Label ID="LblPassw" runat="server"></asp:Label></td>
                                            <th></th>
                                            <td></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>

                            <p class="mt-4">See you at the Top,</p>
                            <p>
                                <strong>CMD</strong><br>
                                <span style="color: #b8860b; font-weight: bold;"><%= Session["CompName"] %></span>
                            </p>

                            <!-- ✅ Buttons hidden when printing -->
                            <div class="text-center mt-4 noprint">
                                <asp:Button ID="BtnHome" runat="server" CssClass="btn btn-info btn-sm" Text="Home" OnClick="BtnHome_ServerClick" />
                                <button type="button" class="btn btn-warning btn-sm" onclick="return PrintDiv();">Print</button>
                                <asp:Button ID="BtnNewJoin" runat="server" CssClass="btn btn-danger btn-sm" Text="New Joining" Visible="false" />
                            </div>

                        </div>
                        <!-- dvContents end -->
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
