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
                                    <h4><i class="icon-credit-card"></i>Welcome</h4>
                                    <span class="tools">
                                        <a href="javascript:;" class="icon-chevron-down"></a>
                                    </span>
                                </div>
                                <div class="clr">
                                    <asp:Label ID="errMsg" runat="server" CssClass="error"></asp:Label>
                                </div>
                                <div class="widget-body">
                                    <div class="form-vertical">
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
