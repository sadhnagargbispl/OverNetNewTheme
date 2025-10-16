<!DOCTYPE html>
<html lang="en">
    <head>
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
            .form-body.without-side .form-content .dropdown-toggle.btn-default{
                display: none !important;
            }
            .form-check{
                padding-left: 0 !important;
            }
            .width-500{
                max-width: 500px !important;
            }
            .form-content input[type="checkbox"], .form-content input[type="radio"] {
                width: auto;
                display: none;
            }
            .ibtn{
                width: 100%;
                background-color: #29A4FF !important;
                border: 0;
                color: white;
            }
            @media only screen and (max-width : 767px){
                .width-500{
                    min-height: 0 !important;
                    max-height: 70ch !important;
                    height: auto !important;
                    overflow: scroll;
                }
                .form-body.without-side .form-holder .form-content {
                    padding: 15px 10px 20px !important;
                }
            }
        </style>
    </head>
    <body>
        <div class="form-body without-side">
            <div class="row">
                <div class="img-holder">
                    <div class="bg"></div>
                </div>
                <div class="form-holder">
                    <div class="form-content">
                        <div class="form-items width-500">
                            <div class="">
                                <div class="logo">
                                    <img class="logo-size" style="width: 230px; display: block; margin:0 auto 10px auto" src="../panel-images/demo_logo.png" alt=""> <hr>
                                </div>
                            </div>
                            <h3>New Joining</h3> <br/>
                            <p class="mb-4 text-dark">Asterisk <b class="text-dark">(*)</b> sign indicates mandatory fields.</p>
                            <form action="dashboard.html">
      
      
                                <div class="form-group">
                                  <label for="exampleInputEmail1 text-black" class="active">Sponsor ID </label>
                                  <input type="email" class="input-xxlarge" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter Sponsor ID">
                                </div>
                              
                                <div class="form-group">
                                  <label for="exampleInputEmail1 text-black" class="active">Name</label>
                                  <input type="email" class="input-xxlarge" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter Name">
                                </div>
                              
                                <div class="form-group">
                                  <label for="exampleInputEmail1 text-black" class="active">Father / Husband's Name</label>
                                  <input type="email" class="input-xxlarge" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter Father / Husband's Name">
                                </div>
                              
                              
                                <div class="form-group">
                                  <label for="exampleInputEmail1 text-black" class="active">Address </label>
                                  <input type="email" class="input-xxlarge" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter Address">
                                </div>
                              
                              
                                <div class="form-group">
                                  <label for="exampleInputEmail1 text-black" class="active">Pin code </label>
                                  <input type="email" class="input-xxlarge" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter Pin code">
                                </div>
                              
                              
                                <div class="form-group select-control">
                                  <label for="exampleInputEmail1 text-black">State</label>
                                  <select name="" id="input" class="input-xxlarge" required="required">
                                    <option value="" selected="" disabled="">Select State</option>
                                    <option value="">Select State</option>
                                    <option value="">Select State</option>
                                    <option value="">Select State</option>
                                  </select>
                                  
                                </div>
                              
                                <div class="form-group">
                                  <label for="exampleInputEmail1 text-black" class="active">District</label>
                                  <input type="email" class="input-xxlarge" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter District">
                                </div>
                              
                              
                                <div class="form-group">
                                  <label for="exampleInputEmail1 text-black" class="active">City</label>
                                  <input type="email" class="input-xxlarge" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter City">
                                </div>
                              
                              
                              
                              
                                <div class="form-group">
                                  <label for="exampleInputEmail1 text-black" class="active">Mobile No. </label>
                                  <input type="email" class="input-xxlarge" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter Mobile No.">
                                </div>
                              
                                <div class="form-group">
                                  <label for="exampleInputEmail1 text-black" class="active">E-Mail ID. *</label>
                                  <input type="email" class="input-xxlarge" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter User ID">
                                </div>
                              
                              <br>
                                <div class="form-group">
                                  <textarea name="ctl00$ContentPlaceHolder1$TCAllCompany" id="ctl00_ContentPlaceHolder1_TCAllCompany" style="font-size: 13px; width: 100%; height: 80px; text-align: left;" cols="5" rows="10" readonly="readonly">Terms &amp; Conditions :-
                                          •It is kind advise to you that you promote Business as per actual. Company will not responsible for your miss commitments in the market through any manner.
                                          •Registration is FREE in our system.
                                          •Company provides you online account as your ID with password. It contains all your legal information , Transaction Balance, Team detail, Bonus details etc.
                                          •Year starts from 1st April every year.
                                          •KYC Documents is mandatory.
                                          •You must sign your application form &amp; submitted in nearest company Branch/office along with one colour passport size photo &amp; copy of self attested ID proof or address proof / PAN No.
                                </textarea>
                                </div>
                                <br>
                        
                                <div class="form-group">
                                  <input type="checkbox" id="vehicle1" name="vehicle1" value="Bike">
                                  <label for="vehicle1"> I Agree With Terms And Condition </label>
                                </div>
                              
                                
                                <div class="form-check">
                                  <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault1">
                                  <label class="form-check-label" for="flexRadioDefault1">
                                    Default radio
                                  </label>
                                </div>
                                <div class="form-check">
                                  <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault2" checked="">
                                  <label class="form-check-label" for="flexRadioDefault2">
                                    Default checked radio
                                  </label>
                                </div>
                              
                              <br>
                              
                                <div class="button">
                                  <a href="dashboard.asp">  <button type="submit" class="ibtn">Login</button> </a>
                                </div>
                              
                              
                              </form>
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

        
    </body>
</html>