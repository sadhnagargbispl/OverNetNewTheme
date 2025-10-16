<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Welcome to Admin Dashboard </title>
  <link rel="stylesheet" type="text/css" href="./files/bootstrap.min.css">
  <link rel="stylesheet" type="text/css" href="./files/fontawesome-all.min.css">
  <link rel="stylesheet" type="text/css" href="./files/iofrm-style.css">
  <link rel="stylesheet" type="text/css" href="./files/iofrm-theme17.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  <style>

      .bg {
          background-image: url("files/img1.jpg")!important;
          background-size: cover;
      }
      .website-logo .logo img.logo-size {
          opacity: 1 !important;
      }
      .icon{
          width: 21px; 
          height: 21px; 
          font-size: 12px;
      }
  </style>
</head>
<body>
    <%--<form id="form1" runat="server">--%>
<div class="form-body without-side">
    <div class="row">
        <div class="img-holder">
            <div class="bg"></div>
        </div>
        <div class="form-holder">
            <div class="form-content">
                <div class="form-items">
                    <div class="">
                        <div class="logo">
                            <img class="logo-size" style="width: 230px; display: block; margin:0 auto 10px auto" src="../panel-images/demo_logo.png" alt=""> <hr>
                        </div>
                    </div>
                    <h3>Login to account</h3> <br/>
                    <form action="dashboard.asp">
                        <input class="input-xxlarge" type="text" name="username" placeholder="User Id" >
                        <input class="input-xxlarge" type="password" name="password" placeholder="Password" >
                        <div class="form-button">
                            <button id="submit" type="submit" class="ibtn">
                                <a href="dashboard.asp">Login</a>
                            </button> 
                            <a href="#">Forget password?</a>
                        </div>
                    </form>
                
                   <%-- <div class="other-links">
                        <div class="text">Or Login with</div>
                        <a href="#"><i class="fa fa-facebook" aria-hidden="true" style="background: #3B5998; color: white; width: 21px; height: 21px; font-size: 12px;"></i></a>
                        <a href="#"><i class="fa fa-instagram" aria-hidden="true" style="background: #e4405f; color: white; width: 21px; height: 21px; font-size: 12px;" ></i></a>
                        <a href="#"><i class="fa fa-telegram" aria-hidden="true" style="background: #0088cc; color: white; width: 21px; height: 21px; font-size: 12px;"></i></a>
                        <a href="#"><i class="fa fa-youtube-play" aria-hidden="true" style="background: #FF0000; color: white; width: 21px; height: 21px; font-size: 12px;"></i></a>
                    </div>--%>
                    <div class="page-links">
                        <a href="#">Register new account</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="./files/jquery.min.js.download"></script>
<script src="./files/popper.min.js.download"></script>
<script src="./files/bootstrap.min.js.download"></script>
<script src="./files/main.js.download"></script>


<script src="../disable.js"></script>
  <%--  </form>--%>
</body>
</html>
