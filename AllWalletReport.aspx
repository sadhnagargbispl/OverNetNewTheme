<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="AllWalletReport.aspx.cs" Inherits="AllWalletReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container-fluid">
        <!-- BEGIN PAGE HEADER-->
        <div class="row-fluid">
            <div class="span12">
                <!-- BEGIN THEME CUSTOMIZER-->
                <!-- END THEME CUSTOMIZER-->
                <!-- BEGIN PAGE TITLE & BREADCRUMB-->
                <h3 class="page-title">All Wallet Report </h3>
                <ul class="breadcrumb">
                    <li><a href="#"><i class="icon-home"></i></a><span class="divider">&nbsp;</span> </li>
                    <li><a href="#">All Wallet Report</a><span class="divider-last">&nbsp;</span></li>
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
                    <div class="span6">
                        <div class="table-responsive">
                            <table class="table table-hover table-bordered">
                                <tr>
                                    <td>
                                        <b>Wallet Type :</b>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlVoucherType" runat="server" CssClass="input-xxlarge">
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-danger" OnClick="btnSearch_Click" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <hr>
                    </div>

                </div>
                <div class="clearfix"></div>
                <div class="row">
                    <div class="span6">
                        <div class="table-responsive">
                            <table class="table table-hover table-bordered">

                                <tbody>
                                    <tr>
                                        <td>Deposit</td>
                                        <td>:</td>
                                        <td id="MCredit" runat="server">0.00</td>
                                    </tr>
                                    <tr>
                                        <td>Used</td>
                                        <td>:</td>
                                        <td id="MDebit" runat="server">0.00</td>
                                    </tr>
                                    <tr>
                                        <td>Balance</td>
                                        <td>:</td>
                                        <td id="MBal" runat="server">0.00</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>


                    </div>



                </div>
                <div class="clearfix"></div>
                <div class="row">
                    <div class="span12">
                        <div class="table-responsive" style=" overflow:scroll;">
                            <asp:GridView ID="RptDirects" runat="server" AutoGenerateColumns="true"
                                CssClass="table table-bordered" EmptyDataText="No data to display." AllowPaging="true" PageSize="10" OnPageIndexChanging="RptDirects_PageIndexChanging" >
                                <Columns>
                                </Columns>
                            </asp:GridView>
                        </div>


                    </div>
                    <div class="clearfix"></div>
                </div>
                <div class="clearfix"></div>
                <p>&nbsp;</p>
                <hr>
            </div>


        </div>


    </div>


</asp:Content>
