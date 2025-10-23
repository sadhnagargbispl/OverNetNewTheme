using System;
using System.Collections.Generic;
using System.ComponentModel.Design;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class profile : System.Web.UI.Page
{
    double _dblAvailLeg = 0;
    private clsGeneral dbGeneral = new clsGeneral();
    private cls_DataAccess dbConnect;

    private SqlCommand cmd = new SqlCommand();
    private SqlDataReader dRead;

    private string strQuery, strCaptcha;
    DataTable tmpTable = new DataTable();
    // AccClass.MyAccClass.NewClass QryCls = new AccClass.MyAccClass.NewClass();
    int minSpnsrNoLen, minScrtchLen;

    double Upln, dblSpons, dblTehsil, dblDistrict, dblIdNo;
    DateTime CurrDt;
    string[] montharray = { "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" };
    int LastInsertID = 0;
    string scrname;
    DAL Obj = new DAL();
    string IsoStart;
    string IsoEnd;
    string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
    string constr1 = ConfigurationManager.ConnectionStrings["constr1"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            this.BtnSubmit.Attributes.Add("onclick", DisableTheButton(this.Page, this.BtnSubmit));
            this.BtnOtp.Attributes.Add("onclick", DisableTheButton(this.Page, this.BtnOtp));
            this.ResendOtp.Attributes.Add("onclick", DisableTheButton(this.Page, this.ResendOtp));
            txtReferalId.ReadOnly = true;
            if (Session["Status"] == null)
            {
                Response.Redirect("Logout.aspx");
            }

            if (!Page.IsPostBack)
            {
                Session["OtpCount"] = 0;
                Session["OtpTime"] = null;
                Session["Retry"] = null;
                Session["OTP_"] = null;
                //FillCountryName();
                // Fill_State();
                FillDetail();
                //FillBankMaster();

            }
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff") + Environment.NewLine;
            Obj.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }

    }
    private void FillCountryMaster(int CID)
    {
        try
        {
            DataTable dt = new DataTable();
            strQuery = IsoStart + " SELECT CId, StdCode FROM " + Obj.dBName + "..M_CountryMaster WHERE ACTIVESTATUS = 'Y' and CId = '" + ddlCountryName.SelectedValue + "' ORDER BY StdCode" + IsoEnd;
            dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strQuery).Tables[0];

            if (dt.Rows.Count > 0)
            {
                ddlCountry.Text = dt.Rows[0]["StdCode"].ToString();
            }
        }
        catch (Exception ex)
        {
            // Handle the exception or log it as needed
        }
    }
    private void FillDetail()
    {
        try
        {
            string idverified = "";

            string sql = IsoStart + "exec sp_MemDtl ' and mMst.Formno=''" + Session["Formno"] + "'''" + IsoEnd;
            DataTable dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, sql).Tables[0];
            if (dt.Rows.Count > 0)
            {
                txtReferalId.Text = dt.Rows[0]["RefIDNo"] == DBNull.Value ? "" : dt.Rows[0]["RefIDNo"].ToString();
                TxtReferalNm.Text = dt.Rows[0]["RefName"].ToString();
                TxtUplinerid.Text = dt.Rows[0]["UpLnIDNo"] == DBNull.Value ? "" : dt.Rows[0]["UpLnIDNo"].ToString();
                TxtUplinerName.Text = dt.Rows[0]["UpLnName"].ToString();
                txtFrstNm.Text = dt.Rows[0]["MemName"].ToString();
                lblPosition.Text = Convert.ToInt32(dt.Rows[0]["LegNo"]) == 1 ? "Left" : "Right";
                txtFNm.Text = dt.Rows[0]["MemFname"].ToString();

                // DOB
                TxtDobDate.Text = Convert.ToDateTime(dt.Rows[0]["MemDob"]).ToString("dd-MMM-yyyy");
                if (TxtDobDate.Text == "01-Jan-1940")
                {
                    TxtDobDate.ReadOnly = false;
                }
                else
                {
                    TxtDobDate.ReadOnly = true;
                    CalendarExtender2.Enabled = false;
                }

                // DOJ & DOA
                TxtDoj.Text = Convert.ToDateTime(dt.Rows[0]["Doj"]).ToString("dd-MMM-yyyy");
                TxtDoa.Text = dt.Rows[0]["ActiveStatus"].ToString() == "Y"
                              ? Convert.ToDateTime(dt.Rows[0]["UpgradeDate"]).ToString("dd-MMM-yyyy")
                              : "";

                txtPhNo.Text = dt.Rows[0]["PhN1"].ToString();
                txtMobileNo.Text = dt.Rows[0]["Mobl"].ToString();
                txtEMailId.Text = dt.Rows[0]["EMail"].ToString();

                CmbType.SelectedItem.Text = dt.Rows[0]["MemRelation"].ToString();

                txtNominee.Text = dt.Rows[0]["NomineeName"].ToString();
                txtRelation.Text = dt.Rows[0]["Relation"].ToString();

                // Enable/Disable controls based on values
                txtFNm.Enabled = string.IsNullOrEmpty(txtFNm.Text);
                //txtMobileNo.Enabled = txtMobileNo.Text;
                txtPhNo.Enabled = txtPhNo.Text.Length < 10;
                txtEMailId.Enabled = string.IsNullOrEmpty(txtEMailId.Text);
                txtNominee.Enabled = string.IsNullOrEmpty(txtNominee.Text);
                txtRelation.Enabled = string.IsNullOrEmpty(txtRelation.Text);

                /*
                if (idverified == "Y")
                {
                    TxtBank.Enabled = false;
                    TxtBranchName.Enabled = false;
                    TxtAccountNo.Enabled = false;
                    DDLAccountType.Enabled = false;
                    CmbBank.Enabled = false;
                    txtIfsCode.Enabled = false;
                }
                else
                {
                    TxtBank.Enabled = true;
                    TxtBranchName.Enabled = true;
                    TxtAccountNo.Enabled = true;
                    DDLAccountType.Enabled = true;
                    CmbBank.Enabled = true;
                    txtIfsCode.Enabled = true;
                }
                */
            }
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff") + Environment.NewLine;
            Obj.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }

    }
    protected void ddlCountryName_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            FillCountryMaster(Convert.ToInt32(ddlCountryName.SelectedValue));
        }
        catch (Exception ex)
        {
            // Handle the exception or log it as needed
        }
    }
    private string ClearInject(string strObj)
    {
        try
        {
            strObj = strObj.Replace(";", "").Replace("'", "").Replace("=", "");
            return strObj.Trim();
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff") + Environment.NewLine;
            Obj.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
            return string.Empty; // Return empty string in case of an exception
        }
    }
    private string DisableTheButton(System.Web.UI.Control pge, System.Web.UI.Control btn)
    {
        try
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append("if (typeof(Page_ClientValidate) == 'function') {");
            sb.Append("if (Page_ClientValidate() == false) { return false; }} ");
            sb.Append("if (confirm('Are you sure to proceed?') == false) { return false; } ");
            sb.Append("this.value = 'Please wait...';");
            sb.Append("this.disabled = true;");
            sb.Append(pge.Page.GetPostBackEventReference(btn));
            sb.Append(";");
            return sb.ToString();
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
    public bool SendMail(string otp)
    {
        try
        {
            string strMsg = "";
            string emailAddress = Session["EMail"].ToString().Trim();
            System.Net.Mail.MailAddress sendFrom = new System.Net.Mail.MailAddress(Session["CompMail"].ToString());
            System.Net.Mail.MailAddress sendTo = new System.Net.Mail.MailAddress(emailAddress);
            System.Net.Mail.MailMessage myMessage = new System.Net.Mail.MailMessage(sendFrom, sendTo);

            strMsg = "<table style=\"margin:0; padding:10px; font-size:12px; font-family:Verdana, Arial, Helvetica, sans-serif; line-height:23px; text-align:justify;width:100%\"> " +
                     "<tr>" +
                     "<td>" +
                     "Your OTP for Profile is <span style=\"font-weight: bold;\">" + otp + "</span> (valid for 5 minutes)." +
                     "<br />" +
                     "</td>" +
                     "</tr>" +
                     "</table>";

            myMessage.Subject = "Thanks For Connecting!!!";
            myMessage.Body = strMsg;
            myMessage.IsBodyHtml = true;

            System.Net.Mail.SmtpClient smtp = new System.Net.Mail.SmtpClient(Session["MailHost"].ToString());
            smtp.UseDefaultCredentials = false;
            smtp.Port = 587;
            smtp.EnableSsl = true;
            smtp.DeliveryMethod = System.Net.Mail.SmtpDeliveryMethod.Network;
            smtp.Credentials = new System.Net.NetworkCredential(Session["CompMail"].ToString(), Session["MailPass"].ToString());
            smtp.Send(myMessage);
            txtReferalId.Enabled = false;
            TxtWalletAddress.Enabled = false;
            txtFrstNm.ReadOnly = true;
            CmbType.Enabled = true;
            txtFNm.ReadOnly = true;
            txtEMailId.Enabled = false;
            txtMobileNo.Enabled = false;
            TxtDoa.Enabled = false;
            TxtDoj.Enabled = false;
            txtFNm.Enabled = false;
            txtFrstNm.Enabled = false;
            return true;
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
    protected void BtnSubmit_Click(object sender, EventArgs e)
    {
        //try
        //{
        //    DataTable DtEmail = new DataTable();
        //    DataSet DsEmail = new DataSet();
        //    string strSql = IsoStart + "SELECT CASE WHEN EXISTS (SELECT 1 FROM Sriverse..M_Membermaster WHERE walletaddress = '" + TxtWalletAddress.Text.Trim() + "' AND formno = '" + Session["formno"] + "') THEN 0 ";
        //    strSql += " ELSE (SELECT COUNT(walletaddress) FROM Sriverse..M_Membermaster WHERE walletaddress = '" + TxtWalletAddress.Text.Trim() + "') END AS walletaddress " + IsoEnd;
        //    DsEmail = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strSql);
        //    DtEmail = DsEmail.Tables[0];
        //    if (Convert.ToInt32(DtEmail.Rows[0]["walletaddress"]) >= 1)
        //    {
        //        TxtWalletAddress.Text = "";
        //        string scrname = "<script language='javascript'>alert('Already Registered by this Wallet Address.!');</script>";
        //        ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Login Error", scrname, false);
        //        return;
        //    }
        //    else
        //    {
        //        int OTP_ = 0;
        //        Random rs = new Random();
        //        OTP_ = rs.Next(100001, 999999);

        //        if (Session["OTP_"] == null)
        //        {
        //            if (SendMail(OTP_.ToString()))
        //            {
        //                Session["OtpTime"] = DateTime.Now.AddMinutes(5);
        //                Session["Retry"] = "1";
        //                Session["OTP_"] = OTP_;
        //                int i = 0;
        //                string query = "";
        //                query = "INSERT INTO AdminLogin (UserID, Username, Passw, MobileNo, OTP, LoginTime, emailotp, EmailID, ForType) ";
        //                query += "VALUES ('" + Session["formno"] + "', '" + Session["MemName"] + "', '" + TxtOtp.Text + "', '0', '" + OTP_ + "', GETDATE(), '" + OTP_ + "', ";
        //                query += "'" + Session["EMail"].ToString().Trim() + "', 'Profile')";
        //                i = Convert.ToInt32(SqlHelper.ExecuteNonQuery(constr, CommandType.Text, query));
        //                if (i > 0)
        //                {
        //                    divotp.Visible = true;
        //                    BtnSubmit.Visible = false;
        //                    BtnOtp.Visible = true;
        //                    ResendOtp.Visible = true;
        //                    string scrname = "<script language='javascript'>alert('OTP Sent On Mail');</script>";
        //                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Login Error", scrname, false);
        //                    return;
        //                }
        //                else
        //                {
        //                    string scrname = "<script language='javascript'>alert('Try Later');</script>";
        //                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Login Error", scrname, false);
        //                    return;
        //                }
        //            }
        //            else
        //            {
        //                string scrname = "<script language='javascript'>alert('OTP Try Later');</script>";
        //                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Login Error", scrname, false);
        //                return;
        //            }
        //        }
        //        else
        //        {
        //            txtReferalId.Enabled = false;
        //            TxtWalletAddress.Enabled = false;
        //            txtFrstNm.ReadOnly = true;
        //            CmbType.Enabled = true;
        //            txtFNm.ReadOnly = true;
        //            txtEMailId.Enabled = false;
        //            txtMobileNo.Enabled = false;
        //            TxtDoa.Enabled = false;
        //            TxtDoj.Enabled = false;
        //            txtFNm.Enabled = false;
        //            txtFrstNm.Enabled = false;
        //            divotp.Visible = true;
        //            BtnSubmit.Visible = false;
        //            BtnOtp.Visible = true;
        //            ResendOtp.Visible = false;
        //        }
        //    }
        //}
        //catch (Exception ex)
        //{
        //    string scrName = "<SCRIPT language='javascript'>alert('Email Try Later');</SCRIPT>";
        //    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Error", scrName, false);
        //}
        try
        {
            UpdateDb();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", "alert('" + ex.Message + "')", true); ;

        }
    }
    protected void BtnOtp_Click(object sender, EventArgs e)
    {
        try
        {
            string scrname = "";
            string email = "";
            DataTable dt = new DataTable();
            string transPassw = TxtOtp.Text.Trim();
            DataTable dt1 = new DataTable();
            Session["OtpCount"] = Convert.ToInt32(Session["OtpCount"]) + 1;

            if (Session["OTP_"] != null && Session["OTP_"].ToString() == transPassw)
            {
                string query = Obj.Isostart + "SELECT TOP 1 * FROM " + Obj.dBName + "..AdminLogin AS a WHERE EmailID = '" + Session["EMail"].ToString().Trim() + "' AND emailotp = '" + transPassw + "' AND ForType = 'Profile' ORDER BY AID DESC" + Obj.IsoEnd;
                dt1 = SqlHelper.ExecuteDataset(constr1, CommandType.Text, query).Tables[0];

                if (dt1.Rows.Count > 0)
                {
                    UpdateDb();
                }
            }
            else
            {
                TxtOtp.Text = "";

                if (Convert.ToInt32(Session["OtpCount"]) >= 3)
                {
                    Session["OtpCount"] = 0;
                    scrname = "<script language='javascript'>alert('You have tried 3 times with invalid OTP.\\nPlease generate OTP again.');</script>";
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", scrname, true);
                    ResendOtp.Visible = true;
                    BtnOtp.Visible = true;
                    divotp.Visible = false;
                }
                else
                {
                    scrname = "<script language='javascript'>alert('Invalid OTP.');</script>";
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", scrname, true);
                }
            }
        }
        catch (Exception ex)
        {
            // Handle exception
        }
    }
    protected void ResendOtp_Click(object sender, EventArgs e)
    {
        try
        {
            Session["OTP_"] = "";
            int OTP_ = 0;
            Random rs = new Random();
            OTP_ = rs.Next(100001, 999999);

            if (SendMail(OTP_.ToString()))
            {
                string emailId = Session["Email"].ToString();
                string memberName = "";
                string mobileNo = "0";
                string sms = "";
                int result = 0;
                string query = "";

                query = "INSERT INTO AdminLogin (UserID, Username, Passw, MobileNo, OTP, LoginTime, emailotp, EmailID, ForType) " +
                        "VALUES ('0', '" + memberName + "', '" + TxtOtp.Text + "', '" + mobileNo + "', '" + OTP_ + "', GETDATE(), '" + OTP_ + "', " +
                        "'" + Session["EMail"].ToString().Trim() + "', 'Profile')";

                result = Convert.ToInt32(SqlHelper.ExecuteNonQuery(constr, CommandType.Text, query));

                if (result > 0)
                {
                    Session["OTP_"] = OTP_;
                    divotp.Visible = true;
                    BtnOtp.Visible = true;
                    ResendOtp.Visible = true;
                    string scrname = "<script language='javascript'>alert('OTP Sent On Mail');</script>";
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Login Error", scrname, false);
                    return;
                }
                else
                {
                    string scrname = "<script language='javascript'>alert('Try Later');</script>";
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Login Error", scrname, false);
                    return;
                }
            }
            else
            {
                string scrname = "<script language='javascript'>alert('OTP Try Later');</script>";
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Login Error", scrname, false);
                return;
            }
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
    private void UpdateDb()
    {
        try
        {
            //if (hdnidno.Value.ToString().ToUpper() != Session["IDNo"].ToString().ToUpper())
            //{
            //    string scrname = "<SCRIPT language='javascript'>alert('Profile cannot be changed, Please try later.!!');</SCRIPT>";
            //    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Login Error", scrname, false);
            //    return;
            //}      
            string strQry = "";
            DateTime strDOB;
            DateTime strDOBmerriage;
            string Remark = "";
            string MembName = "";
            string Password = "";
            string TransactionPassword = "";

            try
            {
                string str = "";
                DataTable dt1 = new DataTable();

                try
                {
                    strDOB = DateTime.Parse(TxtDobDate.Text);
                }
                catch (Exception)
                {
                    strDOB = DateTime.Now;
                }
                try
                {
                    strDOBmerriage = DateTime.Parse(txtdmarriage.Text);
                }
                catch (Exception)
                {
                    strDOBmerriage = DateTime.Now;
                }


                txtPhNo.Text = string.IsNullOrEmpty(txtPhNo.Text) ? "0" : txtPhNo.Text;
                str = IsoStart + "select * from " + Obj.dBName + "..M_MemberMaster where Formno='" + Session["Formno"] + "'" + IsoEnd;
                dt1 = SqlHelper.ExecuteDataset(constr1, CommandType.Text, str).Tables[0];
                if (dt1.Rows.Count > 0)
                {
                    MembName = dt1.Rows[0]["MemFirstName"].ToString() + " " + dt1.Rows[0]["MemLastName"].ToString();
                    Password = dt1.Rows[0]["Passw"].ToString();
                    TransactionPassword = dt1.Rows[0]["EPassw"].ToString();

                    if (ClearInject(dt1.Rows[0]["MemFirstName"].ToString()) != ClearInject(txtFrstNm.Text))
                    {
                        Remark += " Member Name,";
                    }

                    if (dt1.Rows[0]["MemDob"].ToString() != strDOB.ToString())
                    {
                        Remark += " Dob,";
                    }

                    if (dt1.Rows[0]["CountryId"] != ddlCountryName.SelectedValue)
                    {
                        Remark += " Country,";
                    }

                    if (ClearInject(dt1.Rows[0]["PhN1"].ToString()) != ClearInject(txtPhNo.Text))
                    {
                        Remark += " PhoneNo,";
                    }

                    if (ClearInject(dt1.Rows[0]["usercode"].ToString()) != ClearInject(ddlCountry.Text))
                    {
                        Remark += " UserCode,";
                    }

                    if (ClearInject(dt1.Rows[0]["Mobl"].ToString()) != ClearInject(txtMobileNo.Text))
                    {
                        Remark += " MobileNo,";
                    }

                    if (ClearInject(dt1.Rows[0]["Email"].ToString()) != ClearInject(txtEMailId.Text))
                    {
                        Remark += " Email,";
                    }

                    if (ClearInject(dt1.Rows[0]["NomineeName"].ToString()) != ClearInject(txtNominee.Text))
                    {
                        Remark += " NomineeName,";
                    }

                    if (ClearInject(dt1.Rows[0]["Relation"].ToString()) != ClearInject(txtRelation.Text))
                    {
                        Remark += " Relation,";
                    }

                    
                    if (ClearInject(dt1.Rows[0]["Acno"].ToString()) != ClearInject(TxtAccountNo.Text))
                    {
                        Remark += " Account No,";
                    }
                    if (ClearInject(dt1.Rows[0]["Fax"].ToString()) != ClearInject(DDLAccountType.Text))
                    {
                        Remark += " Account Type,";
                    }
                    if (ClearInject(dt1.Rows[0]["BankName"].ToString()) != ClearInject(CmbBank.Text))
                    {
                        Remark += " Bank Name,";
                    }
                    if (ClearInject(dt1.Rows[0]["Branchname"].ToString()) != ClearInject(TxtBranchName.Text))
                    {
                        Remark += " Branch Name,";
                    }
                    if (ClearInject(dt1.Rows[0]["IFSCode"].ToString()) != ClearInject(txtIfsCode.Text))
                    {
                        Remark += " IFSC Code,";
                    }



                    Remark += " Changed";
                }
                string sqlUpdate = "UPDATE M_MemberMaster SET " +
                                   "MemFirstName = '" + ClearInject(txtFrstNm.Text.ToUpper()) + "', " +
                                   "MemFName = '" + ClearInject(txtFNm.Text.ToUpper()) + "', " +
                                   "MemDOB = '" + Convert.ToDateTime(strDOB).ToString("dd-MMM-yyyy") + "', " +
                                   "PhN1 = '" + ClearInject(txtPhNo.Text) + "', " +
                                   "Mobl = '" + ClearInject(txtMobileNo.Text) + "', " +
                                   "EMail = '" + ClearInject(txtEMailId.Text) + "', " +
                                   "NomineeName = '" + ClearInject(txtNominee.Text.ToUpper()) + "', " +
                                   "Relation = '" + ClearInject(txtRelation.Text.ToUpper()) + "' " +
                                   "WHERE FormNo = " + Session["FormNo"];
                // Backup and history insert
                string Qry = "INSERT INTO TempMemberMaster " +
                             "SELECT *, 'Update Profile - " + Context.Request.UserHostAddress.ToString() + "', GETDATE(), 'U' " +
                             "FROM M_MemberMaster WHERE FormNo = '" + Session["FormNo"] + "';";

                Qry += " INSERT INTO UserHistory(UserId, UserName, PageName, Activity, ModifiedFlds, RecTimeStamp, MemberId) VALUES " +
                       "(0, '" + Session["MemName"] + "', 'Profile', 'Profile Update', '" + Remark + "', GETDATE(), '" + Session["FormNo"] + "');";

                // Combine both queries
                Qry += sqlUpdate;
                int i = Obj.SaveData(Qry);
                string message = (i != 0) ? "Profile Successfully Updated.!" : "Try Again Later.!";
                string url = "Profile.aspx";
                string script = "window.onload = function(){ alert('" + message + "'); window.location = '" + url + "'; }";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "Redirect", script, true);

                BtnSubmit.Visible = true;
                //BtnOtp.Visible = false;
                //divotp.Visible = false;
            }
            catch (Exception e)
            {
                string scrname = "<SCRIPT language='javascript'>alert('" + e.Message + "');</SCRIPT>";
                ClientScript.RegisterStartupScript(this.GetType(), "MyAlert", scrname, true);
                dbGeneral.myMsgBx(e.Message);
            }
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff") + Environment.NewLine;
            Obj.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }
    }
}
