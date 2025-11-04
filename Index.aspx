<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Index.aspx.cs" Inherits="Index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <%--<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>--%>

    <script type="text/javascript" src="https://www.google.com/jsapi"></script>

    <style>
        .tblpadding {
            padding-top: 5px !important;
            padding-bottom: 0px !important;
        }

        .tblpadding1 {
            padding-top: 5px !important;
            padding-bottom: 0px !important;
            text-align: right;
        }

        .infocolor {
            background-color: #ff2b3f;
        }
    </style>
    <style type="text/css">
        .infoclr {
            background-color: #ffe3ed;
        }

        .backclr {
            background-color: #efefef;
        }

        .Background {
            background-color: Black;
            filter: alpha(opacity=90);
            opacity: 0.8;
        }

        .Popup {
            background-color: #FFFFFF;
            border-width: 3px;
            border-style: solid;
            border-color: black;
            padding-top: 10px;
            padding-left: 10px;
            width: 500px;
            height: 550px;
        }

        .lbl {
            font-size: 16px;
            font-style: italic;
            font-weight: bold;
        }
    </style>

    <script type="text/javascript">
        function copyText() {

            var range, selection, worked;
            var element = document.getElementById("ContentPlaceHolder1_lblLink");
            if (document.body.createTextRange) {
                range = document.body.createTextRange();
                range.moveToElementText(element);
                range.select();
            } else if (window.getSelection) {
                selection = window.getSelection();
                range = document.createRange();
                range.selectNodeContents(element);
                selection.removeAllRanges();
                selection.addRange(range);
            }

            try {
                document.execCommand('copy');
                alert('link copied');
            }
            catch (err) {
                alert('unable to copy link');
            }
            return false;
        }

    </script>

    <script type="text/javascript">
        function copyText1() {
            debugger;
            var range, selection, worked;
            var element = document.getElementById("ContentPlaceHolder1_lblLinkClient");
            if (document.body.createTextRange) {
                range = document.body.createTextRange();
                range.moveToElementText(element);
                range.select();
            } else if (window.getSelection) {
                selection = window.getSelection();
                range = document.createRange();
                range.selectNodeContents(element);
                selection.removeAllRanges();
                selection.addRange(range);
            }

            try {
                document.execCommand('copy');
                alert('link copied');
            }
            catch (err) {
                alert('unable to copy link');
            }
            return false;
        }

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container-fluid">

        <div class="row-fluid">
            <div class="span12">
                <h5 class="page-title">DASHBOARD </h5>
                <hr>
            </div>
        </div>

        <div class="panelpart">

            <div class="row">

                <div class="userprofile">
                    <h3>User Profile</h3>

                    <div class="user-info">
                        <div class="info-item">
                            <label>Member ID</label>
                            <span><b><asp:Label ID="LblUserNo" runat="server" Text=""></asp:Label></b></span>
                        </div>

                        <div class="info-item">
                            <label>Member Name</label>
                            <span><b><asp:Label ID="LblLUserName" runat="server" Text=""></asp:Label></b></span>
                        </div>

                        <div class="info-item">
                            <label>Date Of Activation</label>
                            <span><b><asp:Label ID="Lbldateofjoiningg" runat="server" Text=""></asp:Label></b></span>
                        </div>

                        <div class="info-item">
                            <label>Rank</label>
                            <span><b><asp:Label ID="LblRank" runat="server" Text=""></asp:Label></b></span>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <asp:Repeater runat="server" ID="RptDirectList">
                        <ItemTemplate>
                            <%#Eval("div")%>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
                <div class="row-fluid panelpart">  
                    <asp:Repeater ID="gvBalance" runat="server">
                        <ItemTemplate>
                            <div class="span4">
                                <div class="box box-widget widget-user-2">
                                    <a href="#">
                                        <div class="widget-user-header bg-green gradientclr">
                                            <div class="widget-user-image"><i class="fa fa-gift" aria-hidden="true"></i></div>
                                            <h3 class="widget-user-username" style="text-transform: uppercase; font-weight: bolder;"><%#Eval("WalletName")%></h3>
                                        </div>
                                    </a>
                                    <div class="widgetleftright barset">
                                        <div class="span4 border-right">
                                            <div class="description-block">
                                                <h5 class="description-header"><span><span><%#Eval("Credit")%></span> </span></h5>
                                                <span class="description-text" style="text-transform: uppercase;">Credit</span>
                                            </div>
                                        </div>
                                        <div class="span4 border-right">
                                            <div class="description-block">
                                                <h5 class="description-header"><span><span><%#Eval("Debit")%></span></span></h5>
                                                <span class="description-text" style="text-transform: uppercase;">Debit </span>
                                            </div>
                                        </div>
                                        <div class="span4">
                                            <div class="description-block">
                                                <h5 class="description-header"><span><span><%#Eval("Balance")%></span></span></h5>
                                                <span class="description-text" style="text-transform: uppercase;">Balance</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                    <div class="span8">
                        <div class="box box-widget widget-user-2">
                            <div class="widget-user-header  gradientclr">
                                <div class="widget-user-image">
                                    <i class="fa fa-user" aria-hidden="true" style="font-size: 60px; color: rgb(247, 247, 248); background: #2f90d9; padding: 10px 20px; position: absolute; top: -41px; left: 38%; border-radius: 50%; border: 2px solid rgba(48, 95, 182, 0.14); opacity: .8;"></i>
                                </div>
                                <h3 class="widget-user-username" style="text-transform: uppercase; font-weight: bolder;">MY REFERRAL LINK </h3>
                            </div>

                            <div class="widgetleftright barset">
                                <div class="span9 border-right">
                                    <div class="description-block">
                                        <h5 class="description-header"><span id="ctl00_ContentPlaceHolder1_lblleftgroup">Left: 
                                      <a runat="server" target="_blank" id="aRfLink">
                                          <span>
                                              <asp:Label ID="lblLink" Style="color: blue;" runat="server"></asp:Label></span></a>
                                            <%--   <a href="#" id="ContentPlaceHolder1_aRfLink" target="_blank">
                                  <span id="ContentPlaceHolder1_lblLink"> ................... </span></a>--%>

                                        </span></h5>
                                    </div>
                                </div>

                                <div class="span3 border-right">
                                    <div class="description-block">
                                        <h5 class="description-header">
                                            <span id="ctl00_ContentPlaceHolder1_lblrightgroup">
                                                <span id="ctl00_ContentPlaceHolder1_lblrightgroup">
                                                    <asp:Button ID="btncopy" class="btn btn-danger" OnClientClick="return copyText();"
                                                        runat="server" Text="Copy URL" />
                                                    <%--<input type="submit" name="ctl00$ContentPlaceHolder1$btncopy" value="Copy URL" onclick="return copyText();" id="ContentPlaceHolder1_btncopy" class="btn btn-danger">--%>
                                                </span>
                                            </span>
                                        </h5>
                                    </div>
                                </div>
                            </div>

                            <div class="widgetleftright barset">
                                <div class="span9 border-right">
                                    <div class="description-block">
                                        <h5 class="description-header"><span id="ctl00_ContentPlaceHolder1_lblleftgroup">Right: 
                                          <%--  <a href="#" id="ContentPlaceHolder1_aRfLinkClient" target="_blank">
                                            <span id="ContentPlaceHolder1_lblLink">................... </span></a>--%>
                                            <a runat="server" target="_blank" id="aRfLinkClient">
                                                <span>
                                                    <asp:Label ID="lblLinkClient" Style="color: blue;" runat="server"></asp:Label></span></a>
                                        </span></h5>
                                    </div>
                                </div>
                                <div class="span3 border-right">
                                    <div class="description-block">
                                        <h5 class="description-header">
                                            <span id="ctl00_ContentPlaceHolder1_lblrightgroup">
                                                <span id="ctl00_ContentPlaceHolder1_lblrightgroup">
                                                    <asp:Button ID="Button2" class="btn btn-danger" OnClientClick="return copyText1();"
                                                        runat="server" Text="Copy URL" />
                                                    <%--  <input type="submit" name="ctl00$ContentPlaceHolder1$Button2" value="Copy URL" onclick="return copyText1();" id="ContentPlaceHolder1_Button2" class="btn btn-danger">--%>
                                                </span>
                                            </span>
                                        </h5>
                                    </div>
                                </div>

                            </div>

                        </div>
                    </div>
                    <div class="clearfix"></div>
                    <div class="row-fluid panelpart">
                        <div class="span12">
                            <div id="ctl00_ContentPlaceHolder1_Distributor1_TbBoard">
                                <div class="row-fluid">
                                    <div class="span4">
                                        <div class="widget">
                                            <div class="widget-title">
                                                <h4 style="text-transform: uppercase; font-weight: bolder;"><i class="icon-user"></i>Distributor Details</h4>
                                                <span class="tools"><a href="javascript:;" class="icon-chevron-down"></a></span>
                                            </div>
                                            <div class="widget-body">
                                                <div class="row-fluid">
                                                    <div class="span12" style="display: block; margin-top: 20px;">
                                                        <table class="table table-striped table-bordered table-hover">
                                                            <tbody>
                                                                <tr style="background: #f9f9f9; color: #333; text-align: left;">
                                                                    <th style="padding: 12px 15px; width: 15%;">Member ID</th>
                                                                    <td style="padding: 12px 15px; width: 35%; font-weight: 600;">
                                                                        <asp:Label ID="LblUserID" runat="server" Text=""></asp:Label></td>
                                                                    <th style="padding: 12px 15px; width: 15%;">Member Name</th>
                                                                    <td style="padding: 12px 15px; width: 35%; font-weight: 600;">
                                                                        <asp:Label ID="LblUserName" runat="server" Text=""></asp:Label></td>
                                                                </tr>

                                                                <tr style="background: #f9f9f9;">
                                                                    <th style="padding: 12px 15px;">DOJ</th>
                                                                    <td style="padding: 12px 15px;">
                                                                        <asp:Label ID="LbldateOfJoining" runat="server" Text=""></asp:Label></td>
                                                                    <th style="padding: 12px 15px;">Status</th>
                                                                    <td style="padding: 12px 15px; color: green; font-weight: 600;"><asp:Label ID="Lblstatus" runat="server" Text=""></asp:Label></td>
                                                                </tr>

                                                                <tr style="background: #ffffff;">
                                                                    <th style="padding: 12px 15px;">Sponsor ID</th>
                                                                    <td style="padding: 12px 15px;">
                                                                        <asp:Label ID="LblSponsorID" runat="server" Text=""></asp:Label></td>
                                                                    <th style="padding: 12px 15px;">Sponsor Name</th>
                                                                    <td style="padding: 12px 15px; font-weight: 600;">
                                                                        <asp:Label ID="LblSponsorName" runat="server" Text=""></asp:Label></td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="span8 column sortable">
                                        <div class="widget">
                                            <div class="widget-title">
                                                <h4 style="text-transform: uppercase; font-weight: bolder;"><i class="fa fa-envelope"></i>Latest News</h4>
                                                <span class="tools"><a href="javascript:;" class="icon-chevron-down"></a></span>
                                            </div>
                                            <div class="widget-body">

                                                <marquee direction="up" scrollamount="3" style="height: 165px;">
                                                    <asp:Repeater runat="server" ID="RptNews">
                                                        <ItemTemplate>
                                                            <p><%#Eval("NewHeding")%></p>
                                                            <p><%#Eval("NewsDetail")%></p>
                                                            <p><%#Eval("NewsDate")%></p>
                                                            <hr>
                                                        </ItemTemplate>
                                                    </asp:Repeater>

                                                </marquee>

                                                <div class="space7"></div>
                                                <div class="clearfix"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row-fluid">
                          <div class="span12">
      <div id="ctl00_ContentPlaceHolder1_Distributor1_TbBoard">
          <div class="row-fluid">
                        <div class="span6">
                            <div class="widget">
                                <div class="widget-title">
                                    <h4 style="text-transform: uppercase; font-weight: bolder;"><i class="icon-list-ol"></i>
                                        My Team Detail
                                    </h4>
                                    <span class="tools"><a href="javascript:;" class="icon-chevron-down"></a></span>
                                </div>
                                <div class="widget-body">
                                    <table id="table" class="table table-hover table-mc-light-blue table-bordered">
                                        <tbody>
                                            <tr class="infoclr">
                                                <th></th>
                                                <th>Left
                                                </th>
                                                <th>Right
                                                </th>
                                                <th>Total
                                                </th>
                                            </tr>
                                            <tr class="backclr">
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
                                            <tr class="backclr" style="display: none;">
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
                                            <tr class="backclr">
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
                                            <tr class="backclr" style="display: none;">
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
                        </div>
                        <div class="span6">
                            <div class="widget">
                                <div class="widget-title">
                                    <h4 style="text-transform: uppercase; font-weight: bolder;"><i class="icon-list-ol"></i>
                                        My Direct
                                    </h4>
                                    <span class="tools"><a href="javascript:;" class="icon-chevron-down"></a></span>
                                </div>
                                <div class="widget-body">
                                    <table class="table table-striped table-bordered table-advance table-hover">
                                        <thead>
                                            <tr>

                                                <th><i class="icon-user"></i>User Name </th>
                                                <th><i class="icon-user-md"></i>Name </th>
                                                <th><i class="icon-tags"></i>Date </th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <asp:Repeater ID="RptDirects" runat="server">
                                                <ItemTemplate>
                                                    <tr>
                                                        <%--  <td><%#Eval("SNo")%></td>--%>
                                                        <td><%#Eval("idno")%></td>
                                                        <td><%#Eval("MemName")%></td>
                                                        <td><%#Eval("DOA")%></td>
                                                    </tr>
                                                </ItemTemplate>
                                            </asp:Repeater>

                                        </tbody>
                                    </table>
                                    <div class="space7"></div>
                                    <div class="clearfix"><a href="#" class="btn btn-mini pull-right btn-danger">More</a> </div>
                                </div>
                            </div>
                        </div>
                                </div>
    </div>
</div>
                    </div>

                    <div class="row-fluid">
                        <div class="span6">
                            <div class="widget">
                                <div class="widget-title">
                                    <h4 style="text-transform: uppercase; font-weight: bolder;"><i class="icon-list-ol"></i>Self Repurchase BV</h4>
                                    <span class="tools">
                                        <a href="javascript:;" class="icon-chevron-down"></a>
                                    </span>
                                </div>

                                <div class="widget-body">
                                    <table class="table table-striped table-bordered table-advance table-hover">
                                        <thead>
                                            <tr>
                                                <th>BV Type</th>
                                                <th>Value</th>
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
                        </div>

                    </div>

                    <div class="row-fluid" style="display: none;">
                        <div class="span12">
                            <div class="widget ">
                                <div class="widget-title">
                                    <h4><i class="icon-globe"></i>Announcement</h4>
                                    <span class="tools"><a href="javascript:;" class="icon-chevron-down"></a></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</asp:Content>
