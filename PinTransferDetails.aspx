<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="PinTransferDetails.aspx.cs" Inherits="PinTransferDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container-fluid">
        <!-- BEGIN PAGE HEADER-->
        <div class="row-fluid">
            <div class="span12">
                <%--  <h3 class="page-title">Change Withdrawal Password   </h3>--%>
                <ul class="breadcrumb">
                    <li><a href="#"><i class="icon-home"></i></a><span class="divider">&nbsp;</span> </li>
                    <li><a href="#">Epin Detail</a><span class="divider-last">&nbsp;</span></li>
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
                                    <h4><i class="icon-credit-card"></i>Epin Detail</h4>
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

                                            <div class="span3">

                                                <div class="control-group " id="lbllevel" runat="server">
                                                    <label class="control-label">
                                                        Package Wise Detail
                                                    </label>
                                                    <div class="controls">
                                                        <asp:DropDownList ID="CmbKit" class="form-control" runat="server">
                                                        </asp:DropDownList>

                                                    </div>
                                                </div>
                                            </div>
                                            <div class="span3">
                                                <div class="control-group " style="margin-top: 25px;">
                                                    <div class="controls">
                                                        <asp:Button ID="BtnSubmit" runat="server" Text="Search" TabIndex="3" class="btn" OnClick="BtnSubmit_Click" />
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                        <div id="DivSideA" runat="server">
                                            <asp:Label ID="Label1" runat="server" Text="Total Records"></asp:Label>
                                            <asp:Label ID="lbltotal" runat="server"></asp:Label>
                                            <div style="overflow: scroll;">
                                                <table id="customers2" class="table table-bordered table-striped table-actions">
                                                    <thead>
                                                        <tr>
                                                            <th>SNo
                                                            </th>
                                                            <th>Transfer To Id
                                                            </th>
                                                            <th>Transfer To Entrepreneur
                                                            </th>
                                                            <th>Package Name
                                                            </th>
                                                            <th>Pin No
                                                            </th>
                                                            <th>Date
                                                            </th>

                                                            <th>Status
                                                            </th>
                                                            <th>Remark </th>
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
                                                                        <%#Eval("ToIdno")%>
                                                                    </td>
                                                                    <td>
                                                                        <%#Eval("ToMemname")%>
                                                                    </td>
                                                                    <td>
                                                                        <%#Eval("KitName")%>
                                                                    </td>
                                                                    <td>
                                                                        <%#Eval("ScratchNo")%>
                                                                    </td>
                                                                    <td>
                                                                        <%#Eval("PinDate")%>
                                                                    </td>
                                                                    <td>
                                                                        <%#Eval("PinStatus")%>
                                                                    </td>
                                                                    <td><%#Eval("Remark")%></td>
                                                                </tr>
                                                            </ItemTemplate>
                                                        </asp:Repeater>
                                                    </tbody>
                                                </table>
                                                <div style="margin-top: 10px; text-align: center;">
                                                    <asp:Button ID="btnPrevious" runat="server" Text="Previous" OnClick="btnPrevious_Click" CssClass="btn btn-primary" />
                                                    <asp:Label ID="lblPageInfo" runat="server" Text=""></asp:Label>
                                                    <asp:Button ID="btnNext" runat="server" Text="Next" OnClick="btnNext_Click" CssClass="btn btn-primary" />
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
</asp:Content>
