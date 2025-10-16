<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="profile.aspx.cs" Inherits="profile" %>


<asp:Content ID="content2" ContentPlaceHolderID="head" runat="server">
        <style type="text/css">
        input {
            text-transform: uppercase;
        }
    </style>
    <%--    <script type="text/javascript" src="assets/jquery.min.js">
    </script>

    <script type="text/javascript" src="assets/jquery.validationEngine-en.js"></script>

    <script type="text/javascript" src="assets/jquery.validationEngine.js"></script>

    <link href="assets/validationEngine.jquery.min.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        var jq = $.noConflict();
        function pageLoad(sender, args) {
            jq(document).ready(function () {

                jq("#aspnetForm").validationEngine('attach', { promptPosition: "topRight" });
            });

            jq("#<%=BtnSubmit.ClientID %>").click(function () {


                var valid = jq("#aspnetForm").validationEngine('validate');
                var vars = jq("#aspnetForm").serialize();
                if (valid == true) {
                    return true;

                } else {
                    return false;
                }
            });
        }


    </script>--%>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container-fluid">
        <!-- BEGIN PAGE HEADER-->
        <div class="row-fluid">
            <div class="span12">
                <h3 class="page-title">Profile </h3>
                <ul class="breadcrumb">
                    <li><a href="#"><i class="icon-home"></i></a><span class="divider">&nbsp;</span> </li>
                    <li><a href="#">Profile</a><span class="divider-last">&nbsp;</span></li>
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
                                    <h4><i class="icon-credit-card"></i>Profile</h4>
                                    <span class="tools">
                                        <a href="javascript:;" class="icon-chevron-down"></a>
                                    </span>
                                </div>
                                <div class="widget-body" >
                                    <div class="form-horizontal">
                                        
                                        <div style="margin-bottom: 30px;">
                                            <span id="ctl00_ContentPlaceHolder1_lblMsg" style="color: #C00000;"></span>
                                        </div>

                                        <div class="control-group">
                                            <label class="control-label">
                                                Sponsor ID <span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                            <div class="controls">
                                                <asp:TextBox ID="txtReferalId" CssClass="input-xxlarge" runat="server" AutoPostBack="True"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label ">
                                                Registration As</label>
                                            <div class="controls">
                                                <asp:RadioButtonList ID="RbCategory" runat="server" RepeatDirection="Horizontal"
                                                    AutoPostBack="true">
                                                    <asp:ListItem Text="Distributer" Value="D" Selected="True"></asp:ListItem>
                                                    <asp:ListItem Text="Client" Value="A"></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                        </div>
                                        <div class="control-group" id="DivSponsorName" runat="server" visible="false">
                                            <label class="control-label">
                                                Sponsor Name <span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                            <div class="controls">
                                                <asp:TextBox ID="TxtReferalNm" class="input-xxlarge" runat="server" Enabled="False"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="control-group" id="DivUplinerId" runat="server" visible="false">
                                            <label class="control-label">
                                                Placement ID<span class="red">*</span></label>
                                            <asp:TextBox ID="TxtUplinerid" class="input-xxlarge" runat="server" AutoPostBack="True"
                                                Enabled="False"></asp:TextBox>
                                        </div>
                                        <div class="control-group " id="DivUplinerName" runat="server" visible="false">
                                            <label class="control-label">
                                                Placement Name<span class="red">*</span></label>
                                            <asp:TextBox ID="TxtUplinerName" class="input-xxlarge" runat="server" Enabled="False"></asp:TextBox>
                                        </div>
                                        <div class="control-group greybt" style="display: none">
                                            <label class="control-label">
                                                Position<span class="red">*</span></label>
                                            <asp:TextBox ID="lblPosition" class="input-xxlarge" runat="server" Enabled="false"></asp:TextBox>
                                        </div>
                                        <h4>Personal Detail
                                        </h4>
                                        <div class="control-group ">
                                            <label class="control-label">
                                                Your Name <span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                            <div class="controls">
                                                <asp:HiddenField ID="hdnidno" runat="server"></asp:HiddenField>
                                                <asp:TextBox ID="txtFrstNm" CssClass="input-xxlarge validate[custom[onlyLetterNumberChar]]"
                                                    runat="server" ValidationGroup="eInformation"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="control-group " style="display: none;">
    <label class="control-label">
        Spouse Name <span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
    <div class="controls">
        <asp:TextBox ID="txtSpousename" CssClass="input-xxlarge validate[custom[onlyLetterNumberChar]]"
            runat="server" ValidationGroup="eInformation"></asp:TextBox>
    </div>
</div>
                                        <div class="control-group" id="Div11" runat="server" style="display: none;">
                                            <label class="control-label ">
                                                Gender <span style="color: Red; font-weight: bold; font-size: 1.4em">*</span>
                                            </label>
                                            <div class="controls">
                                                <asp:RadioButtonList ID="RBTtype" runat="server" RepeatColumns="4" RepeatDirection="Horizontal"
                                                    autocomplete="off" TabIndex="3">
                                                    <asp:ListItem Text="Male" Value="M" Selected="True"></asp:ListItem>
                                                    <asp:ListItem Text="Female" Value="F"></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                        </div>
                                        <div class="control-group ">
                                            <label class="control-label">
                                                Date Of Joining <span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                            <div class="controls">
                                                <asp:TextBox ID="TxtDoj" CssClass="input-xxlarge" runat="server" ValidationGroup="eInformation"
                                                    ReadOnly="true"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="control-group ">
                                            <label class="control-label">
                                                Date Of Activation <span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                            <div class="controls">
                                                <asp:TextBox ID="TxtDoa" CssClass="input-xxlarge" runat="server" ValidationGroup="eInformation"
                                                    ReadOnly="true"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="control-group ">
                                            <label class="control-label">
                                                Father's Name</label>

                                            <div class="controls">
                                                <div class="span1">
                                                    <asp:DropDownList CssClass="input-xxlarge" ID="CmbType" runat="server" >
                                                        <asp:ListItem Value="S/O" Text="S/O"></asp:ListItem>
                                                        <asp:ListItem Value="W/O" Text="W/O"></asp:ListItem>
                                                        <asp:ListItem Value="C/O" Text="C/O"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                                <asp:TextBox ID="txtFNm" runat="server" CssClass="input-xxlarge"></asp:TextBox>
                                                <div class="col-sm-10" style="padding-left: 0px;">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="control-group " style="display: none;">
    <label class="control-label">
        Mother's Name</label>

    <div class="controls">
        <%--<div class="span1">
            <asp:DropDownList CssClass="input-xxlarge" ID="DropDownList1" runat="server">
                <asp:ListItem Value="S/O" Text="S/O"></asp:ListItem>
                <asp:ListItem Value="W/O" Text="W/O"></asp:ListItem>
                <asp:ListItem Value="C/O" Text="C/O"></asp:ListItem>
            </asp:DropDownList>
        </div>--%>
        <asp:TextBox ID="TxtMnm" runat="server" CssClass="input-xxlarge"></asp:TextBox>
        <div class="col-sm-10" style="padding-left: 0px;">
        </div>
    </div>
</div>

                                        <div class="control-group " style="display: none;">
                                            <label class="control-label">
                                                Door No. <span class="red">*</span></label>
                                            <asp:TextBox ID="txtDoorNo" onkeypress="return isNumberKey(event);" CssClass="input-xxlarge "
                                                runat="server"></asp:TextBox>
                                        </div>
                                        <div class="control-group " style="display: none;">
                                            <label class="control-label">
                                                Street Name. <span class="red">*</span></label>
                                            <asp:TextBox ID="txtStreetName" CssClass="input-xxlarge validate[required]" runat="server"></asp:TextBox>
                                        </div>
                                        <div class="control-group " style="display: none;">
                                            <label class="control-label">
                                                Area Name <span class="red">*</span></label>
                                            <asp:TextBox ID="txtAreaName" CssClass="input-xxlarge validate[required]" runat="server"></asp:TextBox>
                                        </div>
                                        <div class="control-group " style="display: none;">
                                            <label class="control-label">
                                                Post Office <span class="red">*</span></label>
                                            <asp:TextBox ID="txtLandmark" CssClass="input-xxlarge validate[required]" runat="server"></asp:TextBox>
                                        </div>

                                        <div class="control-group " style="display: none;">
                                            <label class="control-label">
                                                Country <span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                            <div class="controls">
                                                <asp:DropDownList ID="ddlCountryName" runat="server" CssClass="input-xxlarge" AutoPostBack="true">
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="control-group " style="display: none;">
                                            <label class="control-label">
                                                Pin Code <span class="red">*</span></label>
                                            <div class="controls">
                                                <asp:TextBox ID="txtPinCode" onkeypress="return isNumberKey(event);" CssClass="input-xxlarge validate[custom[pincode]]"
                                                    runat="server" MaxLength="6" ValidationGroup="eInformation"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="control-group " style="display: none;">
                                            <label class="control-label">
                                                State<span class="red">*</span></label>
                                            <div class="controls">
                                                <asp:DropDownList ID="ddlState" runat="server" CssClass="input-xxlarge">
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="control-group " style="display: none;">
                                            <label class="control-label">
                                                District <span class="red">*</span></label>
                                            <div class="controls">
                                                <asp:TextBox ID="txtDistrict" CssClass="input-xxlarge" runat="server"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="control-group " style="display: none;">
                                            <label class="control-label ">
                                                City</label>
                                            <div class="controls">
                                                <asp:TextBox ID="ddlTehsil" CssClass="input-xxlarge" runat="server" ValidationGroup="eInformation"
                                                    autocomplete="off" TabIndex="10"></asp:TextBox>
                                                <asp:HiddenField ID="HCityCode" runat="server" />
                                            </div>
                                        </div>

                                        <div class="control-group ">
                                            <label class="control-label">
                                                Mobile No. <span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                            <div class="controls">

                                                <div class="span1">

                                                    <asp:TextBox ID="ddlCountry" CssClass="input-xxlarge"
                                                        runat="server" MaxLength="10" ReadOnly="true"></asp:TextBox>
                                                </div>

                                                <asp:TextBox ID="txtMobileNo" onkeypress="return isNumberKey(event);" CssClass="input-xxlarge validate[required]"
                                                    runat="server" MaxLength="10" ValidationGroup="eInformation"></asp:TextBox>

                                            </div>
                                        </div>

                                        <div class="control-group" style="display: none;">
                                            <label class="control-label">
                                                Mobile No2.</label>
                                            <asp:TextBox ID="txtPhNo" onkeypress="return isNumberKey(event);" CssClass="input-xxlarge"
                                                runat="server" MaxLength="10"></asp:TextBox>
                                        </div>
                                        <div class="control-group greybt">
                                            <label class="control-label">
                                                E-Mail ID <span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                            <div class="controls">
                                                <asp:TextBox ID="txtEMailId" CssClass="input-xxlarge validate[custom[email]]" runat="server"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="control-group  greybt" style="display: none;">
                                            <label class="control-label">
                                                Date of Birth</label>
                                            <div class="controls">
                                                <asp:TextBox ID="TxtDobDate" CssClass="input-xxlarge" runat="server"></asp:TextBox>
                                                <ajaxToolkit:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="TxtDobDate"
                                                    Format="dd-MM-yyyy"></ajaxToolkit:CalendarExtender>
                                            </div>
                                        </div>
                                         <div class="control-group  greybt" style="display: none;">
                                            <label class="control-label">
                                                Date of Marriage</label>
                                            <div class="controls">
                                                <asp:TextBox ID="txtdmarriage" CssClass="input-xxlarge" runat="server"></asp:TextBox>
                                                <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtdmarriage"
                                                    Format="dd-MM-yyyy"></ajaxToolkit:CalendarExtender>
                                            </div>
                                        </div>
                                        <div id="divBankDetail" runat="server">
                                             <h4>Nominee Detail</h4>
                                            <div id="childdiv" runat="server" visible="false" style="display: none;">
                                                <div class="control-group ">
                                                    <label class="control-label">
                                                        Child Name1</label>
                                                    <div class="controls">
                                                        <asp:TextBox ID="txtchild1" CssClass="input-xxlarge validate[custom[onlyLetterNumberChar]]"
                                                            runat="server"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="control-group" id="Div1" runat="server">
                                                    <label class="control-label ">
                                                        Gender child1 <%--<span style="color: Red; font-weight: bold; font-size: 1.4em">*</span>--%>
                                                    </label>
                                                    <div class="controls">
                                                        <asp:RadioButtonList ID="rbtchild1type" runat="server" RepeatColumns="4" RepeatDirection="Horizontal"
                                                            autocomplete="off" TabIndex="3">
                                                            <asp:ListItem Text="Male" Value="M" Selected="True"></asp:ListItem>
                                                            <asp:ListItem Text="Female" Value="F"></asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </div>
                                                </div>
                                                <div class="control-group ">
                                                    <label class="control-label">
                                                        Child Name2</label>
                                                    <div class="controls">
                                                        <asp:TextBox ID="txtchild2" CssClass="input-xxlarge validate[custom[onlyLetterNumberChar]]"
                                                            runat="server"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="control-group" id="Div2" runat="server">
                                                    <label class="control-label ">
                                                        Gender child2 <%--<span style="color: Red; font-weight: bold; font-size: 1.4em">*</span>--%>
                                                    </label>
                                                    <div class="controls">
                                                        <asp:RadioButtonList ID="rbtchild2type" runat="server" RepeatColumns="4" RepeatDirection="Horizontal"
                                                            autocomplete="off" TabIndex="3">
                                                            <asp:ListItem Text="Male" Value="M" Selected="True"></asp:ListItem>
                                                            <asp:ListItem Text="Female" Value="F"></asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </div>
                                                </div>
                                                <div class="control-group ">
                                                    <label class="control-label">
                                                        Child Name3</label>
                                                    <div class="controls">
                                                        <asp:TextBox ID="txtchild3" CssClass="input-xxlarge validate[custom[onlyLetterNumberChar]]"
                                                            runat="server"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="control-group" id="Div3" runat="server">
                                                    <label class="control-label ">
                                                        Gender child3 <%--<span style="color: Red; font-weight: bold; font-size: 1.4em">*</span>--%>
                                                    </label>
                                                    <div class="controls">
                                                        <asp:RadioButtonList ID="rbtchild3type" runat="server" RepeatColumns="4" RepeatDirection="Horizontal"
                                                            autocomplete="off" TabIndex="3">
                                                            <asp:ListItem Text="Male" Value="M" Selected="True"></asp:ListItem>
                                                            <asp:ListItem Text="Female" Value="F"></asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </div>
                                                </div>
                                                <div class="control-group ">
                                                    <label class="control-label">
                                                        Child Name4</label>
                                                    <div class="controls">
                                                        <asp:TextBox ID="txtchild4" CssClass="input-xxlarge validate[custom[onlyLetterNumberChar]]"
                                                            runat="server"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="control-group" id="Div4" runat="server">
                                                    <label class="control-label ">
                                                        Gender child4 <%--<span style="color: Red; font-weight: bold; font-size: 1.4em">*</span>--%>
                                                    </label>
                                                    <div class="controls">
                                                        <asp:RadioButtonList ID="rbtchild4type" runat="server" RepeatColumns="4" RepeatDirection="Horizontal"
                                                            autocomplete="off" TabIndex="3">
                                                            <asp:ListItem Text="Male" Value="M" Selected="True"></asp:ListItem>
                                                            <asp:ListItem Text="Female" Value="F"></asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </div>
                                                </div>
                                             
                                            </div>
                                            <div class="control-group ">
                                                <label class="control-label">
                                                    Nominee Name</label>
                                                <div class="controls">
                                                    <asp:TextBox ID="txtNominee" CssClass="input-xxlarge validate[custom[onlyLetterNumberChar]]"
                                                        runat="server"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="control-group greybt ">
                                                <label class="control-label">
                                                    Relation</label>
                                                <div class="controls">
                                                    <asp:TextBox ID="txtRelation" CssClass="input-xxlarge validate[custom[onlyLetterNumberChar]]"
                                                        runat="server"></asp:TextBox>
                                                </div>
                                            </div>
                                           <%-- <h4>Bank Detail</h4>--%>
                                            <div class="control-group" style="display:none;">
                                                <label class="control-label ">
                                                    Account No.</label>
                                                <div class="controls">
                                                    <asp:TextBox ID="TxtAccountNo" onkeypress="return isNumberKey(event);" CssClass="input-xxlarge"
                                                        runat="server" MaxLength="16" autocomplete="off"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="control-group " style="display:none;">
                                                <label class="control-label ">
                                                    Account Type</label>
                                                <div class="controls">
                                                    <asp:DropDownList ID="DDLAccountType" runat="server" CssClass="input-xxlarge">
                                                        <asp:ListItem Text="CHOOSE ACCOUNT TYPE" Value="0" Selected="True"></asp:ListItem>
                                                        <asp:ListItem Text="SAVING ACCOUNT" Value="SAVING ACCOUNT"></asp:ListItem>
                                                        <asp:ListItem Text="CURRENT ACCOUNT" Value="CURRENT ACCOUNT"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="control-group" style="display:none;">
                                                <label class="control-label ">
                                                    Bank</label>
                                                <div class="controls">
                                                    <asp:DropDownList ID="CmbBank" runat="server" CssClass="input-xxlarge" onchange="FnBankChange(this.value);"
                                                        autocomplete="off">
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="control-group" id="divBank" style="display: none">
                                                <label class="control-label ">
                                                    Bank Name</label>
                                                <div class="controls">
                                                    <asp:TextBox ID="TxtBank" CssClass="input-xxlarge" runat="server" autocomplete="off"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="control-group" style="display:none;">
                                                <label class="control-label ">
                                                    Branch Name</label>
                                                <div class="controls">
                                                    <asp:TextBox ID="TxtBranchName" CssClass="input-xxlarge" runat="server" autocomplete="off"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="control-group" style="display:none;">
                                                <label class="control-label ">
                                                    IFSC Code
                                                </label>
                                                <div class="controls">
                                                    <asp:TextBox ID="txtIfsCode" runat="server" CssClass="input-xxlarge" autocomplete="off"></asp:TextBox>
                                                    <%--<asp:RegularExpressionValidator
                                                        ID="regexIFSC"
                                                        runat="server"
                                                        ControlToValidate="txtIfsCode"
                                                        ErrorMessage="Invalid IFSC Code"
                                                        ValidationExpression="^[A-Z]{4}0[A-Z0-9]{6}$"
                                                        ForeColor="Red"
                                                        Display="Dynamic" />
                                                    <asp:RequiredFieldValidator
                                                        ID="requiredIFSC"
                                                        runat="server"
                                                        ControlToValidate="txtIfsCode"
                                                        ErrorMessage="IFSC Code is required"
                                                        ForeColor="Red"
                                                        Display="Dynamic" />--%>
                                                </div>
                                            </div>
                                            <div class="control-group" visible="false">
                                                <asp:TextBox ID="TxtMICR" CssClass="input-xxlarge" Visible="false" runat="server"
                                                    autocomplete="off"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div id="Div22" class="control-group " runat="server" visible="false" >
                                            <label class="control-label ">
                                                PAN No.<span style="color: Red; font-weight: bold; font-size: 1.4em">*</span>
                                            </label>
                                            <div class="controls">
                                                <asp:TextBox ID="txtPanNo" RepeatDirection="Horizontal" CssClass="input-xxlarge validate[custom[panno]]"
                                                    runat="server" autocomplete="off" TabIndex="13"></asp:TextBox>
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Please check PAN Format"
                                                    Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtPanNo" ValidationExpression="[A-Za-z]{5}\d{4}[A-Za-z]{1}"
                                                    ValidationGroup="eInformation"></asp:RegularExpressionValidator>
                                            </div>
                                        </div>
                                        <div class="control-group greybt " style="display: none;">
                                            <label class="control-label">
                                                Wallet Address
                                            </label>
                                            <asp:TextBox ID="TxtWalletAddress" CssClass="input-xxlarge validate[required]" runat="server"></asp:TextBox>
                                        </div>

                                        
                                        <div class="control-group " runat="server" id="divSendOtp">
                                            <asp:Button ID="BtnSubmit" runat="server" Text="Update" CssClass="btn btn-primary"
                                                ValidationGroup="eInformation" OnClick="BtnSubmit_Click" />

                                        </div>
                                        <div runat="server" id="divotp" visible="false">
                                            <div class="control-group">
                                                <label for="idproof">
                                                    Enter Otp*
                                                </label>
                                                <asp:TextBox ID="TxtOtp" CssClass="input-xxlarge" onkeypress="return isNumberKey(event);"
                                                    runat="server" TextMode="Password"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" Display="None" ControlToValidate="TxtOtp"
                                                    runat="server" ErrorMessage="Otp Required" SetFocusOnError="true" ValidationGroup="Save1">                                
                                                </asp:RequiredFieldValidator>
                                                <b>
                                                    <asp:Label ID="lblOtp" runat="server" Text="Label" Visible="false"></asp:Label></b>
                                            </div>
                                            <div class="control-group ">

                                                <asp:ValidationSummary ID="ValidationSummary2" runat="server" ShowMessageBox="True"
                                                    ShowSummary="False" ValidationGroup="eInformation" />
                                            </div>
                                        </div>
                                        <div class="control-group ">
                                            <asp:Button ID="BtnOtp" runat="server" Text="Update" class="btn btn-primary" Visible="False"
                                                ValidationGroup="Save" OnClick="BtnOtp_Click" />

                                            <asp:Button ID="ResendOtp" runat="server" Text="Resend Otp" class="btn btn-primary"
                                                Visible="False" OnClick="ResendOtp_Click" />
                                            &nbsp;<asp:Button ID="CmdCancel" runat="server" Text="Cancel" CssClass="btn btn-primary"
                                                ValidationGroup="Form-Reset" Visible="false" />
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

