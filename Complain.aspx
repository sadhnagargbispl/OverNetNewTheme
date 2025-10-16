<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Complain.aspx.cs" Inherits="Complain" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container-fluid">
        <!-- BEGIN PAGE HEADER-->
        <div class="row-fluid">
            <div class="span12">
                <%-- <h3 class="page-title">Change Password </h3>--%>
                <ul class="breadcrumb">
                    <li><a href="#"><i class="icon-home"></i></a><span class="divider">&nbsp;</span> </li>
                    <li><a href="#">Raise Ticket</a><span class="divider-last">&nbsp;</span></li>
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
                                    <h4><i class="icon-credit-card"></i>Raise Ticket</h4>
                                    <span class="tools">
                                        <a href="javascript:;" class="icon-chevron-down"></a>
                                    </span>
                                </div>
                                <div class="widget-body">
                                    <div class="form-horizontal">
                                        <div style="margin-bottom: 30px;">
                                            <div class="clr">
                                                <asp:Label ID="Label2" runat="server" CssClass="error"></asp:Label>
                                                <asp:HiddenField ID="HdnCheckTrnns" runat="server" />
                                            </div>
                                        </div>
                                        <div id="DivError" runat="server" visible="false">
                                            <span id="spanError" runat="server"></span>
                                        </div>
                                        <div class="span12">
                                            <asp:Label ID="LblCompalin" runat="server" Visible="false"></asp:Label>
                                            <asp:Label ID="Lblgroup" runat="server" Visible="false"></asp:Label>
                                        </div>

                                        <div class="control-group">
                                            <label class="control-label">
                                                Username :<span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                            <div class="controls">
                                                <asp:TextBox ID="TxtDirectSeller" Enabled="false" runat="server" CssClass="input-xxlarge"
                                                    PlaceHolder="Username" AutoPostBack="true" OnTextChanged="TxtDirectSeller_TextChanged"></asp:TextBox>
                                            </div>
                                        </div>

                                        <div class="control-group ">
                                            <label class="control-label">
                                                Name <span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                            <div class="controls">
                                                <asp:TextBox ID="TxtName" Enabled="false" runat="server" CssClass="input-xxlarge" PlaceHolder="Name"
                                                    ValidationGroup="Save"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="control-group ">
                                            <label class="control-label">
                                                Mobile No<span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                            <div class="controls">
                                                <%--<asp:TextBox ID="TxtDoj" CssClass="input-xxlarge" runat="server" ValidationGroup="eInformation"
                                                ReadOnly="true"></asp:TextBox>--%>
                                                <asp:TextBox ID="TxtMobl" Enabled="false" runat="server" CssClass="input-xxlarge" PlaceHolder="Mobile No"
                                                    ValidationGroup="Save"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-sm-12" style="display: none;">
                                            <div class="col-sm-6">
                                                Email ID : *
                                            </div>
                                            <div class="col-sm-6">
                                                <asp:TextBox ID="TxtEmail" Enabled="false" runat="server" CssClass="input-xxlarge" PlaceHolder="Email Id"
                                                    ValidationGroup="Save"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="control-group ">
                                            <label class="control-label">
                                                Nature of Grievance <span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                            <div class="controls">
                                                <asp:DropDownList ID="CmbCmplntType" runat="server" placeholder="Nature of Grievance "
                                                    class="input-xxlarge">
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="col-sm-12" style="display: none;">
                                            <div class="col-sm-6">
                                                Subject : *
                                            </div>
                                            <div class="col-sm-6">
                                                <asp:TextBox ID="TxtSubject" runat="server" CssClass="input-xxlarge validate[required]"
                                                    PlaceHolder="Subject" ValidationGroup="Save" Text="aa"></asp:TextBox>
                                                <%--  <input type="email" class="input-xxlarge" id="email" placeholder="Subject">--%>
                                            </div>
                                        </div>
                                        <div class="control-group ">
                                            <label class="control-label">
                                                Description<span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                            <div class="controls">
                                                <asp:TextBox ID="TxtDesc" runat="server" TextMode="MultiLine" CssClass="input-xxlarge validate[required]"
                                                    placeholder="Description" ValidationGroup="Save" onkeyup="CountChar();" MaxLength="500"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="control-group ">
                                            <asp:Button ID="BtnSubMit" runat="server" Text="Submit" class="btn" ValidationGroup="Save" OnClick="BtnSubMit_Click" />
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
