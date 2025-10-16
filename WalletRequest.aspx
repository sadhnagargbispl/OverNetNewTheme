<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="WalletRequest.aspx.cs" Inherits="WalletRequest" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript" src="assets/jquery.min.js">
    </script>

    <%--   <script type="text/javascript" src="js/plugins/jquery/jquery.min.js"></script>--%>

    <script type="text/javascript" src="assets/jquery.validationEngine-en.js"></script>

    <script type="text/javascript" src="assets/jquery.validationEngine.js"></script>

    <link href="assets/validationEngine.jquery.min.css" rel="stylesheet" type="text/css" />

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
        //function pageLoad(sender, args) {

        //    jq(document).ready(function () {

        //        jq("#aspnetForm").validationEngine('attach', { promptPosition: "topRight" });
        //    });

            <%--jq("#<%=CmdSave1.ClientID %>").click(function() {


                var valid = jq("#aspnetForm").validationEngine('validate');
                var vars = jq("#aspnetForm").serialize();
                if (valid == true) {
                    return true;

                } else {
                    return false;
                }
            });--%>
        }


    </script>

    <script type="text/javascript">
        function copyText() {

            var range, selection, worked;
            var element = document.getElementById("ctl00_ContentPlaceHolder1_lblLink");
            if (document.body.createTextRange) {
                range = document.body.createTextRange();
                range.moveToElementText(element);
                range.select();
            } else if (window.getSelection) {
                selection = window.getSelection();
                range = document.createRange();
                range.selectNodeContents(element);
                selection.removeAllRanges();
                selection.addRange(range);
            }

            try {
                document.execCommand('copy');
                alert('link copied');
            }
            catch (err) {
                alert('unable to copy link');
            }
            return false;
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
                    <li><a href="#">Wallet Request</a><span class="divider-last">&nbsp;</span></li>
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
                                    <h4><i class="icon-credit-card"></i>Wallet Request</h4>
                                    <span class="tools">
                                        <a href="javascript:;" class="icon-chevron-down"></a>
                                    </span>
                                </div>
                                <div class="widget-body">
                                    <div class="form-horizontal">
                                        <div class="control-group">
                                            <label class="control-label">
                                                Enter Amount<span class="red">*</span></label>
                                            <div class="controls">
                                                <asp:TextBox runat="server" onkeypress="return isNumberKey(event);" MaxLength="8"
                                                    TabIndex="1" ID="TxtAmount" class="input-xxlarge validate[required]"></asp:TextBox>
                                                <asp:HiddenField ID="HdnCheckTrnns" runat="server" />
                                            </div>
                                        </div>

                                        <div class="control-group">
                                            <label class="control-label">
                                                Select Paymode<span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                            <div class="controls">

                                                <asp:DropDownList ID="DdlPaymode" runat="server" AutoPostBack="true" CssClass="input-xxlarge"
                                                    TabIndex="2">
                                                </asp:DropDownList>

                                            </div>
                                        </div>

                                        <div class="control-group " id="divDDno" runat="server" visible="false">
                                            <label class="control-label">
                                                <asp:Label ID="LblDDNo" runat="server" Text="Draft/CHEQUE No. *"></asp:Label></label>
                                            <div class="controls">
                                                <asp:TextBox ID="TxtDDNo" onkeypress="return isNumberKey(event);" class="input-xxlarge validate[required]"
                                                    TabIndex="3" runat="server" MaxLength="16" AutoPostBack="true"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="control-group " id="divDDDate" runat="server">
                                            <label class="control-label">
                                                <asp:Label ID="LblDDDate" runat="server" Text="Transaction Date *"></asp:Label></label>
                                            <div class="controls">
                                                <asp:TextBox ID="TxtDDDate" runat="server" class="input-xxlarge validate[required]"
                                                    TabIndex="4" type="date" ></asp:TextBox>
                                               <%-- <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="TxtDDDate"
                                                    Format="dd-MMM-yyyy" PopupButtonID="imgDatePicker"></ajaxToolkit:CalendarExtender>
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TxtDDDate"
                                                    ErrorMessage="Invalid Date" Font-Names="arial" Font-Size="10px" SetFocusOnError="True"
                                                    ValidationExpression="^(?:((31-(Jan|Mar|May|Jul|Aug|Oct|Dec))|((([0-2]\d)|30)-(Jan|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec))|(([01]\d|2[0-8])-Feb))|(29-Feb(?=-((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)))))-((1[6-9]|[2-9]\d)\d{2})$"
                                                    ValidationGroup="Form-submit"></asp:RegularExpressionValidator>--%>

                                                <style>
                                                    .imgdatewalletrequest {
                                                        position: absolute;
                                                        margin-top: 1px;
                                                        /* left: 88%;*/
                                                        margin-left: -82px;
                                                    }

                                                    @media only screen and (max-width:768) {
                                                        .imgdatewalletrequest {
                                                            left: 82%;
                                                            margin-top: -48px;
                                                        }
                                                    }
                                                </style>
                                               <%-- <asp:ImageButton ID="imgDatePicker" runat="Server" AlternateText="Click to show calendar"
                                                    ImageAlign="Middle" ImageUrl="images/Calender.jpg" Width="25px" class="imgdatewalletrequest" />--%>
                                            </div>
                                        </div>
                                        <div class="control-group ">
                                        </div>


                                        <div class="control-group " id="DivBank" runat="server">
                                            <label class="control-label">
                                                Bank Name <span class="red"><span style="color: red !important; font-weight: bolder; font-size: 0.9em;">*</span></span></label>
                                            <div class="controls">
                                                <asp:DropDownList ID="DDlBank" runat="server" TabIndex="5" CssClass="input-xxlarge">
                                                </asp:DropDownList>
                                            </div>
                                        </div>

                                        <div class="control-group " id="DivBranch" runat="server">
                                            <label class="control-label">Branch Name</label>
                                            <div class="controls">
                                                <asp:TextBox ID="TxtIssueBranch" class="input-xxlarge validate[required]" TabIndex="6"
                                                    runat="server"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="control-group " id="divImage" runat="server">
                                            <label class="control-label">
                                                Scanned Copy:</label>
                                            <div class="controls">
                                                <asp:FileUpload runat="server" ID="FlDoc" class="input-xxlarge" TabIndex="7" />
                                                <asp:Label ID="LblImage" runat="server" Visible="false"></asp:Label>
                                            </div>
                                        </div>
                                        <div class="form-group greybt" id="Div1" runat="server" visible="false">
                                            <label for="inputdefault">
                                                Wallet Address used for transaction</label>
                                            <asp:TextBox ID="Txtwalletad" class="input-xxlarge" TabIndex="6" runat="server"></asp:TextBox>
                                        </div>
                                        <div class="control-group ">
                                            <label class="control-label">
                                                Remarks <span class="red">*</span></label>
                                            <div class="controls">
                                                <asp:TextBox ID="TxtRemarks" class="input-xxlarge validate[required]" MaxLength="240"
                                                    TabIndex="8" runat="server"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="control-group ">
                                            <label class="control-label">
                                                Transaction Password <span class="red">*</span></label>
                                            <div class="controls">
                                                <asp:TextBox ID="TxtPassword" runat="server" TextMode="Password" class="input-xxlarge validate[required]"
                                                    TabIndex="9"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="control-group ">
                                            <asp:Button ID="cmdSave1" runat="server" Text="Submit" TabIndex="10" class="btn btn_default" OnClick="cmdSave1_Click"
                                                ValidationGroup="eInformation" />
                                        </div>
                                        <div class="control-group ">
                                            <br />
                                            <asp:ValidationSummary ID="ValidationSummary2" runat="server" ShowMessageBox="True"
                                                ShowSummary="False" ValidationGroup="eInformation" />
                                           <%-- <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="TxtDDDate"
                                                ErrorMessage="Invalid Date" Font-Names="arial" Font-Size="10px" SetFocusOnError="True"
                                                ValidationExpression="^(?:((31-(Jan|Mar|May|Jul|Aug|Oct|Dec))|((([0-2]\d)|30)-(Jan|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec))|(([01]\d|2[0-8])-Feb))|(29-Feb(?=-((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)))))-((1[6-9]|[2-9]\d)\d{2})$"
                                                ValidationGroup="Form-submit"></asp:RegularExpressionValidator>--%>
                                        </div>
                                        <div class="col-sm-6 pull-none">
                                            <div id="div2" runat="server" visible="false">
                                                <center>
                                                    <div class="form-group">
                                                        <img src="images/qrcode1.jpg" alt="" style="height: 160px" />
                                                    </div>

                                                    <span style="font-weight: 700">Wallet Address: </span>&nbsp;&nbsp;&nbsp;
            <asp:Label ID="lblLink" runat="server" Style="font-weight: 500" CssClass="Link">TLznxdPoQQNT9KqXnyZ4ufyTgJ4GxwLTTu </asp:Label>&nbsp;&nbsp;
            <asp:ImageButton ID="btncopy" runat="Server" OnClientClick="return copyText();" ImageUrl="images/copy.png"
                Width="20px" />
                                                </center>
                                                <style>
                                                    @media only screen and (max-width:768) {
                                                        .Link {
                                                            border: 1px solid red !important;
                                                        }
                                                    }
                                                </style>
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

