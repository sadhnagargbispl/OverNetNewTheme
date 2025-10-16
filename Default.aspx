<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>
        <%=Session["Title"].ToString ()%></title>
    <script type="text/javascript">
        window.history.forward();
        function noBack() {
            window.history.forward();
        }
    </script>
    <link rel="stylesheet" type="text/css" href="files/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="files/fontawesome-all.min.css" />
    <link rel="stylesheet" type="text/css" href="files/iofrm-style.css" />
    <link rel="stylesheet" type="text/css" href="files/iofrm-theme17.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js">
    </script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js">
    </script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js">
    </script>
    <style>
        .bg {
            background-image: url("files/img1.jpg") !important;
            background-size: cover;
        }

        .website-logo .logo img.logo-size {
            opacity: 1 !important;
        }

        .icon {
            width: 21px;
            height: 21px;
            font-size: 12px;
        }
    </style>
    <script type="text/javascript" src="highslide/highslide-full.js"></script>

    <link rel="stylesheet" type="text/css" href="highslide/highslide.css" />

    <script type="text/javascript">
        hs.graphicsDir = 'highslide/graphics/';
        hs.align = 'center';
        hs.transitions = ['expand', 'crossfade'];
        hs.fadeInOut = true;
        hs.dimmingOpacity = 0.8;
        hs.outlineType = 'rounded-white';
        hs.marginTop = 60;
        hs.marginBottom = 40;
        hs.numberPosition = '';
        hs.wrapperClassName = 'custom';
        hs.width = 600;
        hs.height = 500;
        hs.number = 'Page %1 of %2';
        hs.captionOverlay.fade = 0;

        // Add the slideshow providing the controlbar and the thumbstrip

    </script>

    <!--Slider-in icons-->
    <!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->

    <script language="javascript" type="text/javascript">
        function PutCursor() {
            document.loginform.Txtuid.focus();
        }
    </script>

    <script type="text/javascript">
        function disableBackButton() {
            window.history.forward();
        }
        setTimeout("disableBackButton()", 0);
    </script>

    <script type="text/javascript">

        history.pushState(null, null, location.href);
        window.onpopstate = function () {
            history.go(1);
        };

    </script>
</head>
<body>
    <form id="loginform" runat="server">
        <div class="form-body without-side">
            <!-- <div class="website-logo">
         <a href="#">
             <div class="logo">
                 <img class="logo-size" src="./files/logo-light.svg" alt="">
             </div>
         </a>
     </div> -->
            <div class="row">
                <div class="img-holder">
                    <div class="bg"></div>
                </div>
                <div class="form-holder">
                    <div class="form-content">

                        <div class="form-items">
                            <!--Logo-->
                            <div class="">
                                <div class="logo">
                                    <img src="" runat="server" id="imgLogo" class="logo-size" style="width: 230px; display: block; margin: 0 auto 10px auto">
                                    <%-- <img class="logo-size" style="width: 230px; display: block; margin:0 auto 10px auto" src="assets/images/logo_wt.png" alt="">--%>
                                    <hr>
                                </div>
                            </div>
                            <h3>Login to account</h3>
                            <br />

                            <input class="input-xxlarge" type="text" runat="server" id="Txtuid" name="uid" placeholder="User Id" required="">
                            <input class="input-xxlarge" type="password" runat="server" id="Txtpwd" name="pwd" placeholder="Password" required="">
                            <div class="form-button">
                                <%--       <asp:Button ID="BtnSubmit" runat="server" Text="Login" type="submit" class="ibtn" OnClick="BtnSubmit_Click" />--%>
                                <button type="submit" class="ibtn" id="BtnSubmit" runat="server" onserverclick="BtnSubmit_ServerClick">
                                    Login
                                </button>
                                <a href="Forgot.aspx" onclick="return hs.htmlExpand(this, { objectType: 'iframe',width: 550,height: 280,marginTop : 0 } )">Forget password?</a>
                            </div>

                            <div class="other-links">
                               
                            </div>
                            <div class="page-links" style="display: none;">
                                <a href="Newjoining1.aspx">Register new account</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </form>
    <script src="files/jquery.min.js.download"></script>
    <script src="files/popper.min.js.download"></script>
    <script src="files/bootstrap.min.js.download"></script>
    <script src="files/main.js.download"></script>
</body>
</html>
