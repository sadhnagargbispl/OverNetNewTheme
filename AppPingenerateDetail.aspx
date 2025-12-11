<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="AppPingenerateDetail.aspx.cs" Inherits="AppPingenerateDetail" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid panelpart">



        <div class="span12">

            <div class="row">
                <div class="form-card">
                    <div class="widget-title">
                        <h4><i class="icon-credit-card"></i>PIN GENERATE DETAIL</h4>
                        <span class="tools">
                            <a href="javascript:;" class="icon-chevron-down"></a>
                        </span>
                    </div>
                    <div class="clr">
                        <asp:Label ID="Label1" runat="server" CssClass="error"></asp:Label>
                    </div>
                    <div class="widget-body">
                        <div class="content-card">
                            <div class="form-vertical">
                                <div style="margin-bottom: 30px;">
                                    <span id="ctl00_ContentPlaceHolder1_lblMsg" style="color: #C00000;"></span>
                                    <asp:Label ID="Label2" runat="server" Text="" CssClass="error-message"></asp:Label>
                                </div>
                                <div id="Div1" runat="server">
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <ContentTemplate>
                                            <div style="overflow: scroll;">
                                                <asp:GridView ID="RptDirects" runat="server" AutoGenerateColumns="TRUE" CssClass="table table-bordered"
                                                    HeaderStyle-BackColor="" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center" AllowPaging="true"
                                                    PageSize="10" RowStyle-HorizontalAlign="Right" OnPageIndexChanging="RptDirects_PageIndexChanging">
                                                    <Columns>
                                                    </Columns>
                                                </asp:GridView>
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
        </div>
        <div class="clearfix"></div>
        <p>&nbsp;</p>
        <hr>
        <div class="clearfix"></div>
    </div>
</asp:Content>
