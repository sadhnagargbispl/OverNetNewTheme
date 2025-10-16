<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="dailyeverestincome.aspx.cs" Inherits="dailyeverestincome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container-fluid">
        <!-- BEGIN PAGE HEADER-->
        <div class="row-fluid">
            <div class="span12">
                <%--  <h3 class="page-title">Change Withdrawal Password   </h3>--%>
                <ul class="breadcrumb">
                    <li><a href="#"><i class="icon-home"></i></a><span class="divider">&nbsp;</span> </li>
                    <li><a href="#">New Everest Income Detail</a><span class="divider-last">&nbsp;</span></li>
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
                                    <h4><i class="icon-credit-card"></i>New Everest Income Detail</h4>
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
                                            <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                                                <ContentTemplate>
                                                    <div style="overflow: scroll;">
                                                        <table id="customers2" class="table datatable">
                                                            <thead>
                                                                <tr>
                                                                    <th>SNo
                                                                    </th>
                                                                    <th>Payout Date
                                                                    </th>
                                                                    <th>Everest Income
                                                                    </th>
                                                                    <th>Direct Sponsor Income
                                                                    </th>
                                                                    <th>Matching Income
                                                                    </th>
                                                                    <th>Diamond Club
                                                                    </th>
                                                                    <th>Gross Income
                                                                    </th>
                                                                    <th>TDS Amount
                                                                    </th>
                                                                    <th>Admin Charge
                                                                    </th>
                                                                    <th>Retopup Deduction
                                                                    </th>
                                                                    <th>Total Deduction
                                                                    </th>
                                                                    <th>Previous Income
                                                                    </th>
                                                                    <th>Net Income
                                                                    </th>
                                                                    <th>Closing Income
                                                                    </th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <asp:Repeater ID="RptDirects" runat="server">
                                                                    <ItemTemplate>
                                                                        <tr>
                                                                            <td>
                                                                                <%#Eval("Sno")%>
                                                                            </td>
                                                                            <td>
                                                                                <%#Eval("Payout Date")%>
                                                                            </td>
                                                                            <td>
                                                                                <%#Eval("Everestincome")%>
                                                                            </td>
                                                                            <td>
                                                                                <a href='<%# "ViewTeamInfinity.aspx?SessId=" + Eval("SessId") %>'
                                                                                    onclick="return hs.htmlExpand(this, { objectType: 'iframe', width: 620, height: 300, marginTop: 10 });"
                                                                                    style="color: Blue">
                                                                                    <asp:Label ID="Label1" runat="server" ForeColor="Blue" Text='<%# Eval("SLIIncome") %>'></asp:Label>
                                                                                </a>
                                                                            </td>
                                                                            <td>
                                                                                <%#Eval("BinaryIncome")%>
                                                                            </td>
                                                                            <td>
                                                                                <%#Eval("ClubIncome")%>
                                                                            </td>
                                                                            <td>
                                                                                <%#Eval("Gross Income")%>
                                                                            </td>
                                                                            <td>
                                                                                <%#Eval("TDS Amount")%>
                                                                            </td>
                                                                            <td>
                                                                                <%#Eval("Admin Charge")%>
                                                                            </td>
                                                                            <td>
                                                                                <%#Eval("Retopup Deduction")%>
                                                                            </td>
                                                                            <td>
                                                                                <%#Eval("Total Deduction")%>
                                                                            </td>
                                                                            <td>
                                                                                <%#Eval("Previous Balance")%>
                                                                            </td>
                                                                            <td>
                                                                                <%#Eval("Net Income")%>
                                                                            </td>
                                                                            <td>
                                                                                <%#Eval("Carry Forward Balance")%>
                                                                            </td>
                                                                        </tr>
                                                                    </ItemTemplate>
                                                                </asp:Repeater>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </ContentTemplate>
                                                <Triggers>
                                                </Triggers>
                                            </asp:UpdatePanel>
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
</asp:Content>
