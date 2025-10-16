<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="iddetail.aspx.cs" Inherits="iddetail" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

    <script type="text/javascript" src="https://fonts.googleapis.com/css?family=Roboto"></script>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

    <script type="text/javascript" src="https://fonts.googleapis.com/css?family=Roboto"></script>
    <style type="text/css">
        input {
            text-transform: uppercase;
        }
    </style>
    <style type="text/css">
        .style1 {
            height: 15%;
            width: 358px;
        }

        .style2 {
            height: 2px;
            width: 304px;
        }

        .style3 {
            height: 2px;
            width: 358px;
        }
    </style>
    <script type="text/javascript">
        function FnVillageChange(val) {

            if (val == "381264") {

                document.getElementById("divVillage").style.display = "block";

            }
            else {
                document.getElementById("divVillage").style.display = "none";
            }

        }
    </script>
    <script type="text/javascript">
        
    </script>
    <script>
        function openPopup(element) {
            var url = element.href;
            hs.htmlExpand(element, {
                objectType: 'iframe',
                width: 620,
                height: 450,
                marginTop: 0
            });
            return false;
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--<div class="stars"></div>
    <div class="stars2"></div>
    <div class="stars3"></div>
    <div id="content" class="main-content">
        <div class="sub-header-container">
            <header class="header navbar navbar-expand-sm">
                <a href="javascript:void(0);" class="sidebarCollapse"
                    data-placement="bottom" tabindex="-1"><i class="las la-bars"></i></a>
                <ul class="navbar-nav flex-row">
                    <li>
                        <div class="page-header">
                            <nav class="breadcrumb-one" aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item active" aria-current="page">
                                        <span>Bank Detail </span>
                                    </li>
                                </ol>
                            </nav>
                        </div>
                    </li>
                </ul>
            </header>
        </div>
        <div class="content">
            <div class="box box-primary">
                <div class="card" style="padding: 20px;">
                    <div class="clearfix gen-profile-box" style="min-height: auto;">
                        <div class="profile-bar clearfix" style="background: #000;">
                            <div class="clearfix">
                                <br>
                                <div class="row">--%>

    <div class="container-fluid">
        <!-- BEGIN PAGE HEADER-->
        <div class="row-fluid">
            <div class="span12">
                <%-- <h3 class="page-title">Bank Detail </h3>--%>
                <ul class="breadcrumb">
                    <li><a href="#"><i class="icon-home"></i></a><span class="divider">&nbsp;</span> </li>
                    <li><a href="#">Address Proof</a><span class="divider-last">&nbsp;</span></li>
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
                                    <h4><i class="icon-credit-card"></i>Address Proof</h4>
                                    <span class="tools">
                                        <a href="javascript:;" class="icon-chevron-down"></a>
                                    </span>
                                </div>
                                <div class="widget-body">
                                    <div class="form-horizontal">
                                        <div class="row">
                                            <div class="span8">
                                                <!-- Genex Business -->
                                                <%-- <div id="ctl00_ContentPlaceHolder1_divgenexbusiness" class="clearfix gen-profile-box">
                                            <div class="clearfix gen-profile-box" style="min-height: auto;">--%>
                                                <%--<div class="profile-bar clearfix" >--%>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        Dear
                            <%=Session["MemName"]%>
                                                        <asp:HiddenField ID="hdnSessn" runat="server" />
                                                        (<asp:Label ID="lblid" runat="server"></asp:Label>) , Update Your KYC (<asp:Label
                                                            ID="LblIdproofText" runat="server"></asp:Label>)
                            <br />
                                                    </div>
                                                    <div class="profile-bar-simple red-border clearfix">
                                                        <h6>Address Proof
                                                        </h6>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="pwd">
                                                            Address:</label>
                                                        <asp:TextBox ID="txtaddrs" runat="server" CssClass="input-xxlarge validate[required]"></asp:TextBox>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="pincode">
                                                            Pincode</label>
                                                        <asp:TextBox ID="Txtpincode" runat="server" CssClass="input-xxlarge validate[required,custom[pincode]]"
                                                            AutoPostBack="true" OnTextChanged="Txtpincode_TextChanged"></asp:TextBox>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="pwd">
                                                            State:</label>

                                                        <asp:DropDownList ID="ddlState" runat="server" CssClass="input-xxlarge" AutoPostBack="true" OnSelectedIndexChanged="ddlState_SelectedIndexChanged">
                                                        </asp:DropDownList>

                                                        <asp:HiddenField ID="StateCode" runat="server" />
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="district">
                                                            District</label>
                                                        <asp:HiddenField ID="HDistrictCode" runat="server" />
                                                        <asp:TextBox ID="Txtdistrict" runat="server" CssClass="input-xxlarge validate[required]"></asp:TextBox>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="city">
                                                            City</label>
                                                        <asp:TextBox ID="Txtcity" runat="server" CssClass="input-xxlarge validate[required]"></asp:TextBox>
                                                        <asp:HiddenField ID="HCityCode" runat="server" />
                                                    </div>
                                                    <div class="form-group " style="display: none;">
                                                        <label for="inputdefault">
                                                            Area</label>
                                                        <asp:DropDownList ID="DDlVillage" CssClass="input-xxlarge" runat="server" ValidationGroup="eInformation"
                                                            autocomplete="off" onchange="FnVillageChange(this.value);">
                                                        </asp:DropDownList>
                                                    </div>
                                                    <div class="form-group" id="divVillage" style="display: none">
                                                        <label for="inputdefault">
                                                            Area Name</label>
                                                        <asp:TextBox ID="TxtVillage" CssClass="input-xxlarge" runat="server" autocomplete="off"></asp:TextBox>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="addressproof">
                                                            Address Proof</label>
                                                        <asp:DropDownList ID="DDLAddressProof" runat="server" CssClass="input-xxlarge">
                                                        </asp:DropDownList>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="idproof">
                                                            <asp:Label ID="LblAddresProof" runat="server"></asp:Label>
                                                        </label>
                                                        <asp:TextBox ID="TxtIdProofNo" CssClass="input-xxlarge validate[required]" runat="server" MaxLength="16" AutoPostBack="true" OnTextChanged="TxtIdProofNo_TextChanged"></asp:TextBox>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="email">
                                                            Front Address Proof Upload:</label>
                                                        <asp:FileUpload ID="Fuidentity" runat="server" CssClass="input-xxlarge validate[required]" />
                                                        <asp:RequiredFieldValidator ID="rfvImage" runat="server" ErrorMessage="Please Select  Front Address proof.!!"
                                                            Enabled="false" ControlToValidate="Fuidentity" ValidationGroup="eInformation">
                                                        </asp:RequiredFieldValidator>
                                                        <asp:Label ID="lblimage" runat="server" Visible="false"></asp:Label>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="pwd">
                                                            Back Address Proof Upload:</label>
                                                        <asp:FileUpload ID="FileUpload1" runat="server" CssClass="input-xxlarge validate[required]" />
                                                        <asp:RequiredFieldValidator ID="rfvImage1" runat="server" ErrorMessage="Please Select  Back Address proof.!!"
                                                            Enabled="false" ControlToValidate="FileUpload1" ValidationGroup="eInformation">
                                                        </asp:RequiredFieldValidator>
                                                        <asp:Label ID="LblBackImage" runat="server" Visible="false"></asp:Label>
                                                    </div>

                                                    <div class="form-group">
                                                        <div class="col-sm-offset-3 col-sm-9">
                                                            <asp:Button ID="BtnIdentity" runat="server" ValidationGroup="eInformation" CssClass="btn btn-danger"
                                                                Text="Submit" TabIndex="7" OnClick="BtnIdentity_Click" />
                                                        </div>
                                                    </div>
                                                </div>
                                                <%-- </div>--%>
                                                <%--  </div>
                                        </div>--%>
                                            </div>
                                            <div class="span4">
                                                <!-- Genex Business -->
                                                <div id="ctl00_ContentPlaceHolder1_divgenexbusiness" class="clearfix gen-profile-box">
                                                    <div class="profile-bar-simple red-border clearfix">
                                                        <h6>Uploaded Images
                                                        </h6>
                                                    </div>
                                                    <div class="col-md-12">
                                                        <%-- <div class="col-md-6">
                                <div class="image">--%>

                                                        <script src="popupassets/popper.min.js"></script>

                                                        <script src="popupassets/lib.js"></script>

                                                        <script src="popupassets/jquery.flagstrap.min.js"></script>

                                                        <script type="text/javascript" src="popupassets/jquery.themepunch.tools.min.js"></script>

                                                        <script type="text/javascript" src="popupassets/jquery.themepunch.revolution.min.js"></script>

                                                        <script src="js/functions1.js"></script>

                                                        <div class="col-md-12">
                                                            Front Address Proof
                                <br />
                                                            <a id="FrontAddress" runat="server" class="fbox" rel="group" onclick="return openPopup(this)">
                                                                <asp:Image ID="ShowIdentity" runat="server" Width="150px" Height="150px" />
                                                            </a>
                                                        </div>
                                                        <div class="col-md-12">
                                                            Back Address Proof
                                <br />
                                                            <a id="BackAddress" runat="server" class="fbox" rel="group" onclick="return openPopup(this)">
                                                                <asp:Image ID="showBackImage" Width="150px" Height="150px" runat="server" />
                                                            </a>
                                                        </div>
                                             
                                                    </div>
                                                    <div class="col-md-12">
                                                        <div id="DivVerify" runat="server">
                                                            <br />
                                                            <asp:Label ID="LblVerification" Text="Verification Status :  " Font-Bold="true" runat="server"></asp:Label>
                                                            <asp:Label ID="lblverstatus" runat="server"></asp:Label>
                                                            <br />
                                                            <asp:Label ID="VerifyDate" runat="server" Text="Verify/Reject Date : " Visible="false"
                                                                Style="font-weight: bold"></asp:Label>
                                                            <asp:Label ID="Lblverdate" runat="server"></asp:Label>
                                                            <br />
                                                            <asp:Label ID="LblVerfRemark" Text="Reject Remark : " Visible="false" runat="server"
                                                                Style="font-weight: bold"></asp:Label>
                                                            <asp:Label ID="LblRemark" runat="server"></asp:Label>
                                                            <br />
                                                            <asp:Label ID="LblVerfReason" Text="Reject Reason : " Visible="false" runat="server"
                                                                Style="font-weight: bold"></asp:Label>
                                                            <asp:Label ID="LbLrejectRemark" runat="server"></asp:Label>
                                                        </div>
                                                    </div>
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
    <%--</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>--%>
    <script type="text/javascript" src='https://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.3.min.js'></script>

    <script type="text/javascript" src='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.3/js/bootstrap.min.js'></script>

    <script src="assets/jquery.inbox.js"></script>


    <script type="text/javascript" src="popupassets/jquery.fancybox.pack.js"></script>

    <script type="text/javascript" src="popupassets/jquery.fancybox.pack1.js"></script>

    <link rel="stylesheet" href="popupassets/jquery.fancybox.css" type="text/css" media="screen" />

    <script type="text/javascript">
        $(document).ready(function () {
            $(".fbox").fancybox({
                openEffect: 'elastic',
                closeEffect: 'elastic'
            });
        });
    </script>
</asp:Content>
