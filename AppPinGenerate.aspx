<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="AppPinGenerate.aspx.cs" Inherits="AppPinGenerate" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid panelpart">

        <div class="row">

            <div class="span12">

                <div class="form-card">
                    <div class="widget-title">
                        <h4><i class="icon-credit-card"></i>PIN Generate</h4>
                        <span class="tools">
                            <a href="javascript:;" class="icon-chevron-down"></a>
                        </span>
                    </div>
                    <div class="widget-body">
                        <div class="content-card">
                            <asp:HiddenField ID="hdnSessn" runat="server" />
                            <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="14px"
                                ForeColor="Red"></asp:Label>
                            <div class="form-horizontal">
                                <asp:HiddenField ID="HdnCheckTrnns" runat="server" />
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
        </div>
        <div class="clearfix"></div>
        <p>&nbsp;</p>
        <hr>
        <div class="clearfix"></div>
    </div>















</asp:Content>
