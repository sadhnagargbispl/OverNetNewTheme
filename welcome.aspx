<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="welcome.aspx.cs" Inherits="welcome" %>

<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" ID="content2" runat="server">
    <div class="container-fluid">
        <!-- BEGIN PAGE HEADER-->
        <div class="row-fluid">
            <div class="span12">
                <%--  <h3 class="page-title">Change Withdrawal Password   </h3>--%>
                <ul class="breadcrumb">
                    <li><a href="#"><i class="icon-home"></i></a><span class="divider">&nbsp;</span> </li>
                    <li><a href="#">Welcome</a><span class="divider-last">&nbsp;</span></li>
                </ul>
            </div>
        </div>
        <div>

            <div class="row-fluid panelpart">

                <div class="row-fluid panelpart">



                    <div class="span12">

                        <div class="row">
                            <div class="widget">
                                <div class="widget-title">
                                    <h4><i class="icon-credit-card"></i>WELCOME</h4>
                                    <span class="tools">
                                        <a href="javascript:;" class="icon-chevron-down"></a>
                                    </span>
                                </div>
                                <div class="clr">
                                    <asp:Label ID="errMsg" runat="server" CssClass="error"></asp:Label>
                                </div>
                                <div class="widget-body">
                                    <div class="container" style="cursor: default">
                                        <div class="row">
                                            <div class="col-md-6">
                                            </div>
                                            <div class="col-md-5">
                                                <button type="button" class="btn btn-info btn-xs" id="BtnHome" runat="server">
                                                    Home</button>
                                                <button type="button" class="btn btn-warning btn-xs" id="BtnPrint" runat="server"
                                                    onclick="javascript:PrintDiv();">
                                                    Print</button>
                                                <button type="button" class="btn btn-danger btn-xs" id="BtnNewJoin" runat="server" visible="false">
                                                    New Joining
                                                </button>
                                            </div>
                                            <div class="clearfix">
                                            </div>
                                            <div id="dvContents" runat="server">
                                                <div class="container" style="cursor: default">

                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <div class="col-md-12">
                                                                <div class="logo mb-3">
                                                                    <img src="<%= Session["LogoUrl"]%>" class="img-thumbnail">
                                                                </div>
                                                                <div class="title" style="margin-top: 10px !important;">
                                                                    <h3>Welcome Letter</h3>
                                                                </div>
                                                            </div>

                                                            <div class="main-content-data">
                                                                <div class="row">
                                                                    <div class="col-md-12">
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="clearfix">
                                                            </div>
                                                            <br />
                                                            <div class="col-sm-12">
                                                                <h5>Letter No- <span id="LblId" runat="server"></span>/<span id="LblYear" runat="server"></span>
                                                                    <%--<asp:Label ID="LblId" runat="server"></asp:Label>
                                                        /<asp:Label ID="LblYear" runat="server"></asp:Label>--%>
                                                                </h5>

                                                                <p style="margin-bottom: 0px">
                                                                    &nbsp;
                                                                </p>
                                                                <h6 class="text-danger">
                                                                    <strong><em>Dear Clients / Participants & Families,</strong>
                                                                </h6>
                                                                <p>
                                                                    We are <%=Session["CompName"]%> , are pleased to welcome you as our new client and 
                                                        take this opportunity to extend our warm greetings to you.
                                                                </p>
                                                                <p>
                                                                    We assure you that you will find it enjoyable and professionally 
                                                        beneficial to avail   our services or to associate with us.
                                                                </p>
                                                                <p>
                                                                    We, at
                                                        <%=Session["CompName"]%>
                                                        , respect the concern of our clients and associates and observe
                                                         highest degree of corporate ethics we sincerely hope and believe
                                                          that our services, to which you have subscribed , will turn out 
                                                          to be better than your expectations , as the precedent of our 
                                                          performance states. We hope to add your name to the long list 
                                                          of satisfied clients and associates.
                                                                </p>
                                                                <p>
                                                                    We are confident that our customized packages, which we will offer
                                                         to you, willwin your trust and appreciation. Our representative will
                                                          always be there to takecare of all your concern 24 x 7 with absolute
                                                           dedication. We hope to be your service for long in the future.
                                                                </p>
                                                                <p>
                                                                    Please find the below mentioned details of your enrollment with
                                                        <%=Session["CompName"]%>
                                                                </p>
                                                                <p>
                                                                    <table class="table table-bordered" cellspacing="0" style="border: 1px solid black;">
                                                                        <tr style="border: 1px solid black;">
                                                                            <td style="border: 1px solid black; font-weight: bold;">ID NO
                                                                            </td>
                                                                            <td style="border: 1px solid black;">
                                                                                <asp:Label ID="LblIdno" runat="server"></asp:Label>
                                                                            </td>
                                                                            <td style="border: 1px solid black; font-weight: bold;">Name
                                                                            </td>
                                                                            <td style="border: 1px solid black;">
                                                                                <asp:Label ID="LblName" runat="server"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="border: 1px solid black; font-weight: bold;">Address
                                                                            </td>
                                                                            <td style="border: 1px solid black;">
                                                                                <asp:Label ID="LblAddress" runat="server"></asp:Label>
                                                                            </td>
                                                                            <td style="border: 1px solid black; font-weight: bold;">City
                                                                            </td>
                                                                            <td style="border: 1px solid black;">
                                                                                <asp:Label ID="LblCity" runat="server"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="border: 1px solid black; font-weight: bold;">District
                                                                            </td>
                                                                            <td style="border: 1px solid black;">
                                                                                <asp:Label ID="LblDistrict" runat="server"></asp:Label>
                                                                            </td>
                                                                            <td style="border: 1px solid black; font-weight: bold;">State
                                                                            </td>
                                                                            <td style="border: 1px solid black;">
                                                                                <asp:Label ID="LblState" runat="server"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="border: 1px solid black; font-weight: bold;">Mobile No.
                                                                            </td>
                                                                            <td style="border: 1px solid black;">
                                                                                <asp:Label ID="LblMobl" runat="server"></asp:Label>
                                                                            </td>
                                                                            <td style="border: 1px solid black; font-weight: bold;">Joining Date
                                                                            </td>
                                                                            <td style="border: 1px solid black;">
                                                                                <asp:Label ID="lblDoj" runat="server"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="border: 1px solid black; font-weight: bold;">Sponsor ID
                                                                            </td>
                                                                            <td style="border: 1px solid black;">
                                                                                <asp:Label ID="LblPlacementid" runat="server"></asp:Label>
                                                                            </td>
                                                                            <td style="border: 1px solid black; font-weight: bold;">Sponsor Name
                                                                            </td>
                                                                            <td style="border: 1px solid black;">
                                                                                <asp:Label ID="LblPlacementName" runat="server"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="border: 1px solid black; font-weight: bold;">Joining Kit
                                                                            </td>
                                                                            <td style="border: 1px solid black;">
                                                                                <asp:Label ID="LblKitName" runat="server"></asp:Label>
                                                                            </td>
                                                                            <td style="border: 1px solid black; font-weight: bold;">Kit Amount
                                                                            </td>
                                                                            <td style="border: 1px solid black;">
                                                                                <asp:Label ID="LblKitAmount" runat="server"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <%--<tr>
                                                                <td style="border: 1px solid black;">
                                                                    Application No.
                                                                </td>
                                                                <td style="border: 1px solid black;">
                                                                    <asp:Label ID="LblApplication" runat="server"></asp:Label>
                                                                </td>
                                                                <td style="border: 1px solid black;">
                                                                    Receipt No
                                                                </td>
                                                                <td style="border: 1px solid black;">
                                                                    <asp:Label ID="LblReceipt" runat="server"></asp:Label>
                                                                </td>
                                                            </tr>--%>
                                                                        <tr>
                                                                            <td style="border: 1px solid black; font-weight: bold;">Email ID
                                                                            </td>
                                                                            <td style="border: 1px solid black; font-weight: bold;">
                                                                                <asp:Label ID="LblEmail" runat="server"></asp:Label>
                                                                            </td>
                                                                            <td style="border: 1px solid black; font-weight: bold;">Pan No
                                                                            </td>
                                                                            <td style="border: 1px solid black;">
                                                                                <asp:Label ID="LblPanno" runat="server"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="border: 1px solid black; font-weight: bold;">Password
                                                                            </td>
                                                                            <td style="border: 1px solid black;">
                                                                                <asp:Label ID="LblPassw" runat="server"></asp:Label>
                                                                            </td>
                                                                            <td style="border: 1px solid black;"></td>
                                                                            <td style="border: 1px solid black;"></td>
                                                                        </tr>
                                                                    </table>
                                                                </p>
                                                                <p>
                                                                    <br>
                                                                    See you at the Top
                                                                </p>
                                                                <p class="text-success">
                                                                    CMD
                                                        <br />
                                                                    <strong>
                                                                        <%=Session["CompName"]%></strong>
                                                                </p>
                                                            </div>
                                                        </div>
                                                        <%--  <div class="col-md-12">
                                                    <div class="clearfix">
                                                    </div>
                                                    <hr>
                                                    <p>
                                                        &nbsp;
                                                    </p>
                                                </div>--%>
                                                    </div>
                                                </div>
                                                <%--</div>--%>
                                            </div>
                                            <p>
                                                &nbsp;
                                            </p>
                                            <p>
                                                &nbsp;
                                            </p>
                                            <div class="clearfix">
                                            </div>
                                            <p>
                                                &nbsp;
                                            </p>
                                            <p>
                                                &nbsp;
                                            </p>
                                            <hr>
                                        </div>
                                    </div>
                                    <%--<div class="form-vertical">
                                        <div style="margin-bottom: 30px;">
                                            <span id="ctl00_ContentPlaceHolder1_lblMsg" style="color: #C00000;"></span>
                                            <asp:Label ID="lblErrorMessage" runat="server" Text="" CssClass="error-message"></asp:Label>
                                        </div>


                                        <div class="row">
                                            <div class="span2"></div>
                                            <div class="span8">
                                                <div style="overflow: scroll;">
                                                    <div class="table-responsive">
                                                        <table class="table table-hover table-bordered">

                                                            <tbody>
                                                                <tr>
                                                                    <td>Member Name</td>
                                                                    <td>:</td>
                                                                    <td>
                                                                        <asp:Label ID="LblName1" runat="server"></asp:Label></td>
                                                                </tr>
                                                                <tr>
                                                                    <td>Member ID</td>
                                                                    <td>:</td>
                                                                    <td>
                                                                        <asp:Label ID="LblIdno1" runat="server"></asp:Label></td>
                                                                </tr>
                                                                <tr>
                                                                    <td>Joining Date</td>
                                                                    <td>:</td>
                                                                    <td>
                                                                        <asp:Label ID="lblDoj1" runat="server"></asp:Label></td>
                                                                </tr>
                                                                <tr>
                                                                    <td>Password</td>
                                                                    <td>:</td>
                                                                    <td>
                                                                        <asp:Label ID="lblPassw" runat="server"></asp:Label></td>
                                                                </tr>
                                                                <tr>
                                                                    <td>T. Password</td>
                                                                    <td>:</td>
                                                                    <td>
                                                                        <asp:Label ID="lblEPassw" runat="server"></asp:Label></td>
                                                                </tr>
                                                                <tr style="display: none;">
                                                                    <td>
                                                                        <h4>Sponsor Id :
                                                                        </h4>
                                                                    </td>
                                                                    <td>
                                                                        <h4>
                                                                            <b>
                                                                                <asp:Label ID="LblPlacementid" runat="server"></asp:Label></b></h4>
                                                                    </td>
                                                                </tr>
                                                                <tr style="display: none;">
                                                                    <td>
                                                                        <h4>Sponsor Name :
                                                                        </h4>
                                                                    </td>
                                                                    <td>
                                                                        <h4>
                                                                            <b>
                                                                                <asp:Label ID="LblPlacementName" runat="server"></asp:Label></b></h4>
                                                                    </td>
                                                                </tr>
                                                                <tr style="display: none;">
                                                                    <td>
                                                                        <h4>Joining Amount :
                                                                        </h4>
                                                                    </td>
                                                                    <td>
                                                                        <h4>
                                                                            <b>
                                                                                <asp:Label ID="LblKitAmount" runat="server"></asp:Label></b></h4>
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="span2"></div>
                                        </div>




                                    </div>--%>
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
