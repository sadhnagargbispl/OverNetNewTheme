<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="AppPinTransfer.aspx.cs" Inherits="AppPinTransfer" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid panelpart">

        <div class="row">

            <div class="span12">

                <div class="form-card">
                    <div class="widget-title">
                        <h4><i class="icon-credit-card"></i>PIN TRANSFER</h4>
                        <span class="tools">
                            <a href="javascript:;" class="icon-chevron-down"></a>
                        </span>
                    </div>
                    <div class="widget-body">
                        <div class="content-card">
                            <div class="form-horizontal">

                                <div class="control-group">
                                    <label class="control-label">
                                        ID No.<span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                    <div class="controls">
                                        <asp:TextBox ID="TxtSerialno" runat="server" class="input-xxlarge validate[required]"
                                            AutoPostBack="true" OnTextChanged="TxtSerialno_TextChanged"></asp:TextBox>
                                        <asp:Label ID="lblFormno" runat="server" Visible="false"></asp:Label>
                                        <asp:Label ID="LblMobl" runat="server" Visible="false"></asp:Label>
                                    </div>
                                </div>
                                <div class="control-group " id="DivMemberName" runat="server">
                                    <label class="control-label">
                                        Distributor Name <span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                    <div class="controls">

                                        <asp:TextBox ID="TxtSpName" runat="server" CssClass="input-xxlarge" Enabled="false"></asp:TextBox>
                                        <asp:HiddenField ID="HdnCheckTrnns" runat="server" />
                                    </div>
                                </div>
                                <div class="control-group " id="Div1" runat="server">
                                    <label class="control-label">
                                        Select kit <span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                    <asp:DropDownList ID="cmbFillItem" CssClass="input-xxlarge" runat="server" AutoPostBack="true">
                                    </asp:DropDownList>
                                </div>
                                <div class="control-group " runat="server">
                                    <label class="control-label">
                                        Quantity <span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                    <div class="controls">
                                        <asp:TextBox ID="txtNormalPin" runat="server" class="input-xxlarge" Text="0" onkeypress="return isNumberKey(event);"></asp:TextBox>
                                        <asp:Label ID="LblAmount" runat="server" Visible="false"></asp:Label>
                                        <asp:Label ID="LblAmountUse" runat="server" Visible="false"></asp:Label>
                                    </div>
                                </div>
                                <div class="control-group ">
                                    <label class="control-label">Remarks <span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                    <div class="controls">
                                        <asp:TextBox ID="TxtRemarks" runat="server" CssClass="input-xxlarge" TextMode="MultiLine"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="control-group ">
                                    <label class="control-label">Transaction Password:<span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                    <div class="controls">
                                        <asp:TextBox ID="TxtPassword" runat="server" CssClass="input-xxlarge" TextMode="Password"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="control-group ">
                                    <asp:Button ID="cmdSave1" runat="server" Text="Submit" class="btn" ValidationGroup="Validation" OnClick="cmdSave1_Click" />
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
