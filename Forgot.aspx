<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Forgot.aspx.cs" Inherits="Forgot" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Forgot Password</title>

    <!-- Bootstrap -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />

    <style>
        body {
            background: linear-gradient(135deg, #e8ecf1, #f4f6f9);
            font-family: Arial, sans-serif;
        }

        .auth-card {
            width: 100%;
            max-width: 420px;
            border-radius: 14px;
            padding: 35px 30px;
            background: #ffffff;
            box-shadow: 0 6px 20px rgba(0,0,0,0.12);
        }

        .auth-title {
            font-weight: 700;
            font-size: 26px;
            margin-bottom: 25px;
            text-align: center;
        }
        /* Custom Button Color */
        .btn-custom {
            background-color: #591414 !important;
            border-color: #591414 !important;
            color: #fff !important;
            font-weight: bold;
        }

            .btn-custom:hover {
                background-color: #3d0d0d !important;
                border-color: #3d0d0d !important;
            }
    </style>
</head>

<body>
    <form id="form1" runat="server">

        <div class="container d-flex justify-content-center align-items-center"
            style="min-height: 100vh;">

            <div class="auth-card">

                <div class="auth-title">Forgot Password</div>

                <!-- User ID -->
                <div class="form-group">
                    <label class="font-weight-bold">User ID</label>
                    <asp:TextBox ID="txtIDNo" runat="server" CssClass="form-control form-control-lg"
                        MaxLength="15"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredIDNo" runat="server"
                        ControlToValidate="txtIDNo" ErrorMessage="* Required"
                        CssClass="text-danger" />
                </div>

                <!-- Mobile No -->
                <div class="form-group">
                    <label class="font-weight-bold">Mobile Number</label>
                    <asp:TextBox ID="TxtMobileNo" runat="server" CssClass="form-control form-control-lg"
                        MaxLength="10"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredMobile" runat="server"
                        ControlToValidate="TxtMobileNo" ErrorMessage="* Required"
                        CssClass="text-danger" />
                </div>

                <!-- Submit Button -->
                <asp:Button ID="Submit" runat="server"
                    Text="Submit"
                    CssClass="btn btn-custom btn-primary btn-block btn-lg mt-3"
                    OnClick="Submit_Click" />

            </div>

        </div>

    </form>
</body>
</html>
