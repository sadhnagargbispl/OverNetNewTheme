<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="PinGenerate.aspx.cs" Inherits="PinGenerate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="container-fluid">
        <!-- BEGIN PAGE HEADER-->
        <div class="row-fluid">
            <div class="span12">
                <%-- <h3 class="page-title">Change Password </h3>--%>
                <ul class="breadcrumb">
                    <li><a href="#"><i class="icon-home"></i></a><span class="divider">&nbsp;</span> </li>
                    <li><a href="#">Pin Generate</a><span class="divider-last">&nbsp;</span></li>
                </ul>
            </div>
        </div>
        <div>

            <div class="row-fluid panelpart">

                <div class="row-fluid panelpart">

                    <div class="row">

                        <div class="span12">

                            <div class="widget">
                                <div class="widget-title">
                                    <h4><i class="icon-credit-card"></i>PIN Generate</h4>
                                    <span class="tools">
                                        <a href="javascript:;" class="icon-chevron-down"></a>
                                    </span>
                                </div>
                                 <asp:HiddenField ID="HdnCheckTrnns" runat="server" />
                                <div class="widget-body">
                                    <div class="clr">
                                        <asp:HiddenField ID="hdnSessn" runat="server" />
                                        <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="14px"
                                            ForeColor="Red"></asp:Label>
                                    </div>
                                    <div class="form-horizontal">

                                        <div class="control-group">
                                            <label class="control-label">
                                                Available Balance : <span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                            <div class="controls">
                                                <asp:TextBox ID="lblAvailable" runat="server" CssClass="input-xxlarge validate[required]"
                                                    Enabled="false"></asp:TextBox>
                                                <asp:Label ID="lblFormno" runat="server" Visible="false"></asp:Label>
                                                <asp:Label ID="LblMobl" runat="server" Visible="false"></asp:Label>
                                            </div>
                                        </div>

                                        <div class="control-group " id="Div1" runat="server">
                                            <label class="control-label">
                                                Package Name <span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                            <asp:DropDownList ID="CmbKit" CssClass="input-xxlarge" runat="server" AutoPostBack="true">
                                            </asp:DropDownList>
                                        </div>
                                        <div class="control-group " runat="server">
                                            <label class="control-label">
                                                Quantity <span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                            <div class="controls">
                                                <asp:TextBox ID="TxtQty" runat="server" class="input-xxlarge" Text="0" onkeypress="return isNumberKey(event);"></asp:TextBox>
                                                <div id="TDTotalAmount" runat="server">
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="* Enter Quantity Properly!!"
                                                        ControlToValidate="TxtQty"></asp:RequiredFieldValidator>
                                                </div>
                                                <asp:Label ID="LblAmount" runat="server" Visible="false"></asp:Label>
                                                <asp:Label ID="LblAmountUse" runat="server" Visible="false"></asp:Label>
                                            </div>
                                        </div>

                                        <div class="control-group ">
                                            <label class="control-label">Transaction Password:<span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                            <div class="controls">
                                                <asp:TextBox ID="TxtPassword" runat="server" CssClass="input-xxlarge" TextMode="Password"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="control-group ">
                                            <asp:Button ID="BtnGenerate" runat="server" Text="Generate" class="btn" ValidationGroup="Validation" OnClick="BtnGenerate_Click" />
                                            <asp:Label ID="LblError" runat="server" Visible="false"></asp:Label>
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
