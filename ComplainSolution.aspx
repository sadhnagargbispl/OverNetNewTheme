<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ComplainSolution.aspx.cs" Inherits="ComplainSolution" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container-fluid">
        <!-- BEGIN PAGE HEADER-->
        <div class="row-fluid">
            <div class="span12">
                <%--  <h3 class="page-title">Change Withdrawal Password   </h3>--%>
                <ul class="breadcrumb">
                    <li><a href="#"><i class="icon-home"></i></a><span class="divider">&nbsp;</span> </li>
                    <li><a href="#">Ticket Status</a><span class="divider-last">&nbsp;</span></li>
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
                                    <h4><i class="icon-credit-card"></i>Ticket Status</h4>
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
                                            <div class="table-responsive" style="overflow: scroll;">
                                                <table id="customers2" class="table datatable">
                                                    <thead>
                                                        <tr>
                                                            <th>SNo
                                                            </th>
                                                            <th>Complaint Id
                                                            </th>
                                                            <th>Complaint Date
                                                            </th>
                                                            <th>Complaint
                                                            </th>
                                                            <th>Reply Date
                                                            </th>
                                                            <th>Reply
                                                            </th>
                                                            <th>Status
                                                            </th>
                                                            <th>View
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
                                                                        <%#Eval("CID")%>
                                                                    </td>
                                                                    <td>
                                                                        <%#Eval("CDate")%>
                                                                    </td>
                                                                    <td>
                                                                        <%#Eval("Complaint")%>
                                                                    </td>
                                                                    <td>
                                                                        <%#Eval("SDate")%>
                                                                    </td>
                                                                    <td>
                                                                        <%#Eval("Solution")%>
                                                                    </td>
                                                                    <td>
                                                                        <%#Eval("Status")%>
                                                                    </td>
                                                                    <td>
                                                                        <a class="btn btn-primary" href='<%# "Reply.aspx?CID=" + (Eval("VCid"))  %>' onclick="return hs.htmlExpand(this, { objectType: 'iframe',width: 470,height: 350,marginTop : 0 } )">
                                                                            <asp:Label ID="LBModify" runat="server" Text="View Detail" ForeColor="white" />
                                                                        </a>
                                                                    </td>
                                                                </tr>
                                                            </ItemTemplate>
                                                        </asp:Repeater>
                                                    </tbody>
                                                </table>
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
















