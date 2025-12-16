<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Applogout.aspx.cs" Inherits="Applogout" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>
        <%=Session["Title"].ToString ()%></title>

</head>
<body>
    <form id="loginform" runat="server">

        <style>
            html, body, form {
                height: 100%;
                margin: 0;
            }

            .form-body.without-side {
                min-height: 100vh;
            }

            .session-row {
                min-height: 100vh;
                display: flex;
            }

            /* LEFT SIDE BG */
            .img-holder {
                flex: 1;
            }

            /* RIGHT SIDE */
            .form-holder {
                flex: 1;
                display: flex;
                align-items: center;
                justify-content: center;
                background: #f8f9fa;
            }

            .form-content {
                width: 100%;
                padding: 20px;
            }

            /* CARD */
            .session-card {
                background: #ffffff;
                padding: 40px 30px;
                border-radius: 12px;
                max-width: 420px;
                margin: auto;
                box-shadow: 0 10px 30px rgba(0,0,0,0.08);
            }

            /* ICON */
            .icon-circle {
                width: 70px;
                height: 70px;
                margin: 0 auto 15px;
                border-radius: 50%;
                background: rgba(13,110,253,0.1);
                display: flex;
                align-items: center;
                justify-content: center;
            }

                .icon-circle i {
                    font-size: 32px;
                    color: #0d6efd;
                }

            /* TEXT */
            .session-card p {
                color: #6c757d;
                font-size: 15px;
                line-height: 1.6;
                margin: 0;
                text-align: center;
            }
        </style>

        <div class="form-body without-side">
            <div class="row session-row">
                <!-- LEFT BG -->


                <!-- MESSAGE -->
                <div class="form-holder">
                    <div class="form-content text-center">
                        <div class="session-card">
                         
                            <p>
                                Please Logout And Login Again To Continue.!
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </form>


</body>
</html>
