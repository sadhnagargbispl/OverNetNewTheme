<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewPinTransferDetail.aspx.cs" Inherits="ViewPinTransferDetail" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <!-- bootstrap theme -->
    <link href="css/bootstrap-theme.css" rel="stylesheet">
    <!--external css-->
    <!-- font icon -->
    <link href="css/Grid.css" rel="Stylesheet" type="text/css" />
    <link href="css/elegant-icons-style.css" rel="stylesheet" />
    <link href="css/font-awesome.min.css" rel="stylesheet" />
    <!-- Custom styles -->
    <link href="css/style.css" rel="stylesheet" />
    <link href="css/style-responsive.css" rel="stylesheet" />
    <%--<link href="adminassets/main.css" rel="stylesheet" type="text/css" />--%>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="LblNo" runat="server" ForeColor="Black" Font-Size="2px"></asp:Label>
        </div>
        <div style="margin-bottom: 10px; padding-right: 20px; padding-left: 20px; padding-top: 20px">
            <asp:GridView ID="GvData" runat="server" AutoGenerateColumns="false"
                GridLines="Both" AllowPaging="true" CssClass="table table-bordered" HeaderStyle-BackColor="#000000" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Left"
                ShowHeader="true" PageSize="50" EmptyDataText="No data to display." OnPageIndexChanging="RptDirects_PageIndexChanging" Style="width: 100%; border-collapse: collapse; font-size: 0.7em;">
                <Columns>
                    <asp:TemplateField HeaderText="S.No.">
                        <ItemTemplate>
                            <%#Container.DataItemIndex + 1%>.
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="ToIdno" HeaderText="Transfer To Id"></asp:BoundField>
                    <asp:BoundField DataField="ToMemname" HeaderText="Transfer To Entrepreneur"></asp:BoundField>
                    <asp:BoundField DataField="KitName" HeaderText="Package Name"></asp:BoundField>
                    <asp:BoundField DataField="pinno" HeaderText="Pin No"></asp:BoundField>
                    <asp:BoundField DataField="ScratchNo" HeaderText="Scratch No"></asp:BoundField>
                    <asp:BoundField DataField="PinDate" HeaderText="Date"></asp:BoundField>
                    <asp:BoundField DataField="PinStatus" HeaderText="Status"></asp:BoundField>
                    <asp:BoundField DataField="Remark" HeaderText="Remark"></asp:BoundField>
                </Columns>
            </asp:GridView>
        </div>
        <br />
        <br />
    </form>
</body>
</html>
