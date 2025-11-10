<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AppPancard.aspx.cs" Inherits="AppPancard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <script type="text/javascript">
        window.history.forward();
        function noBack() {
            window.history.forward();
        }
    </script>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta name="description">
    <meta name="author">
    <title>
        <%=Session["Title"].ToString ()%></title>
    <!-- -------------------- Start CSS Files --------------------  -->
    <link href="assets/cssfile/bootstrap.min.css" rel="stylesheet">
    <link href="assets/cssfile/bootstrap-responsive.min.css" rel="stylesheet">
    <link href="assets/cssfile/font-awesome.css" rel="stylesheet">
    <link href="assets/cssfile/style.css?v=1.5" rel="stylesheet">
    <link id="ctl00_style_color" href="assets/cssfile/style_navy-blue.css?v=1.5" rel="stylesheet">
    <link rel="stylesheet" href="assets/cssfile/font-awesome.min.css">
    <link href="assets/cssfile/jquery.fancybox.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="assets/cssfile/uniform.default.css">
    <link rel="stylesheet" type="text/css" href="assets/cssfile/jquery.gritter.css">
    <link rel="stylesheet" href="assets/cssfile/font-awesome.min.css">

    <link href="assets/cssfile/style_responsive.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    <link href="assets/cssfile/added_css_rohit.css" rel="stylesheet">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=El+Messiri&display=swap" rel="stylesheet">

    <script src="assets/jsfile/jquery-1.8.3.min.js"></script>
    <script src="assets/jsfile/bootstrap.min.js"></script>
    <script src="assets/jsfile/jquery.blockui.js"></script>
    <script src="assets/jsfile/progress.js"></script>
    <script src="assets/jsfile/SearchJScript.js" type="text/javascript"></script>



    <link href="assets/cssfile/newstyle.css" rel="stylesheet">

    <link href="assets/cssfile/style.css?v=2.7" rel="stylesheet">
</head>
<body>
    <form id="form1" runat="server">
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
        <div id="main-content">
            <div class="container-fluid">
                <!-- BEGIN PAGE HEADER-->
                <div class="row-fluid">
                    <div class="span12">
                        <%-- <h3 class="page-title">Bank Detail </h3>--%>
                        <ul class="breadcrumb">
                            <li><a href="#"><i class="icon-home"></i></a><span class="divider">&nbsp;</span> </li>
                            <li><a href="#">Pan Detail</a><span class="divider-last">&nbsp;</span></li>
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
                                            <h4><i class="icon-credit-card"></i>PAN DETAIL</h4>
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
                                                                <h6>PAN Card Detail
                                                                </h6>
                                                            </div>
                                                            <div class="form-group">
                                                                <label for="inputdefault">
                                                                    Pan Card No. :</label>
                                                                <%--AutoPostBack ="true"--%>
                                                                <asp:TextBox ID="txtpan" runat="server" CssClass="input-xxlarge validate[required,custom[panno]]" AutoPostBack="true" OnTextChanged="txtpan_TextChanged"></asp:TextBox>
                                                            </div>
                                                            <div class="form-group">
                                                                <label for="inputdefault">
                                                                    PanCard Upload :</label>
                                                                <asp:FileUpload ID="PanKYCFileUpload" runat="server" CssClass="input-xxlarge validate[required]" />
                                                                <asp:Label ID="LblPanImage" runat="server" Visible="false"></asp:Label>
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
                                                                    Pan Card
                             <br />
                                                                    <a id="PanCard" runat="server" class="fbox" rel="group" onclick="return openPopup(this)">
                                                                        <asp:Image ID="pANiMAGE" Width="150px" Height="150px" runat="server" />
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
        </div>
    </form>

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
</body>
</html>
