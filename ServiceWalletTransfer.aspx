<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ServiceWalletTransfer.aspx.cs" Inherits="ServiceWalletTransfer" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript" src="assets/jquery.min.js">
    </script>

    <%--   <script type="text/javascript" src="js/plugins/jquery/jquery.min.js"></script>--%>

    <script type="text/javascript" src="assets/jquery.validationEngine-en.js"></script>

    <script type="text/javascript" src="assets/jquery.validationEngine.js"></script>

    <link href="assets/validationEngine.jquery.min.css" rel="stylesheet" type="text/css" />
    <%--<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script> --%>


    <script type="text/javascript">
        var jq = $.noConflict();
        jq(document).ready(function () {
            jq(document).bind("contextmenu", function (e) {
                e.preventDefault();
            });
            jq(document).keydown(function (e) {

                if (e.which === 123) {
                    return false;
                }
                if (e.which === 116) {
                    return false;
                }
                if (e.ctrlKey && e.which === 82) {

                    return false;

                }


            });




        });
        function pageLoad(sender, args) {

            jq(document).ready(function () {

                jq("#aspnetForm").validationEngine('attach', { promptPosition: "topRight" });
            });

            jq(document).ready(function () {
                jq("#CmdSave1").click(function () {
                    // Your JavaScript code here
                });
            });


            var valid = jq("#aspnetForm").validationEngine('validate');
            var vars = jq("#aspnetForm").serialize();
            if (valid == true) {
                return true;

            } else {
                return false;
            }
        });
        }


    </script>

    <style type="text/css">
        .feedbackform {
            width: auto;
            height: auto;
            position: absolute;
            top: 100px;
            left: 40%;
            z-index: 9999;
            display: block;
            padding: 15px;
            background: #fff;
            border-radius: 5px;
            border: 1px solid;
        }

            .feedbackform img {
                max-width: 150px;
                display: block;
            }

        .feedbackpop {
            background: url(images/blackbg2.png) repeat;
            position: fixed;
            width: 100%;
            height: 100%;
            display: block;
            z-index: 9999;
        }

        #closeicon a {
            background: url(images/close2.png) no-repeat;
            width: 55px;
            height: 55px;
            display: block;
            margin: -22px -30px 0 0;
            float: right;
            position: absolute;
            right: 0px;
        }

            #closeicon a:hover {
                background: url(images/close2_hover.png) no-repeat;
            }

        #feedbackwrap {
            width: 1000px;
            margin: 0 auto;
            position: relative;
        }

        @media ( max-width: 1000px ) {
            #feedbackwrap {
                width: 100%;
            }

            .feedbackform {
                left: 2%;
                right: 2%;
            }
        }
    </style>
    <script type="text/javascript">

        function checkWAmt() {
            debugger;
            var WAvlBal = '<%= Session["ServiceWallet"] %>';

            var Amt = document.getElementById("<%= txtAmount.ClientID %>").value;
            var Amount = (parseFloat(Amt) % 10);

            var rb = document.getElementById("<%=DDLPaymode.ClientID%>");
            var selectedValue = rb.value;
            if (selectedValue == "1") {
                if (parseFloat(Amt) > parseFloat(WAvlBal)) {
                    alert('Transfer amount could not be greater than available balance.');
                    document.getElementById("<%= txtAmount.ClientID %>").value = '0';
                    return false;
                }
                else if (Amount > 0) {
                    alert('Enter Amount only multiple of Tenth.');
                    document.getElementById("<%= txtAmount.ClientID %>").value = '0';

                    return false;

                }

                else {

                    return true;
                }
            }
            else {
                if (Amount > 0) {
                    alert('Enter Amount only multiple of Tenth.');
                    document.getElementById("<%= txtAmount.ClientID %>").value = '0';

                    return false;

                }

                else {

                    return true;
                }

            }
        }

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="container-fluid">
        <!-- BEGIN PAGE HEADER-->
        <div class="row-fluid">
            <div class="span12">
                <%-- <h3 class="page-title">Change Password </h3>--%>
                <ul class="breadcrumb">
                    <li><a href="#"><i class="icon-home"></i></a><span class="divider">&nbsp;</span> </li>
                    <li><a href="#">Wallet Transfer</a><span class="divider-last">&nbsp;</span></li>
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
                                    <h4><i class="icon-credit-card"></i>Wallet Transfer</h4>
                                    <span class="tools">
                                        <a href="javascript:;" class="icon-chevron-down"></a>
                                    </span>
                                </div>
                                <div class="widget-body">
                                    <div class="form-horizontal">
                                        <div class="control-group">


                                            <h4>Available Wallet Balance:<span class="red" id="AvailableBal" style="color: Red" runat="server"></span>
                                            </h4>

                                        </div>

                                        <div class="control-group">
                                            <label class="control-label">
                                                Member Id <span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                            <div class="controls">
                                                <asp:TextBox ID="TxtMemId" runat="server" CssClass="input-xxlarge validate[required]"
                                                    AutoPostBack="true" OnTextChanged="txtMemberId_TextChanged"></asp:TextBox>
                                                <asp:Label ID="LblFormno" runat="server" Visible="false"></asp:Label>
                                                <asp:HiddenField ID="hdnMacadrs" runat="server" />
                                                <asp:HiddenField ID="HdnTopupSeq" runat="server" />
                                                <asp:HiddenField ID="HdnMemberMacAdrs" runat="server" />
                                                <asp:HiddenField ID="HdnMemberTopupseq" runat="server" />
                                                <asp:HiddenField ID="MemberStatus" runat="server" />
                                                <asp:HiddenField ID="hdnFormno" runat="server" />
                                                <asp:HiddenField ID="hdnemail" runat="server" />
                                            </div>
                                        </div>
                                        <div class="control-group " id="DivMemberName" runat="server">
                                            <label class="control-label">
                                                Member Name <span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                            <div class="controls">
                                                <asp:Label ID="LblMobile" runat="server" Visible="false"></asp:Label>
                                                <asp:TextBox ID="TxtMemName" runat="server" CssClass="input-xxlarge" Enabled="false"></asp:TextBox>
                                                <asp:HiddenField ID="HdnCheckTrnns" runat="server" />
                                            </div>
                                        </div>
                                        <div class="form-group" style="display: none">
                                            <label for="inputdefault">
                                                Payment Type</label>
                                            <asp:DropDownList ID="DDLPaymode" runat="server" class="input-xxlarge" AutoPostBack="true">
                                                <asp:ListItem Text="Wallet" Value="1"></asp:ListItem>

                                            </asp:DropDownList>
                                        </div>
                                        <div class="control-group " id="DivCurrency" runat="server" visible="false">
                                            <label class="control-label">
                                                Currency <span class="red">*</span></label>
                                            <asp:DropDownList ID="ddlcurrency" runat="server" CssClass="input-xxlarge">
                                            </asp:DropDownList>
                                        </div>
                                        <div class="control-group " id="Div1" runat="server" style="display: none;">
                                            <label class="control-label">
                                                Package</label>
                                            <asp:DropDownList ID="CmbKit" CssClass="input-xxlarge" runat="server" AutoPostBack="true">
                                            </asp:DropDownList>
                                        </div>
                                        <div class="control-group " runat="server">
                                            <label class="control-label">
                                                Amount <span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                            <div class="controls">
                                                <asp:TextBox ID="txtAmount" runat="server" CssClass="input-xxlarge" AutoPostBack="true" OnTextChanged="txtAmount_TextChanged" Text="0" onkeypress="return isNumberKey(event);"></asp:TextBox>
                                                <asp:Label ID="LblAmount" runat="server" Visible="false"></asp:Label>
                                                <asp:Label ID="LblAmountUse" runat="server" Visible="false"></asp:Label>
                                            </div>
                                        </div>
                                        <div class="control-group ">
                                            <label class="control-label">Remarks <span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                            <div class="controls">
                                                <asp:TextBox ID="TxtRemark" runat="server" CssClass="input-xxlarge"></asp:TextBox>
                                            </div>
                                        </div>

                                        <%--  <div class="control-group ">
                                            <asp:Button ID="cmdSave1" runat="server" Text="Submit" class="btn" ValidationGroup="Validation" OnClick="cmdSave1_Click" />
                                            <asp:Label ID="LblError" runat="server" Visible="false"></asp:Label>
                                        </div>--%>
                                        <div class="control-group">
                                            <div id="DivTerms" runat="server" visible="true">
                                                <asp:Button ID="CmdSave" runat="server" Text="Send Otp" CssClass="btn"
                                                    TabIndex="54" OnClick="CmdSave_Click" />
                                               <%-- &nbsp;<asp:Button ID="CmdCancel" runat="server" Text="Cancel" CssClass="btn btn-primary"
                                                    ValidationGroup="eCancel" TabIndex="55" />--%>
                                            </div>
                                            <br />
                                            <div id="divOtp" runat="server" visible="false">

                                                <div class="control-group ">
                                                    <label class="control-label">Wallet Password <span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                                    <div class="controls">
                                                        <asp:TextBox ID="TxtPassword" runat="server" CssClass="input-xxlarge" TextMode="Password"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="control-group">
                                                    <label class="control-label">
                                                        Enter Mobile OTP <span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                                    <br />
                                                    <asp:TextBox ID="TxtPassword1" autocomplete="off" runat="server"
                                                        CssClass="input-xxlarge"></asp:TextBox>
                                                    <asp:Label ID="lblOTPMsg" runat="server"></asp:Label>
                                                    <asp:RequiredFieldValidator ID="rbtnbsa" runat="server" ControlToValidate="TxtPassword1"
                                                        SetFocusOnError="true" Text="*" ValidationGroup="Submitbtn"></asp:RequiredFieldValidator>
                                                </div>

                                                <div class="col-lg-12 col-md-12">
                                                    <asp:Button ID="cmdSave1" runat="server" ValidationGroup="Submitbtn" Text="Submit"
                                                        class="btn" OnClick="cmdSave1_Click" />
                                                    <asp:Button ID="btngenerate" runat="server" Text="Generate OTP" class="btn" OnClick="btngenerate_Click" />
                                                </div>
                                            </div>
                                            <%--<asp:Button ID="cmdSave1" runat="server" Text="Submit" class="btn btn-primary" ValidationGroup="Validation" />--%>
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

