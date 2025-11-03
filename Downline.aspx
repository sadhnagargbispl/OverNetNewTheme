<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Downline.aspx.cs" Inherits="Downline" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">
        function showMe() {
            var inp = document.getElementById('myform').getElementsByTagName('input'), el, i = 0, k = 0;
            while (el = inp[i++]) {
                if (el.name == 'mype' || el.name == 'modtype') {
                    document.getElementById(ids[k]).style.display = el.checked ? 'block' : 'none';
                    k++;
                }
            }
        }
    </script>


    <div class="container-fluid">
        <!-- BEGIN PAGE HEADER-->
        <div class="row-fluid">
            <div class="span12">
                <%--  <h3 class="page-title">Change Withdrawal Password   </h3>--%>
                <ul class="breadcrumb">
                    <li><a href="#"><i class="icon-home"></i></a><span class="divider">&nbsp;</span> </li>
                    <li><a href="#">Level Wise Direct Report</a><span class="divider-last">&nbsp;</span></li>
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
                                    <h4><i class="icon-credit-card"></i>DOWNLINE DETAIL</h4>
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
                                                        <asp:RadioButtonList AutoPostBack="True" ID="rbleg" RepeatDirection="Horizontal"
                                                            runat="server" OnSelectedIndexChanged="rbleg_SelectedIndexChanged">
                                                            <asp:ListItem Selected="True">Both</asp:ListItem>
                                                            <asp:ListItem>Left Downline</asp:ListItem>
                                                            <asp:ListItem>Right Downline</asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="span3">
                                                <div class="control-group " style="margin-top: 25px;">
                                                    <div class="controls">
                                                        <%--<asp:Button ID="BtnSubmit" runat="server" Text="Search" TabIndex="3" class="btn" OnClick="BtnSubmit_Click" />--%>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                        <br />
                                        <br />
                                        <div class="sda-content-3">
                                            <table class="table table-bordered">
                                                <tbody>
                                                    <tr valign="top">
                                                        <td class="box-body1-clear" align="center" colspan="6">
                                                            <b>Status</b>
                                                        </td>
                                                    </tr>
                                                    <tr valign="top">
                                                        <td align="center">
                                                            <strong>Total Left Joined </strong>
                                                        </td>
                                                        <td align="center">
                                                            <strong>Total Right Joined </strong>
                                                        </td>
                                                        <td align="center">
                                                            <strong>Total Left Topup </strong>
                                                        </td>
                                                        <td align="center">
                                                            <strong>Total Right Topup </strong>
                                                        </td>
                                                        <td align="center">
                                                            <strong>Total Left BV </strong>
                                                        </td>
                                                        <td align="center">
                                                            <strong>Total Right BV </strong>
                                                        </td>
                                                    </tr>
                                                    <tr valign="top">
                                                        <td align="center">
                                                            <span id="LblMemLJ" runat="server">0</span>
                                                        </td>
                                                        <td align="center">
                                                            <span id="LblMemRJ" runat="server">0</span>
                                                        </td>
                                                        <td align="center">
                                                            <span id="LblMemLT" runat="server">0</span>
                                                        </td>
                                                        <td align="center">
                                                            <span id="LblMemRT" runat="server">0</span>
                                                        </td>
                                                        <td align="center">
                                                            <span id="LblLeftBv" runat="server">0</span>
                                                        </td>
                                                        <td align="center">
                                                            <span id="LblRightBv" runat="server">0</span>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                        <br />
                                        <br />
                                        <div id="DivSideA" runat="server" class="col-md-12">
                                            <h4>Left Downline</h4>
                                            <div class="form-group ">
                                                <asp:Button ID="BtnExportA" runat="server" Text="Export" class="btn btn-primary" />
                                            </div>
                                            <asp:Label ID="Label1" runat="server" Text="Total Records"></asp:Label>
                                            <asp:Label ID="lbltotal" runat="server"></asp:Label>
                                            <div class="spacedivider2">
                                            </div>
                                            <div class="table-responsive" style="overflow: scroll;">
                                                <%--<asp:UpdatePanel ID="UpdatePanel7" runat="server">
            <ContentTemplate>--%>
                                                <table id="customers2" class="table datatable">
                                                    <thead>
                                                        <tr>
                                                            <th>SNo
                                                            </th>
                                                            <th>ID No
                                                            </th>
                                                            <th>Member Name
                                                            </th>
                                                            <th>Sponsor ID
                                                            </th>
                                                            <th>Date Of Joining
                                                            </th>
                                                            <th>Package Name
                                                            </th>
                                                            <th>Activation Date
                                                            </th>
                                                            <th>Package MRP
                                                            </th>
                                                            <th>BV
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
                                                                        <%#Eval("IDNo")%>
                                                                    </td>
                                                                    <td>
                                                                        <%#Eval("MemName")%>
                                                                    </td>
                                                                    <td>
                                                                        <%#Eval("Refformno")%>
                                                                    </td>
                                                                    <td>
                                                                        <%#Eval("Doj")%>
                                                                    </td>
                                                                    <td>
                                                                        <%#Eval("KitName")%>
                                                                    </td>
                                                                    <td>
                                                                        <%#Eval("TopupDate")%>
                                                                    </td>
                                                                    <td>
                                                                        <%#Eval("KitAmount")%>
                                                                    </td>
                                                                    <td>
                                                                        <%#Eval("Bv") %>
                                                                    </td>
                                                                </tr>
                                                            </ItemTemplate>
                                                        </asp:Repeater>
                                                    </tbody>
                                                </table>
                                                <%-- </ContentTemplate>
            <Triggers>
            </Triggers>
        </asp:UpdatePanel>--%>
                                                <div style="margin-top: 10px; text-align: center;">
                                                    <asp:Button ID="btnPrevious" runat="server" Text="Previous" OnClick="btnPrevious_Click" class="btn btn-primary" />
                                                    <asp:Label ID="lblPageInfo" runat="server" Text=""></asp:Label>
                                                    <asp:Button ID="btnNext" runat="server" Text="Next" OnClick="btnNext_Click" class="btn btn-primary" />
                                                </div>
                                            </div>
                                        </div>
                                        <div id="DivSideB" runat="server" class="col-md-12">
                                            <h4>Right Downline <span></span>
                                            </h4>
                                            <div class="form-group">
                                                <asp:Button ID="BtnExportB" runat="server" Text="Export" class="btn btn-primary" />
                                            </div>
                                            <asp:Label ID="Label2" runat="server" Text="Total Records"></asp:Label>
                                            <asp:Label ID="lbltotal2" runat="server"></asp:Label>
                                            <div class="spacedivider2">
                                            </div>
                                            <div class="table-responsive" style="overflow: scroll;">
                                                <%--  <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>--%>
                                                <table id="customers3" class="table datatable">
                                                    <thead>
                                                        <tr>
                                                            <th>SNo
                                                            </th>
                                                            <th>ID No
                                                            </th>
                                                            <th>Member Name
                                                            </th>
                                                            <th>Sponsor ID
                                                            </th>
                                                            <th>Date Of Joining
                                                            </th>
                                                            <th>Package Name
                                                            </th>
                                                            <th>Activation Date
                                                            </th>
                                                            <th>Package MRP
                                                            </th>
                                                            <th>BV
                                                            </th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <asp:Repeater ID="Repeater3" runat="server">
                                                            <ItemTemplate>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="lblRowNumber" Text='<%# Container.ItemIndex + 1 %>' runat="server" />
                                                                    </td>
                                                                    <td>
                                                                        <%#Eval("IDNo")%>
                                                                    </td>
                                                                    <td>
                                                                        <%#Eval("MemName")%>
                                                                    </td>
                                                                    <td>
                                                                        <%#Eval("Refformno")%>
                                                                    </td>
                                                                    <td>
                                                                        <%#Eval("Doj")%>
                                                                    </td>
                                                                    <td>
                                                                        <%#Eval("KitName")%>
                                                                    </td>
                                                                    <td>
                                                                        <%#Eval("TopupDate")%>
                                                                    </td>
                                                                    <td>
                                                                        <%#Eval("KitAmount")%>
                                                                    </td>
                                                                    <td>
                                                                        <%#Eval("Bv") %>
                                                                    </td>
                                                                </tr>
                                                            </ItemTemplate>
                                                        </asp:Repeater>
                                                    </tbody>
                                                </table>
                                                <%--</ContentTemplate>
            <Triggers>
            </Triggers>
        </asp:UpdatePanel>--%>
                                                <div style="margin-top: 10px; text-align: center;">
                                                    <asp:Button ID="Btnrightpre" runat="server" Text="Previous" OnClick="Btnrightpre_Click" class="btn btn-primary" />
                                                    <asp:Label ID="lblright" runat="server" Text=""></asp:Label>
                                                    <asp:Button ID="Btnrightnxt" runat="server" Text="Next" OnClick="Btnrightnxt_Click" class="btn btn-primary" />
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
