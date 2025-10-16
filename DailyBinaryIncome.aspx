<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="DailyBinaryIncome.aspx.cs" Inherits="DailyBinaryIncome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <%-- <style type="text/css">
        .style1 {
            height: 15%;
            width: 358px;
        }

        .style2 {
            height: 2px;
            width: 304px;
        }

        .style3 {
            height: 2px;
            width: 358px;
        }
    </style>
    <link rel="stylesheet" href="plugins/datatables/dataTables.bootstrap.css">

    <script type="text/javascript" src="highslide/highslide-full.js"></script>

    <link rel="stylesheet" type="text/css" href="highslide/highslide.css" />

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

    </script>--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container-fluid">
        <!-- BEGIN PAGE HEADER-->
        <div class="row-fluid">
            <div class="span12">
                <%--  <h3 class="page-title">Change Withdrawal Password   </h3>--%>
                <ul class="breadcrumb">
                    <li><a href="#"><i class="icon-home"></i></a><span class="divider">&nbsp;</span> </li>
                    <li><a href="#">Payout Detail</a><span class="divider-last">&nbsp;</span></li>
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
                                    <h4><i class="icon-credit-card"></i>Payout Detail</h4>
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
                                            <asp:Label ID="Label2" runat="server" CssClass="error"></asp:Label>
                                        </div>
                                        <div id="DivSideA" runat="server">
                                            <div class="table-responsive">
                                                <div class="table mb-0" cellspacing="0" cellpadding="4" rules="all" border="1" id="DibDateCondition"
                                                    style="width: 100%; border-collapse: collapse;" runat="server" visible="false">
                                                    <asp:GridView ID="Rptdatecondition" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered"
                                                        HeaderStyle-BackColor="" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="left" AllowPaging="true"
                                                        PageSize="20" RowStyle-HorizontalAlign="Left" OnPageIndexChanging="Rptdatecondition_PageIndexChanging">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="S.No.">
                                                                <ItemTemplate>
                                                                    <%#Container.DataItemIndex + 1%>.
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText=" Payout Date">
                                                                <ItemTemplate>
                                                                    <%# Eval("PayoutDate") %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Stacking Bonus">
                                                                <ItemTemplate>
                                                                    <%# Eval("SelfIncome") %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Sponsorship Bonus">
                                                                <ItemTemplate>
                                                                    <%# Eval("PairIncome") %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Level Bonus">
                                                                <ItemTemplate>
                                                                    <%# Eval("LevelIncome") %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Gift Reward">
                                                                <ItemTemplate>
                                                                    <%# Eval("RewardInc") %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Royalty Team Rewards">
                                                                <ItemTemplate>
                                                                    <%#Eval("RoyaltyIncome")%>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Net Bonus">
                                                                <ItemTemplate>
                                                                    <%#Eval("Total")%>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                                <div class="table mb-0" cellspacing="0" cellpadding="4" rules="all" border="1" id="ctl00_ContentPlaceHolder2_DGVReferral"
                                                    style="width: 100%; border-collapse: collapse;" runat="server">
                                                    <asp:GridView ID="RptDirects" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered"
                                                        HeaderStyle-BackColor="" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="left" AllowPaging="true"
                                                        PageSize="20" RowStyle-HorizontalAlign="Left" OnPageIndexChanging="RptDirects_PageIndexChanging">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="S.No.">
                                                                <ItemTemplate>
                                                                    <%#Container.DataItemIndex + 1%>.
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText=" Payout Date">
                                                                <ItemTemplate>
                                                                    <%# Eval("PayoutDate") %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Self Bonus">
                                                                <ItemTemplate>
                                                                    <a href='<%# "ViewRefAirdrop.aspx?SessId=" + Eval("SessId") %>' onclick="return hs.htmlExpand(this, { objectType: 'iframe', width: 620, height: 450, marginTop: 0 });"
                                                                        style="text-decoration: underline; color: Blue;">
                                                                        <asp:Label ID="Label1" runat="server" ForeColor="Blue" Text='<%# Eval("SelfIncome") %>'></asp:Label>
                                                                    </a>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="MFA">
                                                                <ItemTemplate>
                                                                    <%# Eval("PairIncome") %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Bonus">
                                                                <ItemTemplate>
                                                                    <a href='<%# "ViewTeamInfinity.aspx?SessId=" + Eval("SessId") %>' onclick="return hs.htmlExpand(this, { objectType: 'iframe', width: 620, height: 450, marginTop: 0 });"
                                                                        style="text-decoration: underline; color: Blue;">
                                                                        <asp:Label ID="Label1" runat="server" ForeColor="Blue" Text='<%# Eval("LevelIncome") %>'></asp:Label>
                                                                    </a>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                           <%-- <asp:TemplateField HeaderText="Gift Reward">
                                                                <ItemTemplate>
                                                                    <a href='<%# "ViewRankBonus.aspx?SessId=" + Eval("SessId") %>' onclick="return hs.htmlExpand(this, { objectType: 'iframe', width: 620, height: 450, marginTop: 0 });"
                                                                        style="text-decoration: underline; color: Blue;">
                                                                        <asp:Label ID="Label1" runat="server" ForeColor="Blue" Text='<%# Eval("RewardInc") %>'></asp:Label>
                                                                    </a>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Royalty Team Rewards">
                                                                <ItemTemplate>
                                                                    <%#Eval("RoyaltyIncome")%>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>--%>
                                                            <asp:TemplateField HeaderText="Net Bonus">
                                                                <ItemTemplate>
                                                                    <%#Eval("Total")%>
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
                    </div>
                    <div class="clearfix"></div>
                    <p>&nbsp;</p>
                    <hr>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </div>
    <%--<div class="col-md-12">
        <div id="ctl00_ContentPlaceHolder1_divgenexbusiness" class="clearfix gen-profile-box">
            <div class="profile-bar-simple red-border clearfix">
                <h6>Payout Detail
                </h6>
            </div>
            <div class="clearfix gen-profile-box" style="min-height: auto;">
                <div class="profile-bar clearfix" style="background: #000;">
                    <div class="clearfix">
                        <div class="clearfix">
                            <br>
                            <div class="centered">
                                <asp:Label ID="Label2" runat="server" CssClass="error"></asp:Label>
                            </div>
                            <div class="clr">
                            </div>
                            <div class="col-md-12">
                                <div class="col-md-12">
                                    <div class="table-responsive">
                                        <div class="table mb-0" cellspacing="0" cellpadding="4" rules="all" border="1" id="DibDateCondition"
                                            style="width: 100%; border-collapse: collapse;" runat="server" visible="false">
                                            <asp:GridView ID="Rptdatecondition" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered"
                                                HeaderStyle-BackColor="" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="left" AllowPaging="true"
                                                PageSize="20" RowStyle-HorizontalAlign="Left" OnPageIndexChanging="Rptdatecondition_PageIndexChanging">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="S.No.">
                                                        <ItemTemplate>
                                                            <%#Container.DataItemIndex + 1%>.
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText=" Payout Date">
                                                        <ItemTemplate>
                                                            <%# Eval("PayoutDate") %>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Stacking Bonus">
                                                        <ItemTemplate>
                                                            <%# Eval("SelfIncome") %>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Sponsorship Bonus">
                                                        <ItemTemplate>
                                                            <%# Eval("PairIncome") %>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Level Bonus">
                                                        <ItemTemplate>
                                                            <%# Eval("LevelIncome") %>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Gift Reward">
                                                        <ItemTemplate>
                                                            <%# Eval("RewardInc") %>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Royalty Team Rewards">
                                                        <ItemTemplate>
                                                            <%#Eval("RoyaltyIncome")%>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Net Bonus">
                                                        <ItemTemplate>
                                                            <%#Eval("Total")%>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                        <div class="table mb-0" cellspacing="0" cellpadding="4" rules="all" border="1" id="ctl00_ContentPlaceHolder2_DGVReferral"
                                            style="width: 100%; border-collapse: collapse;" runat="server">
                                            <asp:GridView ID="RptDirects" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered"
                                                HeaderStyle-BackColor="" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="left" AllowPaging="true"
                                                PageSize="20" RowStyle-HorizontalAlign="Left" OnPageIndexChanging="RptDirects_PageIndexChanging">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="S.No.">
                                                        <ItemTemplate>
                                                            <%#Container.DataItemIndex + 1%>.
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText=" Payout Date">
                                                        <ItemTemplate>
                                                            <%# Eval("PayoutDate") %>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Stacking Bonus">
                                                        <ItemTemplate>
                                                            <a href='<%# "ViewRefAirdrop.aspx?SessId=" + Eval("SessId") %>' onclick="return hs.htmlExpand(this, { objectType: 'iframe', width: 620, height: 450, marginTop: 0 });"
                                                                style="text-decoration: underline; color: Blue;">
                                                                <asp:Label ID="Label1" runat="server" ForeColor="Blue" Text='<%# Eval("SelfIncome") %>'></asp:Label>
                                                            </a>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Sponsorship Bonus">
                                                        <ItemTemplate>
                                                            <%# Eval("PairIncome") %>
                                                            </a>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Level Bonus">
                                                        <ItemTemplate>
                                                            <a href='<%# "ViewTeamInfinity.aspx?SessId=" + Eval("SessId") %>' onclick="return hs.htmlExpand(this, { objectType: 'iframe', width: 620, height: 450, marginTop: 0 });"
                                                                style="text-decoration: underline; color: Blue;">
                                                                <asp:Label ID="Label1" runat="server" ForeColor="Blue" Text='<%# Eval("LevelIncome") %>'></asp:Label>
                                                            </a>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Gift Reward">
                                                        <ItemTemplate>
                                                            <a href='<%# "ViewRankBonus.aspx?SessId=" + Eval("SessId") %>' onclick="return hs.htmlExpand(this, { objectType: 'iframe', width: 620, height: 450, marginTop: 0 });"
                                                                style="text-decoration: underline; color: Blue;">
                                                                <asp:Label ID="Label1" runat="server" ForeColor="Blue" Text='<%# Eval("RewardInc") %>'></asp:Label>
                                                            </a>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Royalty Team Rewards">
                                                        <ItemTemplate>
                                                            <%#Eval("RoyaltyIncome")%>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Net Bonus">
                                                        <ItemTemplate>
                                                            <%#Eval("Total")%>
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
            </div>
        </div>
    </div>--%>
</asp:Content>

