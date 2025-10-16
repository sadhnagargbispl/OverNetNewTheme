<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="welcome.aspx.cs" Inherits="welcome" %>

<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" ID="content2" runat="server">
    <div class="container-fluid">
        <!-- BEGIN PAGE HEADER-->
        <div class="row-fluid">
            <div class="span12">
                <!-- BEGIN THEME CUSTOMIZER-->
                <!-- END THEME CUSTOMIZER-->
                <!-- BEGIN PAGE TITLE & BREADCRUMB-->
                <h3 class="page-title">Welcome </h3>
                <ul class="breadcrumb">
                    <li><a href="#"><i class="icon-home"></i></a><span class="divider">&nbsp;</span> </li>
                    <li><a href="#">Welcome</a><span class="divider-last">&nbsp;</span></li>
                </ul>

                <!-- END PAGE TITLE & BREADCRUMB-->

            </div>
        </div>

        <!--<div id="ctl00_ContentPlaceHolder1_Div2" class="alert alert-info">        
      <b>
      <span id="ctl00_ContentPlaceHolder1_Label2">Limited period special offer to activate/upgrade on purchasing of 'Impact Garments combo Rs.3500/- with 5100BV'</span></b></div>-->



        <div>



            <div class="row-fluid panelpart">


                <div class="row">
                    <div class="span2"></div>
                    <div class="span8">

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





            <div class="clearfix"></div>
            <p>&nbsp;</p>
            <hr>
        </div>

    </div>


    </div>





</asp:Content>
