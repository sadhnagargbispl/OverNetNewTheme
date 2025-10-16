<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MonthlyStatement.aspx.cs" Inherits="MonthlyStatement" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link type="text/css" href="Include/basic.css" rel="stylesheet" media="screen" />
    <link href="App_Themes/Thm_Grass/Default.css" type="text/css" rel="stylesheet" />
    <style type="text/css">
        .td_heading {
            background-color: Black;
            color: white;
            font-size: 16px;
            text-align: center;
            height: 35px;
            font-weight: bold;
        }

        body {
            font-size: 12px;
            font-family: Arial, Helvetica, sans-serif;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table width="800" border="1px" align="center">
                <tr>
                    <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="rounded_colhead">
                            <tr>
                                <td valign="middle" id="header">
                                    <img src="<%= Session["LogoUrl"] %>" width="150px" height="100px" />
                                </td>
                                <td style="width: 70%; text-align: center;" valign="middle">
                                    <b>
                                        <h2 style="color: #dfbb59;">
                                            <%= Session["Compname"] %>
                                        </h2>
                                    </b>
                                    <h4 style="margin-top: 0px; font-weight: 100;">Plot No.34.1st Floor, Sewak Park, Near Dwarka Mode,<br />
                                        Metro Station, Metro Pillar No-773, Uttam Nagar, New Delhi 110059<br />
                                        MAIL: <%= Session["CompMail"] %><br />
                                        Customer Care No: <%= Session["CompMobile"] %><br />
                                        WEB: www.overnettrading.com
                                    </h4>
                                </td>
                            </tr>

                        </table>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td colspan="2" class="td_heading">Income Statement
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <table width="100%" border="0" cellpadding="5" cellspacing="1">
                                        <tr>
                                            <td width="50%" align="center" style="color: Black" class="rounded_colhead">
                                                <strong>Distributor Detail</strong>
                                            </td>
                                            <td width="50%" align="center" style="color: Black" class="rounded_colhead">
                                                <strong>Payout Detail</strong>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center" class="MainRounded">
                                                <table width="100%" border="1" cellspacing="1" cellpadding="4">
                                                    <tr>
                                                        <td width="20%" style="color: Black;">Name
                                                        </td>
                                                        <td width="3%" style="color: Black;">:
                                                        </td>
                                                        <td width="39%" style="color: Black;">
                                                            <div id="MemName" runat="server">
                                                            </div>
                                                        </td>
                                                        <td width="16%" style="color: Black;" colspan="3"></td>
                                                    </tr>
                                                    <tr>
                                                        <td width="20%">ID
                                                        </td>
                                                        <td>:
                                                        </td>
                                                        <td>
                                                            <div id="IDNO" runat="server">
                                                            </div>
                                                        </td>
                                                        <td colspan="3">&nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="20%">Address
                                                        </td>
                                                        <td>:
                                                        </td>
                                                        <td>
                                                            <div id="Add" runat="server">
                                                            </div>
                                                        </td>
                                                        <td colspan="3">&nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="20%">Mob. No.
                                                        </td>
                                                        <td>:
                                                        </td>
                                                        <td>
                                                            <div id="Mobile" runat="server">
                                                            </div>
                                                        </td>
                                                        <td>District
                                                        </td>
                                                        <td>:
                                                        </td>
                                                        <td>
                                                            <div id="District" runat="server">
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="20%">City
                                                        </td>
                                                        <td>:
                                                        </td>
                                                        <td>
                                                            <div id="City" runat="server">
                                                            </div>
                                                        </td>
                                                        <td>Pin Code
                                                        </td>
                                                        <td>:
                                                        </td>
                                                        <td>
                                                            <div id="PinCode" runat="server">
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="20%">State
                                                        </td>
                                                        <td>:
                                                        </td>
                                                        <td>
                                                            <div id="State" runat="server">
                                                            </div>
                                                        </td>
                                                        <td>&nbsp;
                                                        </td>
                                                        <td>&nbsp;
                                                        </td>
                                                        <td>&nbsp;
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td align="center" valign="top" class="MainRounded">
                                                <table width="100%" border="1" cellspacing="1" cellpadding="4">
                                                    <tr>
                                                        <td width="20%">Payout Time
                                                        </td>
                                                        <td width="3%">:
                                                        </td>
                                                        <td>
                                                            <div id="SessID" runat="server">
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="20%">Period
                                                        </td>
                                                        <td>:
                                                        </td>
                                                        <td>
                                                            <div id="FromDate" runat="server">
                                                            </div>
                                                        </td>
                                                        <td>To
                                                        </td>
                                                        <td>
                                                            <div id="ToDate" runat="server">
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td width="50%">&nbsp;
                                </td>
                                <td width="50%">&nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" class="td_heading">Income Details
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <table width="100%" border="1" cellpadding="5" cellspacing="1">
                                        <tr>
                                            <td width="25%" align="center" style="color: Black" class="rounded_colhead">
                                                <strong>Earnings</strong>
                                            </td>
                                            <td width="25%" align="center" style="color: Black" class="rounded_colhead">
                                                <strong>Amount In Rs.</strong>
                                            </td>
                                            <td width="25%" align="center" style="color: Black" class="rounded_colhead">
                                                <strong>Deductions</strong>
                                            </td>
                                            <td width="25%" align="center" style="color: Black" class="rounded_colhead">
                                                <strong>Amount In Rs.</strong>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center" valign="top" class="MainRounded">
                                                <table width="100%" border="0" cellspacing="0" cellpadding="10">
                                                    <tr>
                                                        <td>&nbsp;Everest Income
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>&nbsp; Direct Sponsor Income
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>&nbsp;Matching Income
                                                        </td>
                                                    </tr>
                                                    <%-- <tr>
                                                    <td>
                                                        &nbsp; Universal Income
                                                    </td>
                                                </tr>--%>
                                                    <tr>
                                                        <td>&nbsp; Diamond Club
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td align="center" valign="top" class="MainRounded">
                                                <table width="100%" border="0" cellspacing="0" cellpadding="10">
                                                    <tr>
                                                        <td>
                                                            <div id="EverestIncome" runat="server" style="text-align: right">
                                                                &nbsp;
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <div id="SponsorIncome" runat="server" style="text-align: right">
                                                                &nbsp;
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <div id="SponsorEverestIncome" runat="server" style="text-align: right">
                                                                &nbsp;
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <%-- <tr>
                                                    <td>
                                                        <div id="UniversalIncome" runat="server" style="text-align: right">
                                                            &nbsp;</div>
                                                    </td>
                                                </tr>--%>
                                                    <tr>
                                                        <td>
                                                            <div id="DiamondClub" runat="server" style="text-align: right">
                                                                &nbsp;
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td valign="top" align="center" class="MainRounded">
                                                <table width="100%" border="0" cellspacing="0" cellpadding="10">
                                                    <tr>
                                                        <td>TDS
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>Administration Charges
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td align="center" class="MainRounded" valign="top">
                                                <table width="100%" border="0" cellspacing="0" cellpadding="10">
                                                    <tr>
                                                        <td align="center" valign="top" style="text-align: right; padding-right: 15px">
                                                            <div id="tdsAmount" runat="server" style="text-align: right;">
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="center" valign="top" style="text-align: right; padding-right: 15px">
                                                            <div id="AdminCharges" runat="server" style="text-align: right; margin-top: -5px">
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="center" valign="top" style="text-align: right; padding-right: 15px" visible="false">
                                                            <div id="DivLoanRecovery" runat="server" style="text-align: right; margin-top: -5px">
                                                                &nbsp;
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td valign="top">
                                                <strong>Total Earnings Act</strong>
                                            </td>
                                            <td align="center" valign="top" style="text-align: right; padding-right: 15px">
                                                <div id="NetIncomeAct" runat="server">
                                                </div>
                                            </td>
                                            <td colspan="2"></td>
                                        </tr>
                                        <tr>
                                            <td valign="top">
                                                <strong>Retopup Deduction</strong>
                                            </td>
                                            <td align="center" valign="top" style="text-align: right; padding-right: 15px">
                                                <div id="BinaryDeduction" runat="server" style="text-align: right; margin-top: -5px">
                                                    &nbsp;
                                                </div>
                                            </td>
                                            <td colspan="2"></td>
                                        </tr>
                                        <tr>
                                            <td valign="top">
                                                <strong>Total Earnings</strong>
                                            </td>
                                            <td align="center" valign="top" style="text-align: right; padding-right: 15px">
                                                <div id="NetIncome" runat="server">
                                                </div>
                                            </td>
                                            <td>
                                                <strong>Total Deduction</strong>
                                            </td>
                                            <td align="center" style="text-align: right; padding-right: 15px">
                                                <div id="Deduction" runat="server">
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td></td>
                                            <td height="202" align="center" valign="top" class="MainRounded">
                                                <table width="100%" border="0" cellspacing="0" cellpadding="10">
                                                    <tr>
                                                        <td>Amount Payble
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>Brought Forward
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>Total Amount Payble
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>RoundOff(+/-)
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>Carried Forward
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td align="center" valign="top" class="MainRounded">
                                                <table width="100%" border="0" cellspacing="0" cellpadding="10">
                                                    <tr>
                                                        <td style="text-align: right">
                                                            <div id="Payable" runat="server">
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="text-align: right">
                                                            <div id="PrevBal" runat="server">
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="text-align: right">
                                                            <div id="TotPayable" runat="server">
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="text-align: right">
                                                            <div id="RoundOff" runat="server">
                                                                0.00
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="text-align: right">
                                                            <div id="ClsBal" runat="server">
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td></td>
                                            <td class="MainRounded">
                                                <strong>Net Payble Amount (Rs.)</strong>
                                            </td>
                                            <td align="right" style="text-align: right; padding-right: 15px" class="MainRounded">
                                                <div id="ChqAmount" runat="server">
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td>&nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <table width="20%" border="0" cellpadding="0" cellspacing="1">
                                        <tr>
                                            <td width="25%" style="height: 50px" align="center" class="MainRounded">
                                                <strong></strong>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center">
                                                <table width="100%" border="0" cellpadding="5" cellspacing="0">
                                                    <tr>
                                                        <td width="50%" align="center">Authorised Signatory
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
