<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Newjoining1.aspx.cs" Inherits="Newjoining1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        input {
            text-transform: uppercase;
        }
    </style>
    <style type="text/css">
        body {
            margin: 0;
            padding: 0;
            font-family: Arial;
        }

        .modal1 {
            position: fixed;
            z-index: 999;
            height: 100%;
            width: 100%;
            top: 0;
            background-color: Black;
            filter: alpha(opacity=60);
            opacity: 0.6;
            -moz-opacity: 0.8;
        }

        .center1 {
            z-index: 1000;
            margin: 300px auto;
            padding: 10px;
            width: 130px;
            background-color: White;
            border-radius: 10px;
            filter: alpha(opacity=100);
            opacity: 1;
            -moz-opacity: 1;
        }

            .center1 img {
                height: 128px;
                width: 128px;
            }
    </style>

    <script type="text/javascript" language="javascript">

        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;

            return true;
        }

        function DivOnOff() {


            if (document.getElementById("<%= chkterms.ClientID %>").checked == true) {


                document.getElementById("DivTerms").style.display = "block";



            }
            else {
                document.getElementById("DivTerms").style.display = "none";
            }
        }

        function FnBankChange(val) {

            if (val == "97") {

                document.getElementById("divBank").style.display = "block";

            }
            else {
                document.getElementById("divBank").style.display = "none";
            }

        }
        function FnVillageChange(val) {

            if (val == "381264") {

                document.getElementById("divVillage").style.display = "block";

            }
            else {
                document.getElementById("divVillage").style.display = "none";
            }

        }
        function FnPostVillageChange(val) {
            var ddlVillage = document.getElementById("<%=DDlPostVillage.ClientID %>");
            var selectedText = ddlVillage.options[ddlVillage.selectedIndex].innerHTML;
            var selectedValue = ddlVillage.value;
            document.getElementById("<%= HPostVillage.ClientID %>").value = selectedValue;
            if (val == "381264") {

                document.getElementById("divPostVillage").style.display = "block";

            }
            else {
                document.getElementById("divPostVillage").style.display = "none";
            }

        }

        function GetSelectedItem() {

            var rb = document.getElementById("<%=RbtMarried.ClientID%>");
            var radio = rb.getElementsByTagName("input");
            var label = rb.getElementsByTagName("label");
            for (var i = 0; i < radio.length; i++) {
                if (radio[i].checked == true) {
                    if (radio[i].value == "Y") {
                        document.getElementById("divMarriageDate").style.display = "block";
                    }
                    else {
                        document.getElementById("divMarriageDate").style.display = "none";
                    }
                }
            }
        }
        function GetRegistrationAs() {

            var rb = document.getElementById("<%=RbCategory.ClientID%>");
            var radio = rb.getElementsByTagName("input");
            var label = rb.getElementsByTagName("label");
            for (var i = 0; i < radio.length; i++) {
                if (radio[i].checked == true) {
                    if (radio[i].value == "IN") {
                        document.getElementById("RegType").style.display = "none";
                        document.getElementById("CompName").style.display = "none";
                        document.getElementById("CompRegistrationNo").style.display = "none";
                        document.getElementById("Div1").style.display = "block";
                        document.getElementById("divFName").style.display = "block";
                        document.getElementById("TrPrtnrCap").style.display = "none";
                        document.getElementById("<%=LblName.ClientID %>").textContent = "";
                        document.getElementById("<%=LblRegistDate.ClientID %>").textContent = "Date Of Birth";
                        var rb = document.getElementById("<%=CbSubCategory.ClientID%>");
                        var radio = rb.getElementsByTagName("input");
                        radio[0].checked = true;
                    }
                    else {
                        document.getElementById("RegType").style.display = "block";
                        document.getElementById("CompName").style.display = "block";
                        document.getElementById("CompRegistrationNo").style.display = "block";
                        document.getElementById("Div1").style.display = "none";
                        document.getElementById("divFName").style.display = "none";
                        document.getElementById("TrPrtnrCap").style.display = "block";
                        document.getElementById("<%=LblName.ClientID %>").textContent = "Properitor ";
                        document.getElementById("<%=LblRegistDate.ClientID %>").textContent = "Date Of Company Registration";
                        var rb = document.getElementById("<%=CbSubCategory.ClientID%>");
                        var radio = rb.getElementsByTagName("input");
                        radio[0].checked = true;
                    }
                }
            }
        }

        function GetRegistrationType() {

            var rb = document.getElementById("<%=CbSubCategory.ClientID%>");
            var radio = rb.getElementsByTagName("input");
            var label = rb.getElementsByTagName("label");
            for (var i = 0; i < radio.length; i++) {
                if (radio[i].checked == true) {
                    if (radio[i].value == "SP") {
                        document.getElementById("Div1").style.display = "none";
                        document.getElementById("divFName").style.display = "none";
                        document.getElementById("TrPrtnrCap").style.display = "none";
                        document.getElementById("<%=LblName.ClientID %>").textContent = "Properitor ";
                        document.getElementById("<%=LblRegistDate.ClientID %>").textContent = "Date Of Company Registration";
                    }
                    else if (radio[i].value == "PF") {
                        document.getElementById("Div1").style.display = "none";
                        document.getElementById("divFName").style.display = "none";
                        document.getElementById("TrPrtnrCap").style.display = "block";
                        document.getElementById("<%=LblName.ClientID %>").textContent = "Partner ";
                        document.getElementById("<%=LblRegistDate.ClientID %>").textContent = "Date Of Company Registration";
                    }
                    else {

                        document.getElementById("Div1").style.display = "none";
                        document.getElementById("divFName").style.display = "none";
                        document.getElementById("TrPrtnrCap").style.display = "none";
                        document.getElementById("<%=LblName.ClientID %>").textContent = "Owner ";
                        document.getElementById("<%=LblRegistDate.ClientID %>").textContent = "Date Of Company Registration";
                    }
                }
            }
        }
        function GetSameAsPostal() {

            if (document.getElementById("<%= ChkSame.ClientID %>").checked == true) {
                document.getElementById("<%= TxtPostalAddress.ClientID %>").value = document.getElementById("<%= txtAddLn1.ClientID %>").value;
                document.getElementById("<%= TxtPostPincode.ClientID %>").value = document.getElementById("<%= txtPinCode.ClientID %>").value;
                <%--document.getElementById("<%= TxtpostState.ClientID %>").value = document.getElementById("<%= txtStateName.ClientID %>").value;--%>
                document.getElementById("<%= HPostStateCode.ClientID %>").value = document.getElementById("<%= StateCode.ClientID %>").value;
                document.getElementById("<%= TxtPostDistrict.ClientID %>").value = document.getElementById("<%= ddlDistrict.ClientID %>").value;
                document.getElementById("<%= HPostDistrict.ClientID %>").value = document.getElementById("<%= HDistrictCode.ClientID %>").value;
                document.getElementById("<%= TxtPostCity.ClientID %>").value = document.getElementById("<%= ddlTehsil.ClientID %>").value;
                document.getElementById("<%= HPostCity.ClientID %>").value = document.getElementById("<%= HCityCode.ClientID %>").value;
                var x = document.getElementById("<%= DDlVillage.ClientID %>").options.length;
                var ddl = document.getElementById("<%= DDlVillage.ClientID %>");
                for (var i = 0; i < x; i++) {
                    document.getElementById("<%= DDlPostVillage.ClientID %>").options[i] = new Option(ddl.options[i].text, ddl.options[i].value);
                }
                var ddlVillage = document.getElementById("<%=DDlVillage.ClientID %>");
                var selectedValue = ddlVillage.value;

                document.getElementById("<%= DDlPostVillage.ClientID %>").value = selectedValue;
                if (selectedValue == "381264") {

                    document.getElementById("<%= DDlPostVillage.ClientID %>").value = selectedValue;
                    document.getElementById("divPostVillage").style.display = "block";

                    document.getElementById("<%= TxtPostVillage.ClientID %>").value = document.getElementById("<%= TxtVillage.ClientID %>").value;
                    document.getElementById("<%= HPostVillage.ClientID %>").value = selectedValue;
                }
                else {
                    document.getElementById("divPostVillage").style.display = "none";
                    document.getElementById("<%= TxtPostVillage.ClientID %>").textcontent = "";
                }
                document.getElementById("<%= HPostVillage.ClientID %>").value = selectedValue;

            }
            else {
                document.getElementById("<%= TxtPostalAddress.ClientID %>").value = "";
                document.getElementById("<%= TxtPostPincode.ClientID %>").value = "";
                document.getElementById("<%= TxtpostState.ClientID %>").value = "";
                document.getElementById("<%= HPostStateCode.ClientID %>").value = "";
                document.getElementById("<%= TxtPostDistrict.ClientID %>").value = "";
                document.getElementById("<%= HPostDistrict.ClientID %>").value = "";
                document.getElementById("<%= TxtPostCity.ClientID %>").value = "";
                document.getElementById("<%= HPostCity.ClientID %>").value = "";
                document.getElementById("<%= HPostVillage.ClientID %>").value = "";
                document.getElementById("divPostVillage").style.display = "none";
                document.getElementById("<%= TxtPostVillage.ClientID %>").textcontent = "";
                var rmOption = document.getElementById("<%= DDlPostVillage.ClientID %>");
                var x = document.getElementById("<%= DDlPostVillage.ClientID %>").options.length;



                for (var i = 0; i < x; i++) {

                    rmOption.remove(0);
                }

            }
        }


    </script>

    <script type="text/javascript" src="assets/jquery.min.js">
    </script>

    <%--   <script type="text/javascript" src="js/plugins/jquery/jquery.min.js"></script>--%>

    <script type="text/javascript" src="assets/jquery.validationEngine-en.js"></script>

    <script type="text/javascript" src="assets/jquery.validationEngine.js"></script>

    <link href="assets/validationEngine.jquery.min.css" rel="stylesheet" type="text/css" />

    <%--   <script type="text/javascript">
        var jq = $.noConflict();
        function pageLoad(sender, args) {
            jq(document).ready(function () {

                jq("#aspnetForm").validationEngine('attach', { promptPosition: "topRight" });
            });

            jq("#<%=CmdSave.ClientID %>").click(function () {


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
    <script type="text/javascript">
        function validateNoSpaces(input) {
            // Remove spaces from the input
            input.value = input.value.replace(/\s/g, "");
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="container-fluid">
        <!-- BEGIN PAGE HEADER-->
        <div class="row-fluid">
            <div class="span12">
                <!-- BEGIN THEME CUSTOMIZER-->
                <!-- END THEME CUSTOMIZER-->
                <!-- BEGIN PAGE TITLE & BREADCRUMB-->
                <h3 class="page-title">Registration </h3>
                <ul class="breadcrumb">
                    <li><a href="#"><i class="icon-home"></i></a><span class="divider">&nbsp;</span> </li>
                    <li><a href="#">Registration</a><span class="divider-last">&nbsp;</span></li>
                </ul>

                <!-- END PAGE TITLE & BREADCRUMB-->

            </div>
        </div>

        <!--<div id="ctl00_ContentPlaceHolder1_Div2" class="alert alert-info">        
        <b>
        <span id="ctl00_ContentPlaceHolder1_Label2">Limited period special offer to activate/upgrade on purchasing of 'Impact Garments combo Rs.3500/- with 5100BV'</span></b></div>-->

        <div>

            <div class="row-fluid panelpart">

                <div class="row-fluid panelpart">

                    <div class="row">

                        <div class="span12">

                            <div class="widget">
                                <div class="widget-title">
                                    <h4><i class="icon-credit-card"></i>Registration</h4>
                                    <span class="tools">
                                        <a href="javascript:;" class="icon-chevron-down"></a>
                                    </span>
                                </div>
                                <div class="widget-body" style="display: ">
                                    <div class="form-horizontal">
                                        <div style="margin-bottom: 30px;">
                                            <span id="ctl00_ContentPlaceHolder1_lblMsg" style="color: #C00000;"></span>
                                        </div>

                                        <div class="control-group">
                                            <label class="control-label">Sponsor ID <span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                            <div class="controls">
                                                <asp:TextBox ID="txtRefralId" CssClass="input-xxlarge validate[required,custom[onlyLetterNumber]]"
                                                    runat="server" AutoPostBack="True" ValidationGroup="eInformation" autocomplete="off" OnTextChanged="txtRefralId_TextChanged" TabIndex="1"></asp:TextBox>
                                                <asp:Label ID="lblRefralNm" runat="server" ForeColor="#D11F7B"></asp:Label>
                                                <%--<input name="ctl00$ContentPlaceHolder1$lbldisname" type="text" value="Mr. Click Trade" id="ctl00_ContentPlaceHolder1_lbldisname" disabled="disabled" class="input-xxlarge">--%>
                                            </div>
                                        </div>

                                        <div class="control-group " id="Div10" runat="server" visible="false">
                                            <label class="control-label">
                                                UserName <span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                            <asp:TextBox ID="Txtusername" class="input-xxlarge" runat="server" AutoPostBack="True"
                                                ValidationGroup="eSponsor" autocomplete="off" OnTextChanged="Txtusername_TextChanged" oninput="validateNoSpaces(this)"></asp:TextBox>
                                            <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator4" Display="Dynamic" ControlToValidate="Txtusername"
                                            runat="server" ErrorMessage="RequiredFieldValidator" ForeColor="OrangeRed">Please Enter User Name</asp:RequiredFieldValidator>--%>
                                            <asp:Label ID="Label1" runat="server" ForeColor="#D11F7B"></asp:Label>
                                            <asp:Label ID="LblUseName" runat="server" CssClass="error" Visible="false" ForeColor="OrangeRed"></asp:Label>
                                        </div>
                                        <div class="control-group " id="rwSpnsr" runat="server" visible="false">
                                            <label class="control-label ">
                                                Upliner ID<span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                            <asp:TextBox ID="txtUplinerId" class="input-xxlarge" runat="server" AutoPostBack="True"
                                                ValidationGroup="eSponsor" autocomplete="off"></asp:TextBox>
                                            <asp:Label ID="lblUplnrNm" runat="server" ForeColor="#D11F7B"></asp:Label>
                                        </div>
                                        <div class="control-group " runat="server" id="DivLeg1" style="display: none;">
                                            <label class="control-label ">
                                                Leg <span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                            <div class="col-sm-10">
                                                <asp:RadioButtonList ID="RbtnLegNo" runat="server" RepeatDirection="Horizontal" Style="width: 150px" />
                                            </div>
                                        </div>
                                        <%-- <h4>Personal Detail</h4>--%>
                                        <div id="dvreg" runat="server" visible="true">
                                            <div class="control-group ">
                                                <label class="control-label ">
                                                    Registration As</label>
                                                <asp:RadioButtonList ID="RbCategory" runat="server" RepeatDirection="Horizontal"
                                                     AutoPostBack="true" >
                                                    <asp:ListItem Text="Distributer" Value="D" Selected="True"></asp:ListItem>
                                                    <asp:ListItem Text="Client" Value="A"></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                            <div class="control-group" id="RegType" style="display: none">
                                                <label class="control-label ">
                                                    <asp:Label ID="LblRegType" Text="Registration Type" runat="server"></asp:Label></label>
                                                <asp:RadioButtonList ID="CbSubCategory" runat="server" RepeatDirection="Horizontal"
                                                    onchange="return GetRegistrationType()">
                                                    <asp:ListItem Text="ProprietorShip" Value="SP" Selected="True"></asp:ListItem>
                                                    <asp:ListItem Text="Partnership Firm" Value="PF"></asp:ListItem>
                                                    <asp:ListItem Text="Private Limited Company" Value="PL"></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                        </div>
                                        <%--<div class="control-group">
                                            <label>
                                                User Name<span style="color: Red; font-weight: bold; font-size: 1.4em">*</span>
                                            </label>
                                          
                                                <asp:TextBox ID="txtUName" CssClass="input-xxlarge validate[required,custom[onlyLetterNumber]]"
                                                     runat="server" MaxLength="20" autocomplete="off" AutoPostBack="true"
                                                    oninput="this.value = this.value.toUpperCase()"></asp:TextBox>
                                            </div>--%>
                                        <div class="control-group">
                                            <label class="control-label">
                                                <asp:Label ID="LblName" runat="server"></asp:Label>Full Name <span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                            <div class="controls">
                                                <asp:TextBox ID="txtFrstNm" class="input-xxlarge" runat="server" ValidationGroup="eInformation"
                                                    autocomplete="off" CssClass="input-xxlarge validate[required,custom[onlyLetterNumberChar]]" TabIndex="2"></asp:TextBox>
                                                <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator5" Display="Dynamic" ControlToValidate="txtFrstNm"
                                            runat="server" ErrorMessage="RequiredFieldValidator" ForeColor="OrangeRed">Please Enter Full Name</asp:RequiredFieldValidator>--%>
                                            </div>
                                        </div>
                                        <div class="control-group" id="Div11" runat="server">
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
                                        <div class="control-group" id="TrPrtnrCap" style="display: none">
                                            <label class="control-label ">
                                                <asp:Label ID="LblPartnerName" runat="server" Text="Partner Name Seperated By Comma(,)"></asp:Label></label>
                                        </div>
                                        <div class="control-group " id="divFName" runat="server" visible="false">
                                            <label class="control-label ">
                                                Father/HUSBAND's Name</label>
                                            <div class="row">
                                                <div class="col-sm-3">
                                                    <asp:DropDownList CssClass="input-xxlarge" ID="CmbType" runat="server">
                                                        <asp:ListItem Value="S/O" Text="S/O"></asp:ListItem>
                                                        <asp:ListItem Value="D/O" Text="D/O"></asp:ListItem>
                                                        <asp:ListItem Value="W/O" Text="W/O"></asp:ListItem>
                                                        <asp:ListItem Value="H/O" Text="H/O"></asp:ListItem>
                                                        <asp:ListItem Value="C/O" Text="C/O"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                                <div class="col-sm-9" style="padding-left: 0px;">
                                                    <asp:TextBox ID="txtFNm" runat="server" class="input-xxlarge" autocomplete="off"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div id="Div1" class="control-group " visible="false" runat="server">
                                            <label class="control-label ">
                                                <asp:Label ID="LblRegistDate" runat="server" Text="Date Of Birth"></asp:Label></label>
                                            <div class="row">
                                                <div class="col-sm-4  p0 pl10">
                                                    <asp:DropDownList ID="ddlDOBdt" runat="server" CssClass="input-xxlarge" autocomplete="off">
                                                    </asp:DropDownList>
                                                </div>
                                                <div class="col-sm-4  p0 pl10">
                                                    <asp:DropDownList ID="ddlDOBmnth" runat="server" CssClass="input-xxlarge" autocomplete="off">
                                                    </asp:DropDownList>
                                                </div>
                                                <div class="col-sm-4  p0 pl10">
                                                    <asp:DropDownList ID="ddlDOBYr" runat="server" Style="padding-right: 30px;" CssClass="input-xxlarge"
                                                        autocomplete="off">
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="control-group" id="Div2" visible="false" runat="server">
                                            <label class="control-label ">
                                                <span style="color: Red; font-weight: bold; font-size: 1.4em">*</span>
                                            </label>
                                            <asp:RadioButtonList ID="RbtMarried" runat="server" RepeatColumns="2" RepeatDirection="Horizontal"
                                                RepeatLayout="Flow" onchange="return GetSelectedItem()" autocomplete="off">
                                                <asp:ListItem Text="Married" Value="Y"></asp:ListItem>
                                                <asp:ListItem Text="UnMarried" Value="N"></asp:ListItem>
                                            </asp:RadioButtonList>
                                            <span class="red"></span>
                                        </div>
                                        <div class="control-group " id="divMarriageDate" visible="false" style="display: none;">
                                            <label class="control-label ">
                                                Marriage Date</label>
                                            <div class="row">
                                                <div class="col-sm-4  p0 pl10">
                                                    <asp:DropDownList ID="DDlMDay" runat="server" CssClass="input-xxlarge">
                                                    </asp:DropDownList>
                                                </div>
                                                <div class="col-sm-4  p0 pl10">
                                                    <asp:DropDownList ID="DDLMMonth" runat="server" CssClass="input-xxlarge">
                                                    </asp:DropDownList>
                                                </div>
                                                <div class="col-sm-4  p0 pl10">
                                                    <asp:DropDownList ID="DDLMYear" runat="server" Style="padding-right: 30px;" CssClass="input-xxlarge">
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="control-group" id="CompName" style="display: none">
                                            <label class="control-label ">
                                                Company Name
                                            </label>
                                            <asp:TextBox ID="TxtCompanyName" runat="server" CssClass="input-xxlarge"></asp:TextBox>
                                        </div>
                                        <div class="control-group" id="CompRegistrationNo" style="display: none">
                                            <label class="control-label ">
                                                Company Registration No
                                            </label>
                                            <asp:TextBox ID="TxtRegistrationNo" runat="server" CssClass="input-xxlarge"></asp:TextBox>
                                        </div>

                                        <div class="control-group">
                                            <label class="control-label">
                                                Country Name<span style="color: Red; font-weight: bold; font-size: 1.4em">*</span>
                                            </label>
                                            <div class="controls">
                                                <asp:DropDownList ID="ddlCountryNAme" runat="server" CssClass="input-xxlarge" AutoPostBack="true" OnSelectedIndexChanged="ddlCountryNAme_SelectedIndexChanged" TabIndex="4">
                                                </asp:DropDownList>
                                                <%-- <asp:RequiredFieldValidator ID="rfvCountry" runat="server" ControlToValidate="ddlCountryNAme"
                                            ErrorMessage="Please select a country." InitialValue="0" Display="Dynamic" ForeColor="OrangeRed"></asp:RequiredFieldValidator>--%>
                                            </div>
                                        </div>
                                        <div class="control-group ">
                                            <label class="control-label ">
                                                Pin code<span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                            <div class="controls">
                                                <asp:TextBox ID="txtPinCode" CssClass="input-xxlarge" onkeypress="return isNumberKey(event);"
                                                    runat="server" MaxLength="6" autocomplete="off" TabIndex="7"></asp:TextBox>
                                            </div>
                                        </div>
                                        <%-- </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="CmdSave" EventName="Click" />
        </Triggers>
    </asp:UpdatePanel>
    <asp:UpdatePanel ID="UpdatePanel19" runat="server">
        <ContentTemplate>--%>
                                        <div class="control-group ">
                                            <label class="control-label ">
                                                State<span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label><%--<asp:TextBox ID="txtStateName" runat="server" CssClass="input-xxlarge"
            autocomplete="off" ></asp:TextBox>--%>
                                            <div class="controls">
                                                <asp:DropDownList ID="ddlStatename" runat="server" CssClass="input-xxlarge" TabIndex="8" AutoPostBack="true" OnTextChanged="ddlStatename_TextChanged">
                                                </asp:DropDownList>
                                                <asp:HiddenField ID="StateCode" runat="server" />
                                            </div>
                                        </div>
                                        <div class="control-group ">
                                            <label class="control-label ">
                                                District<span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                            <div class="controls">
                                                <asp:TextBox ID="ddlDistrict" CssClass="input-xxlarge validate[required]" runat="server" autocomplete="off" TabIndex="9" ></asp:TextBox>
                                                <asp:HiddenField ID="HDistrictCode" runat="server" />
                                            </div>
                                        </div>
                                        <div class="control-group ">
                                            <label class="control-label ">
                                                City<span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                            <div class="controls">
                                                <asp:TextBox ID="ddlTehsil" CssClass="input-xxlarge validate[required]" runat="server" ValidationGroup="eInformation"
                                                    autocomplete="off" TabIndex="10"></asp:TextBox>
                                                <asp:HiddenField ID="HCityCode" runat="server" />
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label">
                                                Mobile No.<span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                            <div class="controls">

                                                <div class="span1">
                                                    <asp:TextBox ID="ddlMobileNAme" CssClass="input-xxlarge " runat="server" ValidationGroup="eInformation"
                                                        autocomplete="off" Enabled="false" TabIndex="5"></asp:TextBox>
                                                </div>


                                                <asp:TextBox ID="txtMobileNo" onkeypress="return isNumberKey(event);" CssClass="input-xxlarge validate[required,custom[mobile]]"
                                                    runat="server" ValidationGroup="eInformation" autocomplete="off" MaxLength="10" TabIndex="6"></asp:TextBox>

                                                <asp:Label ID="LblMobile" runat="server" CssClass="error" Visible="false" ForeColor="OrangeRed"></asp:Label>
                                                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator6" Display="Dynamic" ControlToValidate="txtMobileNo"
                                                    runat="server" ErrorMessage="RequiredFieldValidator" ForeColor="OrangeRed">Please Enter Mobile No</asp:RequiredFieldValidator>--%>
                                            </div>
                                        </div>
                                        <div id="Div4" class="control-group" visible="false" runat="server">
                                            <label class="control-label ">
                                                Phone No.</label>
                                            <asp:TextBox ID="txtPhNo" onkeypress="return isNumberKey(event);" CssClass="input-xxlarge"
                                                runat="server" MaxLength="10" autocomplete="off"></asp:TextBox>
                                        </div>
                                        <div id="dvpin" runat="server">
                                            <%--<h4>Contact Detail</h4>--%>
                                            <%--  <h5>
Permanent Address</h5>--%>
                                            <div id="Div3" class="control-group " visible="false" runat="server">
                                                <label class="control-label ">
                                                    Address</label>
                                                <asp:TextBox ID="txtAddLn1" CssClass="input-xxlarge" runat="server" autocomplete="off"></asp:TextBox>
                                            </div>
                                            <%--<asp:UpdatePanel ID="UpdatePanel3" runat="server">
                        <ContentTemplate>--%>

                                            <div class="control-group " style="display: none;">
                                                <label class="control-label ">
                                                    Area</label>
                                                <asp:DropDownList ID="DDlVillage" CssClass="input-xxlarge" runat="server" ValidationGroup="eInformation"
                                                    autocomplete="off" onchange="FnVillageChange(this.value);">
                                                </asp:DropDownList>
                                            </div>
                                            <div class="control-group" id="divVillage" style="display: none">
                                                <label class="control-label ">
                                                    Area Name</label>
                                                <asp:TextBox ID="TxtVillage" CssClass="input-xxlarge" runat="server" autocomplete="off"></asp:TextBox>
                                            </div>
                                            <%--</ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="txtPinCode" EventName="TextChanged" />
                            <asp:AsyncPostBackTrigger ControlID="CmdSave" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>--%>
                                            <div id="Dvfld" runat="server" visible="false">
                                                <div class="control-group">
                                                    <label class="control-label ">
                                                        Same As Above<span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                                    <asp:CheckBox ID="ChkSame" runat="server" onclick="return GetSameAsPostal()" />
                                                </div>
                                                <h5>Postal Address</h5>
                                                <div class="control-group ">
                                                    <label class="control-label ">
                                                        Address</label>
                                                    <asp:TextBox ID="TxtPostalAddress" CssClass="input-xxlarge" runat="server" autocomplete="off"></asp:TextBox>
                                                </div>
                                                <%--      <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                            <ContentTemplate>--%>
                                                <div class="control-group ">
                                                    <label class="control-label ">
                                                        Pin code<span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                                    <asp:TextBox ID="TxtPostPincode" CssClass="input-xxlarge" onkeypress="return isNumberKey(event);"
                                                        runat="server" MaxLength="6" autocomplete="off" AutoPostBack="true"></asp:TextBox>
                                                </div>
                                                <%--</ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="CmdSave" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                            <ContentTemplate>--%>
                                                <div class="control-group ">
                                                    <label class="control-label ">
                                                        State</label><asp:TextBox ID="TxtpostState" runat="server" CssClass="input-xxlarge"
                                                            autocomplete="off" Enabled="false"></asp:TextBox>
                                                    <asp:HiddenField ID="HPostStateCode" runat="server" />
                                                </div>
                                                <div class="control-group ">
                                                    <label class="control-label ">
                                                        District<span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                                    <asp:TextBox ID="TxtPostDistrict" CssClass="input-xxlarge validate[required]" runat="server" autocomplete="off"
                                                        Enabled="false"></asp:TextBox>
                                                    <asp:HiddenField ID="HPostDistrict" runat="server" />
                                                </div>
                                                <div class="control-group ">
                                                    <label class="control-label ">
                                                        City<span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                                    <asp:TextBox ID="TxtPostCity" CssClass="input-xxlarge validate[required]" runat="server" ValidationGroup="eInformation"
                                                        autocomplete="off" Enabled="false"></asp:TextBox>
                                                    <asp:HiddenField ID="HPostCity" runat="server" />
                                                </div>
                                                <div class="control-group ">
                                                    <label class="control-label ">
                                                        Area</label>
                                                    <asp:DropDownList ID="DDlPostVillage" CssClass="input-xxlarge" runat="server" ValidationGroup="eInformation"
                                                        autocomplete="off" onchange="FnPostVillageChange(this.value);">
                                                    </asp:DropDownList>
                                                    <asp:HiddenField ID="HPostVillage" runat="server" />
                                                </div>
                                                <div class="control-group" id="divPostVillage" style="display: none">
                                                    <label class="control-label ">
                                                        Area Name</label>
                                                    <asp:TextBox ID="TxtPostVillage" CssClass="input-xxlarge" runat="server" autocomplete="off"></asp:TextBox>
                                                </div>
                                                <%--</ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="TxtPostPincode" EventName="TextChanged" />
                                <asp:AsyncPostBackTrigger ControlID="CmdSave" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>--%>
                                            </div>
                                        </div>
                                        <div id="Div5" class="control-group" runat="server">
                                            <label class="control-label">
                                                E-Mail ID <span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                            <div class="controls">
                                                <asp:TextBox ID="txtEMailId" CssClass="input-xxlarge validate[required,custom[email]]"
                                                    runat="server" autocomplete="off" Style="text-transform: none !important;" TabIndex="11"></asp:TextBox>
                                                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator8" Display="Dynamic" ControlToValidate="txtEMailId"
                                            runat="server" ErrorMessage="RequiredFieldValidator" ForeColor="OrangeRed">Please Enter Email ID</asp:RequiredFieldValidator>--%>
                                                <asp:Label ID="LblEmainID" runat="server" CssClass="error" Visible="false" ForeColor="OrangeRed"></asp:Label>
                                            </div>
                                        </div>
                                        <div id="Div12" class="control-group" runat="server">
                                            <label class="control-label">
                                                Dob <span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                            <div class="controls">
                                                <asp:TextBox ID="txtdob" type="date" runat="server" CssClass="input-xxlarge" onkeypress="return false;" TabIndex="12">
                                                </asp:TextBox>
                                            </div>
                                        </div>
                                        <div id="Div9" class="control-group " runat="server" visible="false">
                                            <label>
                                                Wallet Address <%-- <span style="color: Red; font-weight: bold; font-size: 1.4em">*</span>--%>
                                            </label>
                                            <asp:TextBox ID="TxtWalletaddress" CssClass="input-xxlarge" runat="server" autocomplete="off"
                                                Style="text-transform: none !important;"></asp:TextBox>
                                            <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator9" Display="Dynamic" ControlToValidate="TxtWalletaddress"
                                            runat="server" ErrorMessage="RequiredFieldValidator" ForeColor="OrangeRed">Please Enter Wallet Address</asp:RequiredFieldValidator>--%>
                                            <asp:Label ID="LblWalletaddress" runat="server" CssClass="error" Visible="false" ForeColor="OrangeRed"></asp:Label>
                                            <asp:HiddenField ID="HdnWalletAddress" runat="server" />
                                            <asp:HiddenField ID="HiddenField4" runat="server" />
                                            <asp:HiddenField ID="Hdnhhhgg" runat="server" />
                                        </div>
                                        <div id="Div6" class="control-group" runat="server" visible="false">
                                            <label class="control-label ">
                                                PAN No Available<span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                            <div class="col-sm-10">
                                                <asp:RadioButtonList ID="RbtPan" runat="server" RepeatColumns="2" RepeatDirection="Horizontal"
                                                    RepeatLayout="Table">
                                                    <asp:ListItem Text="Yes" Value="Y" Selected="True"></asp:ListItem>
                                                    <asp:ListItem Text="No" Value="N"></asp:ListItem>
                                                </asp:RadioButtonList>
                                                <span class="red">
                                                    <asp:Label ID="LblPanNoAvail" runat="server" Text="Payout will deduct 20%, If you not enter PAN NO."></asp:Label></span>
                                            </div>
                                        </div>
                                        <div id="Div22" class="control-group " runat="server">
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
                                        <div id="dvname" runat="server" visible="false">
                                            <h4>Nominee Detail</h4>
                                            <div class="control-group">
                                                <label class="control-label ">
                                                    Nominee Name
                                                </label>
                                                <asp:TextBox ID="txtNominee" CssClass="input-xxlarge" runat="server" autocomplete="off"></asp:TextBox>
                                            </div>
                                            <div class="control-group ">
                                                <label class="control-label ">
                                                    Relation</label>
                                                <asp:TextBox ID="txtRelation" CssClass="input-xxlarge" runat="server" autocomplete="off"></asp:TextBox>
                                            </div>
                                            <div id="divBankDetail" runat="server">
                                                <h4>Bank Detail</h4>
                                                <div class="control-group">
                                                    <label class="control-label ">
                                                        Account No.</label>
                                                    <asp:TextBox ID="TxtAccountNo" onkeypress="return isNumberKey(event);" CssClass="input-xxlarge"
                                                        runat="server" MaxLength="16" autocomplete="off"></asp:TextBox>
                                                </div>
                                                <div class="control-group ">
                                                    <label class="control-label ">
                                                        Account Type</label>
                                                    <asp:DropDownList ID="DDLAccountType" runat="server" CssClass="input-xxlarge">
                                                        <asp:ListItem Text="CHOOSE ACCOUNT TYPE" Value="0" Selected="True"></asp:ListItem>
                                                        <asp:ListItem Text="SAVING ACCOUNT" Value="SAVING ACCOUNT"></asp:ListItem>
                                                        <asp:ListItem Text="CURRENT ACCOUNT" Value="CURRENT ACCOUNT"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                                <div class="control-group">
                                                    <label class="control-label ">
                                                        Bank</label>
                                                    <asp:DropDownList ID="CmbBank" runat="server" CssClass="input-xxlarge" onchange="FnBankChange(this.value);"
                                                        autocomplete="off">
                                                    </asp:DropDownList>
                                                </div>
                                                <div class="control-group" id="divBank" style="display: none">
                                                    <label class="control-label ">
                                                        Bank Name</label>
                                                    <asp:TextBox ID="TxtBank" CssClass="input-xxlarge" runat="server" autocomplete="off"></asp:TextBox>
                                                </div>
                                                <div class="control-group">
                                                    <label class="control-label ">
                                                        Branch Name</label>
                                                    <asp:TextBox ID="TxtBranchName" CssClass="input-xxlarge" runat="server" autocomplete="off"></asp:TextBox>
                                                </div>
                                                <div class="control-group">
                                                    <label class="control-label ">
                                                        IFSC Code
                                                    </label>
                                                    <asp:TextBox ID="txtIfsCode" runat="server" CssClass="input-xxlarge" autocomplete="off"></asp:TextBox>
                                                </div>
                                                <div class="control-group" visible="false">
                                                    <asp:TextBox ID="TxtMICR" CssClass="input-xxlarge" Visible="false" runat="server"
                                                        autocomplete="off"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div id="Div7" class="control-group " runat="server" visible="false">
                                                <label class="control-label ">
                                                    AADHAR No.
                                                </label>
                                                <div class="row">
                                                    <div class="col-sm-3  p0 pl10">
                                                        <asp:TextBox ID="TxtAAdhar1" CssClass="input-xxlarge" runat="server" onkeypress="return isNumberKey(event);"
                                                            MaxLength="4" autocomplete="off"></asp:TextBox>
                                                    </div>
                                                    <div class="col-sm-1  p0 pl10" style="text-align: center">
                                                        -
                                                    </div>
                                                    <div class="col-sm-3  p0 pl10">
                                                        <asp:TextBox ID="TxtAadhar2" CssClass="input-xxlarge" runat="server" onkeypress="return isNumberKey(event);"
                                                            MaxLength="4" autocomplete="off"></asp:TextBox>
                                                    </div>
                                                    <div class="col-sm-1  p0 pl10" style="text-align: center">
                                                        -
                                                    </div>
                                                    <div class="col-sm-3  p0 pl10">
                                                        <asp:TextBox ID="TxtAadhar3" CssClass="input-xxlarge" runat="server" onkeypress="return isNumberKey(event);"
                                                            MaxLength="4" autocomplete="off"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                            <div id="divpay" runat="server" visible="false">
                                                <h4>Payment Deposit Detail</h4>
                                                <div class="control-group">
                                                    <label class="control-label ">
                                                        Select Paymode</label>
                                                    <asp:DropDownList ID="DdlPaymode" runat="server" AutoPostBack="true" CssClass="input-xxlarge"
                                                        autocomplete="off">
                                                    </asp:DropDownList>
                                                </div>
                                                <asp:Label ID="errMsg" runat="server" CssClass="error"></asp:Label>
                                                <asp:HiddenField ID="HdnCheckTrnns" runat="server" />
                                                <div class="control-group">
                                                    <label class="control-label ">
                                                        <asp:Label ID="LblDDNo" runat="server" Text="Draft/CHEQUE No. *"></asp:Label></label>
                                                    <asp:TextBox ID="TxtDDNo" CssClass="input-xxlarge" runat="server" MaxLength="15" autocomplete="off"></asp:TextBox>
                                                </div>
                                                <div class="control-group">
                                                    <label class="control-label ">
                                                        <asp:Label ID="LblDDDate" runat="server" Text="Draft/CHEQUE Date *"></asp:Label>
                                                    </label>
                                                    <asp:TextBox ID="TxtDDDate" runat="server" CssClass="input-xxlarge" autocomplete="off"></asp:TextBox>
                                                    <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="TxtDDDate"
                                                        Format="dd-MMM-yyyy"></ajaxToolkit:CalendarExtender>
                                                </div>
                                                <div class="control-group">
                                                    <label class="control-label ">
                                                        Issued Bank Name
                                                    </label>
                                                    <asp:TextBox ID="TxtIssueBank" CssClass="input-xxlarge" runat="server" autocomplete="off"></asp:TextBox>
                                                </div>
                                                <div class="control-group ">
                                                    <label class="control-label ">
                                                        Issued Bank Branch</label>
                                                    <asp:TextBox ID="TxtIssueBranch" CssClass="input-xxlarge" runat="server" autocomplete="off"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div id="divlogin" runat="server" visible="false">
                                            <h4>Login Information</h4>
                                            <div class="control-group ">
                                                <label class="control-label ">
                                                    Password<span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                                <asp:TextBox ID="TxtPasswd" class="validate[required,minSize[5],maxSize[10]] input-xxlarge"
                                                    runat="server" TextMode="Password" ValidationGroup="eInformation" autocomplete="off"></asp:TextBox>
                                            </div>
                                            <div id="Div8" class="control-group" visible="false" runat="server">
                                                <label class="control-label ">
                                                    Transaction Password<span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                                <asp:TextBox ID="TxtTransactionPassword" class="validate[required,minSize[5],maxSize[10]] input-xxlarge"
                                                    runat="server" TextMode="Password" ValidationGroup="eInformation" autocomplete="off"></asp:TextBox>
                                            </div>
                                        </div>
                                        <asp:Image ID="imgCaptcha" runat="server" ImageUrl="CreateCaptcha.aspx?New=1" Height="30px"
                                            Visible="false" />
                                        <br />
                                        <b style="display: none;">Please Enter Captcha Code *</b>
                                        <asp:TextBox ID="txtCaptcha" CssClass="input-xxlarge" Style="text-transform: none;"
                                            Visible="false" runat="server"></asp:TextBox>
                                        <%-- </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="CmdSave" EventName="Click" />
                                        </Triggers>
                                    </asp:UpdatePanel>--%>
                                        <asp:Label ID="lblErrEpin" runat="server" CssClass="error"></asp:Label>
                                        <%--    </ContentTemplate>
                                           </asp:UpdatePanel>--%>
                                        <%-- <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <ContentTemplate>--%>
                                        <div id="DivTerms" runat="server" visible="true">
                                            <div class="control-group ">

                                                <div class="controls">
                                                    <%-- <center>--%>
                                                    <asp:CheckBox ID="chkterms" runat="server" onclick="DivOnOff();" TabIndex="14" />
                                                    I Agree With<a href="#" data-toggle="modal" data-target="#myModalTerm"> Terms And Condition</a>.
                                                   <%-- </center>--%>
                                                </div>

                                            </div>
                                            <%-- <asp:Button ID="CmdSave" runat="server" Text="Send Otp" CssClass="btn btn-primary" />--%>
                                            <asp:Button ID="CmdSave" runat="server" Text="Submit" CssClass="btn" OnClick="CmdSave_Click" TabIndex="15" />
                                            &nbsp;<asp:Button ID="CmdCancel" runat="server" Text="Cancel" CssClass="btn btn-primary"
                                                ValidationGroup="eCancel" Visible="false" TabIndex="16" />
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


























            <!-- END PAGE -->
        </div>
    </div>
</asp:Content>
