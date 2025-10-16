<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="RankReward.aspx.cs" Inherits="RankReward" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="col-md-12">
        <div id="ctl00_ContentPlaceHolder1_divgenexbusiness" class="clearfix gen-profile-box">
            <div class="profile-bar-simple red-border clearfix">
                <h6>Reward
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
                                <div class="col-md-12">
                                    <div class="table-responsive">
                                        <div class="col-md-12">
                                          <%--  <h4>Achieved Reward Status</h4>
                                            <br />--%>
                                            <div id="DivSideB" class="table-responsive" runat="server">
                                                <asp:GridView ID="GrdRewards" runat="server" PageSize="50" CssClass="table table-striped table-bordered"
                                                    CellPadding="3" HorizontalAlign="Center" AutoGenerateColumns="true" AllowPaging="True"
                                                    Width="100%">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="S.No." HeaderStyle-Width="40px">
                                                            <ItemTemplate>
                                                                <%#Container.DataItemIndex + 1%>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </div>
                                        </div>
                                       <%-- <div class="col-md-12">
                                            <h4>Next Reward Status</h4>
                                            <div id="Div3" class="table-responsive" runat="server">
                                                <asp:GridView ID="GrdNext" runat="server" CssClass="table table-striped table-bordered"
                                                    CellPadding="2" HorizontalAlign="Center" AutoGenerateColumns="true" Width="100%"
                                                    EmptyDataText="No Data Display">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="S.No." HeaderStyle-Width="40px">
                                                            <ItemTemplate>
                                                                <%#Container.DataItemIndex + 1%>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </div>
                                        </div>--%>
                                       <%-- <div class="col-md-12">
                                            <h4>Pending Reward Status</h4>
                                            <div id="Div2" class="table-responsive" runat="server">
                                                <asp:GridView ID="GrdPending" runat="server" CssClass="table table-striped table-bordered"
                                                    CellPadding="2" HorizontalAlign="Center" AutoGenerateColumns="true" Width="100%"
                                                    EmptyDataText="No Data Display">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="S.No." HeaderStyle-Width="40px">
                                                            <ItemTemplate>
                                                                <%#Container.DataItemIndex + 1%>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </div>
                                        </div>--%>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

