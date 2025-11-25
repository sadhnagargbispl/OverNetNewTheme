<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="AppProductrequestDetail.aspx.cs" Inherits="AppProductrequestDetail" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid panelpart">



        <div class="span12">

            <div class="row">
                <div class="form-card">
                    <div class="widget-title">
                        <h4><i class="icon-credit-card"></i>SHOPPING</h4>
                        <span class="tools">
                            <a href="javascript:;" class="icon-chevron-down"></a>
                        </span>
                    </div>
                    <div class="clr">
                        <asp:Label ID="errMsg" runat="server" CssClass="error"></asp:Label>
                    </div>
                    <div class="widget-body">
                        <div class="content-card">
                            <div class="form-vertical">
                                <div style="margin-bottom: 30px;">
                                    <span id="ctl00_ContentPlaceHolder1_lblMsg" style="color: #C00000;"></span>
                                    <asp:Label ID="lblErrorMessage" runat="server" Text="" CssClass="error-message"></asp:Label>
                                </div>



                                <div id="DivSideA" runat="server">
                                    <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                                        <ContentTemplate>
                                            <div style="overflow: scroll;">
                                                <table id="customers2" class="table table-bordered table-striped table-actions">
                                                    <thead>
                                                        <tr>
                                                            <th>SNo
                                                            </th>
                                                            <th>OrderNo
                                                            </th>
                                                            <th>Order Date
                                                            </th>
                                                            <th>Total Amount
                                                            </th>
                                                            <th>Quantity
                                                            </th>
                                                            <th>Type
                                                            </th>
                                                            <th>Status
                                                            </th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <asp:Repeater ID="RptDirects" runat="server">
                                                            <ItemTemplate>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="lblRowNumber" Text='<%# Container.ItemIndex + 1 %>' runat="server" />
                                                                    </td>
                                                                    <td>
                                                                        <a href='<%# "ViewProductDetail.aspx?Reqno=" + Eval("orderno") %>'
                                                                            onclick="return hs.htmlExpand(this, { objectType: 'iframe', width: 420, height: 350, marginTop: 0 });"
                                                                            style="color: Blue;">
                                                                            <%# Eval("OrderNo") %>
                                                                        </a>
                                                                    </td>
                                                                    <td>
                                                                        <%#Eval("OrderDate")%>
                                                                    </td>
                                                                    <td>
                                                                        <%#Eval("OrderAmt")%>
                                                                    </td>
                                                                    <td>
                                                                        <%#Eval("TotalQty")%>
                                                                    </td>
                                                                    <td>
                                                                        <%#Eval("OrderType")%>
                                                                    </td>
                                                                    <td>
                                                                        <%#Eval("Status")%>
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
        </div>
        <div class="clearfix"></div>
        <p>&nbsp;</p>
        <hr>
        <div class="clearfix"></div>
    </div>
</asp:Content>
