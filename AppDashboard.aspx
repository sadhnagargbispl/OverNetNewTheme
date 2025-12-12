<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="AppDashboard.aspx.cs" Inherits="AppDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <%--<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>--%>

    <script type="text/javascript" src="https://www.google.com/jsapi"></script>


    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&family=Open+Sans:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        .income-box {
            width: 100%;
        }


        .income-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
            border: 1px solid #dcdcdc;
        }


        .income-left {
            width: 60%;
            padding: 10px 15px;
            font-weight: bold;
            font-size: 13px;
            color: white;
            background: linear-gradient(90deg, #4b4b4b, #b1b1b1);
            text-transform: uppercase;
        }


        .income-right {
            width: 40%;
            padding: 10px 15px;
            text-align: right;
            background: #ffffff;
            font-size: 15px;
            font-weight: bold;
            color: #001a70;
        }


        .income-row.total .income-left {
            background: linear-gradient(90deg, #4b4b4b, #b1b1b1);
        }

        .profile-box {
            display: flex;
            align-items: center;
            gap: 12px;
            background: linear-gradient(90deg, #5c1515, #3a0a0a);
            padding: 13px;
            border-radius: 14px;
            color: white;
            margin: 10px;
        }

        /* Avatar */
        .avatar {
            width: 85px;
            height: 85px;
            border-radius: 50%;
            background: rgba(255,255,255,0.20);
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 38px;
            border: 4px solid rgba(255,255,255,0.15);
        }

        /* Table */
        .profile-table {
            width: 100%;
            border-collapse: collapse;
        }

            .profile-table td {
                padding: 4px 0;
            }

            .profile-table .labelupdate {
                font-weight: 600;
                color: #ffe7b3;
                font-size: 14px;
                text-align: left;
                width: 40%;
            }

            .profile-table .value {
                font-weight: 700;
                font-size: 14px;
                text-align: left;
                color: #ffffff;
            }



        :root {
            --bg: #f7f8fb;
            --card: #fff;
            --accent: #3a0a0a; /* deep maroon */
            --accent-2: #5c1515;
            --muted: #8a8a8a;
            --success: #0b84a5;
            --shadow: 0 6px 18px rgba(22,20,20,0.08);
            --radius: 12px;
        }

        * {
            box-sizing: border-box
        }

        html, body {
            height: 100%
        }

        body {
            margin: 0;
            font-family: "Open Sans";
            background: linear-gradient(180deg,#fafbfc 0%,var(--bg) 100%);
            color: #222;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
            padding: 0px;
        }

        .container {
            max-width: 1000px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: 1fr;
            gap: 5px;
        }

        /* Profile header */
        .profile-card {
            display: flex;
            gap: 20px;
            align-items: center;
            background: linear-gradient(90deg,var(--accent-2), var(--accent));
            color: #fef3df;
            padding: 20px;
            border-radius: 14px;
            box-shadow: var(--shadow);
            flex-wrap: wrap;
        }

        .avatar {
            flex: 0 0 88px;
            width: 88px;
            height: 88px;
            border-radius: 50%;
            background: #fff3;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 38px;
            color: #fff;
            border: 6px solid rgba(255,255,255,0.06);
        }

        .meta {
            flex: 1;
            display: flow;
            gap: 20px;
            align-items: center;
            min-width: 220px;
            flex-wrap: wrap;
        }

            .meta .item {
                min-width: 140px;
            }

            .meta .labelupdate {
                font-weight: 600;
                color: #f6e5a4;
                font-size: 13px;
                letter-spacing: 0.6px
            }

            .meta .value {
                font-weight: 700;
                font-size: 14px;
                color: #fff;
                margin-top: 6px
            }

        /* Brand area */
        .brand {
            text-align: center;
            padding: 8px 0 6px;
        }

            .brand h1 {
                margin: 8px 0 2px;
                font-family: 'Montserrat',sans-serif;
                letter-spacing: 1px;
                color: #0c1c4a;
                font-size: 28px;
            }

        .tag {
            color: var(--muted);
            font-size: 12px;
            letter-spacing: 0.6px;
        }

        /* Actions grid */
        .actions {
            display: grid;
            grid-template-columns: repeat(auto-fit,minmax(68px,1fr));
            gap: 14px;
            align-items: stretch;
            margin: 10px;
        }

        .action-card {
            background: var(--card);
            border-radius: 10px;
            padding: 5px;
            text-align: center;
            box-shadow: var(--shadow);
            display: flex;
            flex-direction: column;
            justify-content: center;
            gap: 8px;
            transition: transform .18s ease, box-shadow .18s ease;
            border: 1px solid #efefef;
        }

            .action-card:hover {
                transform: translateY(-6px)
            }

        .action-icon {
            width: 48px;
            height: 48px;
            margin: 0 auto;
            border-radius: 10px;
            display: grid;
            place-items: center;
            font-size: 22px;
            color: var(--accent-2);
            background: linear-gradient(180deg, #fff, #fbfbfb);
            border: 1px solid #eee;
        }

        .action-title {
            font-size: 13px;
            color: #333;
            font-weight: 600
        }

        .cta-row {
            display: flex;
            justify-content: center;
            margin: 6px 0 0;
        }

        .btn-primary {
            background: var(--accent-2);
            color: #fff;
            border: none;
            padding: 10px 18px;
            border-radius: 10px;
            font-weight: 700;
            cursor: pointer;
            box-shadow: 0 6px 16px rgba(89,15,15,0.2);
        }

        /* Wallet table */
        .card {
            background: var(--card);
            border-radius: 12px;
            box-shadow: var(--shadow);
            padding: 13px;
            border: 1px solid #eee;
            margin: 5px;
        }

        .wallet-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 8px;
        }

            .wallet-table th, .wallet-table td {
                text-align: left;
                padding: 10px 12px;
                border-bottom: 1px solid #f2f2f2;
            }

            .wallet-table th {
                background: linear-gradient(90deg,#6b1111,#3f0a0a);
                color: #fff;
                font-weight: 600;
                font-size: 14px;
                border-bottom: none;
            }


            .wallet-table td {
                font-weight: 700;
                color: #222
            }


        /* Income list */
        .income-list {
            display: flex;
            flex-direction: column;
            gap: 12px
        }

        .income-item {
            display: flex;
            gap: 12px;
            align-items: center;
            justify-content: space-between;
            background: linear-gradient(90deg,#fff,#fbfbfb);
            padding: 10px;
            border-radius: 8px;
            border: 1px solid #eaeaea;
        }

        .income-left {
            display: flex;
            gap: 12px;
            align-items: center;
        }




        .dot {
            width: 14px;
            height: 14px;
            border-radius: 3px;
            background: linear-gradient(90deg,#cfcfcf,#999);
            opacity: 0.95;
        }

        .income-name {
            font-weight: 700;
            color: #222
        }

        .income-value {
            font-weight: 800;
            color: #09356a
        }

        /* small screens adjustments */
        @media (max-width:720px) {
            .profile-card {
                padding: 14px
            }

            .meta .item {
                min-width: 110px
            }

            .brand h1 {
                font-size: 22px
            }

            .action-card {
                padding: 3px
            }
        }





        /* utility */
        .muted {
            color: var(--muted);
            font-size: 13px
        }

        .section-title {
            font-weight: 700;
            margin: 0 0 10px;
            color: #2b2b2b
        }

        .grid-two {
            display: grid;
            grid-template-columns: 1fr 360px;
            gap: 18px;
        }


        @media (max-width:980px) {
            .grid-two {
                grid-template-columns: 1fr
            }

            .table-responsive {
                width: 100%;
                /* max-width: 310px;*/
                overflow-x: auto;
                overflow-y: hidden;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="container">

        <div class="row">

            <!-- Top profile -->
            <div class="profile-box">

                <div class="avatar">👤</div>

                <table class="profile-table">
                    <tr>
                        <td class="labelupdate">ID NO :</td>
                        <td class="value">
                            <asp:Label ID="LblUserNo" runat="server" Text=""></asp:Label></td>
                    </tr>

                    <tr>
                        <td class="labelupdate">NAME :</td>
                        <td class="value">
                            <asp:Label ID="LblLUserName" runat="server" Text=""></asp:Label></td>
                    </tr>

                    <tr>
                        <td class="labelupdate">DOJ :</td>
                        <td class="value">
                            <asp:Label ID="LbldateOfJoining" runat="server" Text=""></asp:Label></td>
                    </tr>

                    <tr>
                        <td class="labelupdate">RANK :</td>
                        <td class="value">
                            <asp:Label ID="LblRank" runat="server" Text=""></asp:Label></td>
                    </tr>
                </table>

            </div>

            <!-- Brand -->
            <div class="brand" role="banner">
                <h1>OVERNET TRADDING</h1>
                <div class="tag">ALL OUR DREAMS CAN COME TRUE</div>
            </div>

            <!-- Actions -->
            <div class="actions" aria-label="quick actions">
                <a href="Appprofile.aspx">
                    <div class="action-card" role="button" tabindex="0">
                        <img src="appimg/appicon_1.png" alt="">
                    </div>
                </a>
                <a href="welcomeletter.aspx">
                    <div class="action-card" role="button" tabindex="0">
                        <img src="appimg/appicon_2.png" alt="">
                    </div>
                </a>
                <a href="AppComplain.aspx">
                    <div class="action-card" role="button" tabindex="0">
                        <img src="appimg/appicon_3.png" alt="">
                    </div>
                </a>
                <a href="AppComplainSolution.aspx">
                    <div class="action-card" role="button" tabindex="0">
                        <img src="appimg/appicon_4.png" alt="">
                    </div>
                </a>
                <a href="AppTree.aspx">
                    <div class="action-card" role="button" tabindex="0">
                        <img src="appimg/appicon_5.png" alt="">
                    </div>
                </a>
                <a href="AppPinTransfer.aspx">
                    <div class="action-card" role="button" tabindex="0">
                        <img src="appimg/appicon_6.png" alt="">
                    </div>
                </a>
                <a href="AppServiceWalletTransfer.aspx">
                    <div class="action-card" role="button" tabindex="0">
                        <img src="appimg/appicon_7.png" alt="">
                    </div>
                </a>
                <a href="AppAllWalletReport.aspx">
                    <div class="action-card" role="button" tabindex="0">
                        <img src="appimg/appicon_8.png" alt="">
                    </div>
                </a>

            </div>

            <div class="grid-two">

                <div class="card" aria-labelledby="wallet-title">
                    <h2 id="wallet-title" class="section-title">Main Wallet</h2>
                    <div class="table-responsive">
                        <table class="wallet-table" role="table" aria-label="main wallet balances">
                            <thead>
                                <tr>
                                    <th scope="col">Credit</th>
                                    <th scope="col">Debit</th>
                                    <th scope="col">Balance</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="gvBalance" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td><%#Eval("Credit")%></td>
                                            <td><%#Eval("Debit")%></td>
                                            <td><%#Eval("Balance")%></td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>
                    </div>
                </div>


                <div class="card" aria-labelledby="wallet-title">
                    <h2 id="wallet-title" class="section-title">My Team Detail</h2>
                    <div class="table-responsive">
                        <table class="wallet-table" role="table" aria-label="main wallet balances">
                            <thead>
                                <tr>
                                    <th scope="col"></th>
                                    <th scope="col">Left</th>
                                    <th scope="col">Right</th>
                                    <th scope="col">Total</th>
                                </tr>
                            </thead>
                            <tbody>

                                <tr>
                                    <td>Current Month Registration
                                    </td>

                                    <td id="crntmonthjoinleft" runat="server">0
                                    </td>
                                    <td id="crntmonthjoinright" runat="server">0
                                    </td>
                                    <td id="currentmonthtotaljoin" runat="server">0
                                    </td>
                                </tr>
                                <tr>
                                    <td>Current Month Activation
                                    </td>
                                    <td id="curntmothactiveleft" runat="server">0
                                    </td>
                                    <td id="curentmonthactiveright" runat="server">0
                                    </td>
                                    <td id="crntmonthtotalactive" runat="server">0
                                    </td>
                                </tr>
                                <tr style="display: none;" runat="server" visible="false">
                                    <td>Current Month Retopup
                                    </td>
                                    <td id="curntmothretopupleft" runat="server">0
                                    </td>
                                    <td id="curntmothretopupRight" runat="server">0
                                    </td>
                                    <td id="curntmothretopupTotal" runat="server">0
                                    </td>
                                </tr>
                                <tr>
                                    <td>Today's Activation
                                    </td>
                                    <td id="TodayDirectActive" runat="server">0
                                    </td>
                                    <td id="TodayIndirectActive" runat="server">0
                                    </td>
                                    <td id="TodayTotalActive" runat="server">0
                                    </td>
                                </tr>
                                <tr>
                                    <td>Total Activation
                                    </td>
                                    <td id="TotalDirectActivation" runat="server">0
                                    </td>
                                    <td id="TotalIndirectActivation" runat="server">0
                                    </td>
                                    <td id="TotalActivation" runat="server">0
                                    </td>
                                </tr>
                                <tr>
                                    <td>Total Direct Active
                                    </td>
                                    <td id="TdLeftDirectActive" runat="server">0
                                    </td>
                                    <td id="TdRightIndirectActive" runat="server">0
                                    </td>
                                    <td id="TdTotalDirectActive" runat="server">0
                                    </td>
                                </tr>
                                <tr style="display: none;" runat="server" visible="false">
                                    <td>Total Retopup
                                    </td>
                                    <td id="TdLeftTopup" runat="server">0
                                    </td>
                                    <td id="TdRightTopup" runat="server">0
                                    </td>
                                    <td id="TdTotalTopup" runat="server">0
                                    </td>
                                </tr>
                                <tr>
                                    <td>Current Month Repurchase Joining PV
                                    </td>
                                    <td id="tdjrpvleft" runat="server">0
                                    </td>
                                    <td id="tdjrpvright" runat="server">0
                                    </td>
                                    <td id="tdjrtotal" runat="server">0
                                    </td>
                                </tr>
                                <tr>
                                    <td>Total Repurchase Joining PV
                                    </td>
                                    <td id="tdjoinpvleft" runat="server">0
                                    </td>
                                    <td id="tdjoinpvright" runat="server">0
                                    </td>
                                    <td id="tdjointotalpv" runat="server">0
                                    </td>
                                </tr>
                                <tr>
                                    <td>Current Month Repurchase PV
                                    </td>
                                    <td id="TdpvSleft" runat="server">0
                                    </td>
                                    <td id="TdpvrightS" runat="server">0
                                    </td>
                                    <td id="tdtotalSpv" runat="server">0
                                    </td>
                                </tr>
                                <tr>
                                    <td>Total Repurchase PV
                                    </td>
                                    <td id="Tdpvleft" runat="server">0
                                    </td>
                                    <td id="Tdpvright" runat="server">0
                                    </td>
                                    <td id="tdtotalpv" runat="server">0
                                    </td>
                                </tr>
                                <tr>
                                    <td>Current Month Repurchase BV
                                    </td>
                                    <td id="tdBVL" runat="server">0
                                    </td>
                                    <td id="tdBVR" runat="server">0
                                    </td>
                                    <td id="tdBV" runat="server">0
                                    </td>
                                </tr>
                                <tr>
                                    <td>Total Repurchase BV
                                    </td>
                                    <td id="TdBVTL" runat="server">0
                                    </td>
                                    <td id="TdBVTR" runat="server">0
                                    </td>
                                    <td id="TdBVTotal" runat="server">0
                                    </td>
                                </tr>

                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="card" aria-labelledby="wallet-title">
                    <h2 id="wallet-title" class="section-title">Self Repurchase BV</h2>
                    <div class="table-responsive">
                        <table class="wallet-table" role="table" aria-label="main wallet balances">
                            <thead>
                                <tr>
                                    <th scope="col">BV Type</th>
                                    <th scope="col">Value</th>

                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Current Month BV</td>
                                    <td id="sptotalbv" runat="server">0</td>

                                </tr>
                                <tr>
                                    <td>Total BV</td>
                                    <td id="spselfbv" runat="server">0</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>


                <aside class="card" aria-labelledby="income-title">
                    <h2 id="income-title" class="section-title">My Income</h2>

                    <div class="income-box">
                        <asp:Repeater runat="server" ID="RptDirectList">
                            <ItemTemplate>
                                <%#Eval("AppDiv")%>
                            </ItemTemplate>
                        </asp:Repeater>

                    </div>
                </aside>




            </div>

        </div>
    </div>

    <script defer src="https://static.cloudflareinsights.com/beacon.min.js/vcd15cbe7772f49c399c6a5babf22c1241717689176015" integrity="sha512-ZpsOmlRQV6y907TI0dKBHq9Md29nnaEIPlkf84rnaERnq6zvWvPUqr2ft8M1aS28oN72PdrCzSjY4U6VaAw1EQ==" data-cf-beacon='{"version":"2024.11.0","token":"981d59f2217245c4acd469967980a90a","r":1,"server_timing":{"name":{"cfCacheStatus":true,"cfEdge":true,"cfExtPri":true,"cfL4":true,"cfOrigin":true,"cfSpeedBrain":true},"location_startswith":null}}' crossorigin="anonymous"></script>



</asp:Content>





