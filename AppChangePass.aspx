<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="AppChangePass.aspx.cs" Inherits="AppChangePass" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid panelpart">

        <div class="row">

            <div class="span12">

                <div class="form-card">
                    <div class="widget-title">
                        <h4><i class="icon-credit-card"></i>CHANGE PASSWORD</h4>
                        <span class="tools">
                            <a href="javascript:;" class="icon-chevron-down"></a>
                        </span>
                    </div>
                    <div class="widget-body">
                        <div class="content-card">
                            <div class="form-horizontal">
                                <div style="margin-bottom: 30px;">
                                    <span id="ctl00_ContentPlaceHolder1_lblMsg" style="color: #C00000;"></span>
                                    <asp:Label ID="lblErrorMessage" runat="server" Text="" CssClass="error-message"></asp:Label>
                                </div>

                                <div class="control-group">
                                    <label class="control-label">
                                        Old Password<span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                    <div class="controls">
                                        <%-- <asp:TextBox ID="txtReferalId" CssClass="input-xxlarge" runat="server" AutoPostBack="True"></asp:TextBox>--%>
                                        <asp:TextBox ID="oldpass" class="input-xxlarge" TextMode="Password"
                                            runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" Display="Dynamic" ControlToValidate="oldpass"
                                            runat="server">Old Password can't left blank</asp:RequiredFieldValidator>
                                    </div>
                                </div>

                                <div class="control-group ">
                                    <label class="control-label">
                                        New Password <span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                    <div class="controls">
                                        <asp:HiddenField ID="hdnidno" runat="server"></asp:HiddenField>
                                        <%-- <asp:TextBox ID="txtFrstNm" CssClass="input-xxlarge validate[custom[onlyLetterNumberChar]]"
                                   runat="server" ValidationGroup="eInformation"></asp:TextBox>--%>

                                        <asp:TextBox ID="pass1" TextMode="Password" runat="server" class="input-xxlarge"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" Display="Dynamic" ControlToValidate="pass1"
                                            runat="server" ErrorMessage="RequiredFieldValidator"> New Password Can't left blank</asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="control-group ">
                                    <label class="control-label">
                                        Confirm Password<span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                    <div class="controls">
                                        <%--<asp:TextBox ID="TxtDoj" CssClass="input-xxlarge" runat="server" ValidationGroup="eInformation"
                                   ReadOnly="true"></asp:TextBox>--%>
                                        <asp:TextBox ID="pass2" class="input-xxlarge"
                                            TextMode="Password" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" Display="Dynamic" ControlToValidate="pass1"
                                            runat="server" ErrorMessage="RequiredFieldValidator">confirm New Password can't left blank</asp:RequiredFieldValidator>
                                        <asp:CompareValidator ID="CompareValidator1" ControlToValidate="Pass1" ControlToCompare="Pass2"
                                            Type="String" Operator="Equal" Text="Passwords must match!" runat="Server" />
                                    </div>
                                </div>
                                <div class="control-group ">

                                    <asp:Button ID="BtnUpdate" runat="server" Text="Submit" class="btn" OnClick="BtnUpdate_Click" />

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
