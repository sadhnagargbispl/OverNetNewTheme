<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MyDirects.aspx.cs" Inherits="MyDirects" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container-fluid">
        <!-- BEGIN PAGE HEADER-->
        <div class="row-fluid">
            <div class="span12">
                <%--  <h3 class="page-title">Change Withdrawal Password   </h3>--%>
                <ul class="breadcrumb">
                    <li><a href="#"><i class="icon-home"></i></a><span class="divider">&nbsp;</span> </li>
                    <li><a href="#">Level Wise Report</a><span class="divider-last">&nbsp;</span></li>
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
                                    <h4><i class="icon-credit-card"></i>Level Wise Report</h4>
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

                                                <div class="control-group">
                                                    <label class="control-label">
                                                        Search By</label>
                                                    <div class="controls">
                                                        <asp:DropDownList ID="rbtnsearch" runat="server" class="input-xlarge" OnSelectedIndexChanged="rbtnsearch_SelectedIndexChanged">
                                                            <asp:ListItem Text="Level Wise" Selected="True" Value="L"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="span3">

                                                <div class="control-group " id="lbllevel" runat="server">
                                                    <label class="control-label">
                                                        Level
                                                    </label>
                                                    <div class="controls">
                                                        <asp:DropDownList ID="DdlLevel" CssClass="input-xlarge" TabIndex="1" runat="server" OnSelectedIndexChanged="DdlLevel_SelectedIndexChanged">
                                                        </asp:DropDownList>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="span3">
                                                <div class="control-group " id="divSearch" runat="server">
                                                    <label class="control-label">
                                                        Search</label>
                                                    <div class="controls">
                                                        <asp:DropDownList ID="DDlSearchby" CssClass="input-xlarge" TabIndex="2" runat="server">
                                                            <asp:ListItem Text="All" Value="" Selected="True"></asp:ListItem>
                                                            <asp:ListItem Text="Active" Value="Y"></asp:ListItem>
                                                            <asp:ListItem Text="Inactive" Value="N"></asp:ListItem>
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
                                                   <br /><br />
                                        <div class="sda-content-3">
                                            <table id="table" class="table table-bordered table-striped">
                                                <tbody>
                                                    <tr>
                                                        <th></th>
                                                        <th style="text-align: center;">Direct
                                                        </th>
                                                        <th style="text-align: center">Indirect
                                                        </th>
                                                        <th style="text-align: center">Total
                                                        </th>
                                                    </tr>
                                                    <tr>
                                                        <td>Joining
                                                        </td>
                                                        <td id="tdDirectleft" runat="server" style="text-align: center">0
                                                        </td>
                                                        <td id="tdDirectright" runat="server" style="text-align: center">0
                                                        </td>
                                                        <td id="TotalDirect" runat="server" style="text-align: center">0
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>Active
                                                        </td>
                                                        <td id="tddirectActive" runat="server" style="text-align: center">0
                                                        </td>
                                                        <td id="tdindirectActive" runat="server" style="text-align: center">0
                                                        </td>
                                                        <td id="TotalActive" runat="server" style="text-align: center">0
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>Total Business
                                                        </td>
                                                        <td id="Directunit" runat="server" style="text-align: center">0
                                                        </td>
                                                        <td id="indirectunit" runat="server" style="text-align: center">0
                                                        </td>
                                                        <td id="totalunit" runat="server" style="text-align: center">0
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                        <br /><br />
                                        <div id="DivSideA" runat="server">
                                            <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                                                <ContentTemplate>
                                                    <div style="overflow: scroll;">
                                                        <asp:Label ID="Label1" runat="server" Text="Total Records"></asp:Label>
                                                        <asp:Label ID="lbltotal" runat="server"></asp:Label>
                                                        <asp:GridView ID="RptDirects" runat="server" AutoGenerateColumns="true" CssClass="table table-bordered table-striped"
                                                            AllowPaging="true" PageSize="10" OnPageIndexChanging="RptDirects_PageIndexChanging">
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="SNo">
                                                                    <ItemTemplate>
                                                                        <%#Container.DataItemIndex + 1%>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                            </Columns>
                                                        </asp:GridView>
                                                    </div>
                                                </ContentTemplate>
                                                <Triggers>
                                                    <asp:AsyncPostBackTrigger ControlID="BtnSubmit" EventName="Click" />
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
