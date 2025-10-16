using ClosedXML.Excel;
using System;
using System.CodeDom;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Net.Mail;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Activities.Expressions;
using System.Xml;
using Newtonsoft.Json;
using System.Text;
using AjaxControlToolkit.HtmlEditor.ToolbarButtons;
using System.Security.Policy;
public partial class Fundwithdrawal : System.Web.UI.Page
{
    private SqlConnection Conn;
    private SqlCommand Comm;
    private SqlDataAdapter Adp;
    private SqlDataReader Dr;
    private DAL ObjDal = new DAL();
    private string Query;
    private int Todate;
    private int BankID = 0;
    private string BranchName = "";
    private string PayName = "";
    private string IFSCode = "";
    private string Acno = "";
    private string PanNo = "";
    private string MobileNo = "";
    private string ISpan = "";
    private clsGeneral clsgen = new clsGeneral();
    private string scrname = "";
    private string constr1 = ConfigurationManager.ConnectionStrings["constr1"].ConnectionString;
    private string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            BtnSubmit.Attributes.Add("onclick", DisableTheButton(Page, BtnSubmit));
            BtnOtp.Attributes.Add("onclick", DisableTheButton(Page, BtnOtp));
            ResendOtp.Attributes.Add("onclick", DisableTheButton(Page, ResendOtp));

            if (Session["Status"] as string != "OK")
            {
                Response.Redirect("Logout.aspx");
            }
            Fun_Sp_GetCryptoAPIFor_FundWithdraw_Admin();
            GetFundwithdrawalLimit();

            if (!FillDetailUpdate())
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Key", "alert('Please Update Your Wallet Address.');location.replace('Index.aspx');", true);
                return;
            }

            string walletType = ddlWalletType.SelectedValue;

            //if (walletType == "M" || walletType == "T" || walletType == "W")
            //{
            //    if (!GetReqStatus())
            //    {
            //        ScriptManager.RegisterStartupScript(this, this.GetType(), "Key", "alert('You can withdrawal only one time in a day.!');location.replace('Index.aspx');", true);
            //        return;
            //    }
            //}

            //if (walletType == "M")
            //{
            //    if (GetWithdrawlStatus())
            //    {
            //        ScriptManager.RegisterStartupScript(this, this.GetType(), "Key", "alert('You can Not withdrawal 1 and 11 and 21 date on every month.!');location.replace('Index.aspx');", true);
            //        return;
            //    }
            //}

            //if (walletType == "T")
            //{
            //    if (!GetWithdrawlStatus())
            //    {
            //        ScriptManager.RegisterStartupScript(this, this.GetType(), "Key", "alert('You can withdrawal only 1 and 11 and 21 date on every month.!');location.replace('Index.aspx');", true);
            //        return;
            //    }
            //}

            //if (walletType == "W")
            //{
            //    if (!GetWithdrawlmonthStatus())
            //    {
            //        ScriptManager.RegisterStartupScript(this, this.GetType(), "Key", "alert('You can withdrawal only 1 date on every month.!');location.replace('Index.aspx');", true);
            //        return;
            //    }
            //}

            if (!IsPostBack)
            {
                Session["OtpCount"] = 0;
                Session["OtpTime"] = null;
                Session["Retry"] = null;
                Session["OTP_"] = null;
                Fill_WalletType();
                HdnCheckTrnns.Value = GenerateRandomString();

                if (FillDetailUpdate())
                {
                    // Additional logic if needed
                }
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Key", "alert('" + ex.Message + "');", true);
        }
    }
    private void Fun_Sp_GetCryptoAPIFor_FundWithdraw_Admin()
    {
        try
        {
            string sql = "";
            DataTable dt_API_Master = new DataTable();
            sql = " Exec Sp_GetCryptoAPIFor_FundWithdraw_Admin";
            dt_API_Master = SqlHelper.ExecuteDataset(constr1, CommandType.Text, sql).Tables[0];
            Session["SinglePayout"] = dt_API_Master.Rows[0]["APIURL"].ToString();
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
    private bool GetReqStatus()
    {
        bool result = false;
        try
        {
            DataTable dt = new DataTable();
            DataSet ds = new DataSet();
            string strSql = ObjDal.Isostart + " exec SP_GetReqStatusUpdate '" + Session["FormNo"] + "', '" + ddlWalletType.SelectedValue + "' " + ObjDal.IsoEnd;
            ds = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strSql);
            if (ds.Tables.Count > 0)
            {
                dt = ds.Tables[0];
                if (dt.Rows.Count > 0)
                {
                    int count = Convert.ToInt32(dt.Rows[0]["Cnt"]);
                    if (Convert.ToInt32(dt.Rows[0]["Cnt"]) == 0)
                    {
                        result = true;
                    }
                    else
                    {
                        result = false;
                    }
                }
            }
            return result;
        }
        catch (Exception ex)
        {
            return result;
        }
    }
    private void Fill_WalletType()
    {
        try
        {
            DataTable dt = new DataTable();
            string str = ObjDal.Isostart + " exec Sp_GetWallet " + ObjDal.IsoEnd;
            dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, str).Tables[0];

            if (dt.Rows.Count > 0)
            {
                ddlWalletType.DataSource = dt;
                ddlWalletType.DataTextField = "WalletName";
                ddlWalletType.DataValueField = "AcType";
                ddlWalletType.DataBind();
            }
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
    protected void ddlWalletType_SelectedIndexChanged(object sender, EventArgs e)
    {
        TxtReqAmt.Text = "0";
        TxtTds.Text = "0";
        txtwithdrawls.Text = "0";
        TxtFinalSritoken.Text = "0";
        try
        {
            string selectedValue = ddlWalletType.SelectedValue;
            if (!GetReqStatus())
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Key", "alert('You can withdrawal only one time in a day.!');location.replace('Index.aspx');", true);
                return;
            }
            if (selectedValue == "I")
            {

                DataTable dt = new DataTable();
                string strSql = " Exec Sp_GetStackingWithdrawalCondition '" + Session["formno"] + "' ";
                DataSet ds = SqlHelper.ExecuteDataset(constr, CommandType.Text, strSql);
                dt = ds.Tables[0];
                if (dt.Rows.Count > 0)
                {
                    if (Convert.ToInt32(dt.Rows[0]["Income"]) > 0)
                    {
                        LblWithdrawalConditonIncome.Visible = true;
                        TxtReqAmt.Enabled = true;
                        LblWithdrawalConditonIncome.Text = "Your Daily Withdrawal Limit For Stacking Bonus is " + Convert.ToInt32(dt.Rows[0]["PercentageMultiplier"]) + "% of Daily Stacking Bonus Is " + (dt.Rows[0]["DailyStackingBonus"]) + ".";
                    }
                    else
                    {
                        TxtReqAmt.Enabled = false;
                        LblWithdrawalConditonIncome.Visible = true;
                        LblWithdrawalConditonIncome.Text = "Your Daily Withdrawal Limit For Stacking Bonus is " + Convert.ToInt32(dt.Rows[0]["PercentageMultiplier"]) + "% of Daily Stacking Bonus Is " + (dt.Rows[0]["DailyStackingBonus"]) + ".";
                    }
                }
            }
            else
            {
                TxtReqAmt.Enabled = true;
                LblWithdrawalConditonIncome.Visible = false;
            }
            //if (selectedValue == "T")
            //{
            //    if (!GetWithdrawlStatus())
            //    {
            //        ScriptManager.RegisterStartupScript(this, this.GetType(), "Key", "alert('You can withdrawal only 1 and 11 and 21 date on every month.!');location.replace('Index.aspx');", true);
            //        return;
            //    }
            //}

            //if (selectedValue == "W")
            //{
            //    if (!GetWithdrawlmonthStatus())
            //    {
            //        ScriptManager.RegisterStartupScript(this, this.GetType(), "Key", "alert('You can withdrawal only 1 date on every month.!');location.replace('Index.aspx');", true);
            //        return;
            //    }
            //}
            if (!GetAmountStatus())
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Key", "alert('You Are Not Authorised For Withdrawal.Because Of Your Wallet Balance Is Low.!');location.replace('Index.aspx');", true);
                return;
            }

            TxtCredit.Text = Amount().ToString();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", "alert('" + ex.Message + "')", true);
        }
    }
    private string DisableTheButton(Control pge, Control btn)
    {
        try
        {
            var sb = new System.Text.StringBuilder();
            sb.Append("if (typeof(Page_ClientValidate) == 'function') {");
            sb.Append("if (Page_ClientValidate() == false) { return false; }} ");
            sb.Append("if (confirm('Are you sure to proceed?') == false) { return false; } ");
            sb.Append("this.value = 'Please Wait...';");
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
    private bool GetDateFormatCondition()
    {
        try
        {
            bool result = false;
            DataTable dt = new DataTable();
            string strSql = ObjDal.Isostart + " exec Sp_GetDateFormatCondition " + ObjDal.IsoEnd;
            DataSet ds = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strSql);
            dt = ds.Tables[0];
            result = dt.Rows[0]["Status"].ToString() == "0";
            return result;
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
    private bool GetKycPerStatus()
    {
        try
        {
            bool result = false;
            DataTable dt12 = new DataTable();
            string str12 = ObjDal.Isostart + "EXEC sp_CheckKycStatus '" + Convert.ToInt32(Session["Formno"]) + "' " + ObjDal.IsoEnd;
            DataSet ds12 = SqlHelper.ExecuteDataset(constr1, CommandType.Text, str12);
            dt12 = ds12.Tables[0];
            result = dt12.Rows[0]["Status"].ToString().ToUpper() == "TRUE";
            return result;
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
    private void CheckAmount()
    {
        int temp = 0;
        if (Convert.ToDecimal(TxtReqAmt.Text) < Convert.ToDecimal(Session["FMinwithdrawl"]))
        {
            string scrname = "<script language='javascript'>alert('Minimum request amount is " + Session["FMinwithdrawl"] + ".');</script>";
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "Login Error", scrname, false);
            BtnSubmit.Enabled = true;
            TxtTds.Text = "0";
            txtwithdrawls.Text = "0";
            TxtFinalSritoken.Text = "0";
            TxtReqAmt.Text = "0";
            TxtFrxInfra.Text = string.Empty;
        }
        else if (Convert.ToDecimal(TxtReqAmt.Text) > Convert.ToDecimal(Session["MaxWithdrawl"]))
        {
            string scrname = "<script language='javascript'>alert('Maximum request amount is " + Session["MaxWithdrawl"] + "');</script>";
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "Login Error", scrname, false);
            BtnSubmit.Enabled = true;
            TxtTds.Text = "0";
            txtwithdrawls.Text = "0";
            TxtFinalSritoken.Text = "0";
            TxtReqAmt.Text = "0";
            TxtFrxInfra.Text = string.Empty;
            return;
        }
        else if (Convert.ToDecimal(TxtReqAmt.Text) > Amount())
        {
            string scrname = "<script language='javascript'>alert('Insufficient Balance.');</script>";
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "Login Error", scrname, false);
            BtnSubmit.Enabled = true;
            TxtTds.Text = "0";
            txtwithdrawls.Text = "0";
            TxtFinalSritoken.Text = "0";
            TxtReqAmt.Text = "0";
            TxtFrxInfra.Text = string.Empty;
        }
        else if (Convert.ToDecimal(TxtReqAmt.Text) == 0)
        {
            string scrname = "<script language='javascript'>alert('Minimum request amount is " + Session["FMinwithdrawl"] + ".');</script>";
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "Login Error", scrname, false);
            BtnSubmit.Enabled = true;
            TxtTds.Text = "0";
            txtwithdrawls.Text = "0";
            TxtFinalSritoken.Text = "0";
            TxtReqAmt.Text = "0";
            TxtFrxInfra.Text = string.Empty;
        }
        else
        {

            DataTable dt = new DataTable();
            DataSet ds = new DataSet();
            string strSql = ObjDal.Isostart + " Select * from  [dbo].[ufnGetWithdrawalCharge]('" + TxtReqAmt.Text + "','" + Session["formno"] + "','" + ddlWalletType.SelectedValue + "') " + ObjDal.IsoEnd;
            ds = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strSql);
            dt = ds.Tables[0];

            if (dt.Rows.Count > 0)
            {
                //TxtReqAmt.Text = dt.Rows[0]["Amount"].ToString();
                TxtTds.Text = Math.Round(Convert.ToDouble(dt.Rows[0]["AdminChargeAmount"]), 2).ToString();
                txtwithdrawls.Text = Math.Round(Convert.ToDouble(dt.Rows[0]["NetAMount"]), 2).ToString();
                TxtFinalSritoken.Text = Math.Round(Convert.ToDouble(dt.Rows[0]["FinalWithdrawalAmount"]), 2).ToString();
                LblCoinRate.Text = Math.Round(Convert.ToDouble(dt.Rows[0]["RPRate"]), 2).ToString();
            }
            //}
            //else
            //{
            //    DataTable dt = new DataTable();
            //    DataSet ds = new DataSet();
            //    string strSql = ObjDal.Isostart + " Select * from  [dbo].[ufnGetWithdrawalCharge]('" + TxtReqAmt.Text + "','" + Session["formno"] + "','" + ddlWalletType.SelectedValue + "') " + ObjDal.IsoEnd;
            //    ds = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strSql);
            //    dt = ds.Tables[0];

            //    if (dt.Rows.Count > 0)
            //    {
            //        TxtReqAmt.Text = dt.Rows[0]["Amount"].ToString();
            //        TxtTds.Text = "0";
            //        txtwithdrawls.Text = dt.Rows[0]["Amount"].ToString();
            //    }
            //}
        }
    }
    private bool FillBankDetail()
    {
        try
        {
            DataTable tmpTable = new DataTable();
            string qq = " exec sp_GetBankDetail " + Session["FormNo"];
            DataSet ds = SqlHelper.ExecuteDataset(constr1, CommandType.Text, qq);
            tmpTable = ds.Tables[0];
            return true; // Assuming you want to return true if the operation succeeds
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
    private Decimal Amount()
    {
        try
        {
            Decimal RtrVal = 0;
            string Str = ObjDal.Isostart + "Select balance From dbo.ufnGetBalance('" + Session["FormNo"] + "','" + ddlWalletType.SelectedValue + "')" + ObjDal.IsoEnd;
            SqlConnection cnn = new SqlConnection(constr1);
            using (SqlDataReader dr = SqlHelper.ExecuteReader(cnn, CommandType.Text, Str))
            {
                if (dr.Read())
                {
                    RtrVal = Convert.ToDecimal(dr["Balance"]);
                }
            }
            return RtrVal;
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
    private bool GetFundwithdrawalLimit()
    {
        try
        {
            bool result = false;
            DataTable dt = new DataTable();
            string strSql = ObjDal.Isostart + " exec Sp_GetFundlimit " + ObjDal.IsoEnd;
            DataSet ds = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strSql);
            dt = ds.Tables[0];

            if (dt.Rows.Count > 0)
            {
                Session["FMinwithdrawl"] = dt.Rows[0]["MinWithdrawl"];
                Session["MinFWithdraDeduction"] = dt.Rows[0]["WithdrawlDeduction"];
                Session["MaxWithdrawl"] = dt.Rows[0]["MaxWithdrawl"];
                result = true; // Set result to true since data is found
            }
            else
            {
                Session["FMinwithdrawl"] = 0;
                Session["MinFWithdraDeduction"] = 0;
                Session["MaxWithdrawl"] = 0;
            }

            return result;
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
    private bool GetWithdrawlStatus()
    {
        try
        {
            bool result = false;
            DataTable dt = new DataTable();
            string strSql = ObjDal.Isostart + " Exec sp_GetWithdwarlDate " + ObjDal.IsoEnd;
            DataSet ds = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strSql);
            dt = ds.Tables[0];

            if (dt.Rows[0]["da"].ToString().ToUpper() == "Y")
            {
                result = true;
            }
            else
            {
                result = false;
            }

            return result;
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
    private bool GetWithdrawlmonthStatus()
    {
        try
        {
            bool result = false;
            DataTable dt = new DataTable();
            string strSql = ObjDal.Isostart + " Exec sp_GetWithdwarlmonthDate " + ObjDal.IsoEnd;
            DataSet ds = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strSql);
            dt = ds.Tables[0];

            if (dt.Rows[0]["da"].ToString().ToUpper() == "Y")
            {
                result = true;
            }
            else
            {
                result = false;
            }

            return result;
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
    private bool GetAmountStatus()
    {
        try
        {
            bool result = false;
            DataTable dt = new DataTable();
            string strSql = ObjDal.Isostart + "Select balance From dbo.ufnGetBalance('" + Session["FormNo"] + "','" + ddlWalletType.SelectedValue + "')" + ObjDal.IsoEnd;
            DataSet ds = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strSql);
            dt = ds.Tables[0];

            if (Convert.ToDouble(dt.Rows[0]["balance"]) < Convert.ToDouble(Session["FMinwithdrawl"]))
            {
                result = false;
            }
            else
            {
                result = true;
            }

            return result;
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
    protected void BtnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (string.IsNullOrEmpty(TxtWalletAddres.Text))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Key", "alert('Please Enter Wallet Address.!');", true);
                ResetFields();
                return;
            }

            if (Convert.ToDecimal(txtwithdrawls.Text) == 0)
            {
                string scrName = "<script language='javascript'>alert('Minimum request amount is " + Session["FMinwithdrawl"] + ".');</script>";
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Login Error", scrName, false);
                ResetFields();
                return;
            }

            if (ddlWalletType.SelectedValue == "Z")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Key", "alert('Please Select Wallet Type.!');", true);
                return;
            }

            if (!GetAmountStatus())
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Key", "alert('You do not have enough balance for withdrawal.');location.replace('Index.aspx');", true);
                return;
            }

            ObjDal = new DAL();
            DataTable dtCheck = new DataTable();
            string strCheck = ObjDal.Isostart + " exec Sp_GetTimeOfWithdrawal '" + Session["formno"] + "'" + ObjDal.IsoEnd;
            dtCheck = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strCheck).Tables[0];

            if (dtCheck.Rows.Count > 0)
            {
                DateTime minTime = DateTime.Parse(dtCheck.Rows[0]["Min"].ToString());
                DateTime currentTime = DateTime.Parse(dtCheck.Rows[0]["CurrentTime"].ToString());

                if (minTime > currentTime)
                {
                    string scrName = "<SCRIPT language='javascript'>alert('You can withdrawal after 10 Min.');</SCRIPT>";
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Login Error", scrName, false);
                    ResetFields();
                    return;
                }
            }
            //string strSql = ObjDal.Isostart + "EXEC Sp_CheckTransctionPassword " + Session["Formno"] + ",'" + TxtPassword.Text.Trim() + "'" + ObjDal.IsoEnd;
            //DataTable dtPassword = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strSql).Tables[0];

            //if (dtPassword.Rows.Count > 0)
            //{
            //otp_save_function();
            //}
            //else
            //{
            //    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "Upgraded", "<SCRIPT language='javascript'>alert('Please Enter Valid Transaction Password.!');</SCRIPT>", false);
            //}
            int OTP_ = 0;
            Random rs = new Random();
            OTP_ = rs.Next(100001, 999999);

            if (Session["OTP_"] == null)
            {
                if (SendMail(OTP_.ToString()))
                {
                    Session["OtpTime"] = DateTime.Now.AddMinutes(5);
                    Session["Retry"] = "1";
                    Session["OTP_"] = OTP_;
                    int i = 0;
                    string query = "";
                    query = "INSERT INTO AdminLogin (UserID, Username, Passw, MobileNo, OTP, LoginTime, emailotp, EmailID, ForType) ";
                    query += "VALUES ('" + Session["formno"] + "', '" + Session["MemName"] + "', '" + TxtOtp.Text + "', '0', '" + OTP_ + "', GETDATE(), '" + OTP_ + "', ";
                    query += "'" + Session["EMail"].ToString().Trim() + "', 'Withdrawal')";
                    i = Convert.ToInt32(SqlHelper.ExecuteNonQuery(constr, CommandType.Text, query));
                    if (i > 0)
                    {
                        divotp.Visible = true;
                        BtnSubmit.Visible = false;
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
            else
            {
                TxtReqAmt.Enabled = false;
                ddlWalletType.Enabled = false;
                divotp.Visible = true;
                BtnSubmit.Visible = false;
                BtnOtp.Visible = true;
                ResendOtp.Visible = false;
            }
        }
        catch (Exception ex)
        {
            string scrName = "<SCRIPT language='javascript'>alert('Email Try Later');</SCRIPT>";
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Error", scrName, false);
        }
    }
    private void ResetFields()
    {
        TxtReqAmt.Text = "0";
        TxtTds.Text = "0";
        txtwithdrawls.Text = "0";
        TxtFinalSritoken.Text = "0";
        TxtFrxInfra.Text = "";
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
                     "Your OTP for Withdrawal is <span style=\"font-weight: bold;\">" + otp + "</span> (valid for 5 minutes)." +
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
            TxtReqAmt.Enabled = false;
            ddlWalletType.Enabled = false;
            return true;
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
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
                string query = "SELECT TOP 1 * FROM " + ObjDal.dBName + "..AdminLogin AS a WHERE EmailID = '" + Session["EMail"].ToString().Trim() + "' AND emailotp = '" + transPassw + "' AND ForType = 'Withdrawal' ORDER BY AID DESC";
                dt1 = SqlHelper.ExecuteDataset(constr1, CommandType.Text, query).Tables[0];

                if (dt1.Rows.Count > 0)
                {
                    otp_save_function();
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
                        "'" + Session["EMail"].ToString().Trim() + "', 'Withdrawal')";

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
    protected void otp_save_function()
    {
        try
        {
            string strSql = "Insert into TrnFundUniqe (Transid, Rectimestamp) values (" + HdnCheckTrnns.Value + ", GETDATE())";
            int updateEffect = ObjDal.SaveData(strSql);

            if (updateEffect > 0)
            {
                string responseData = string.Empty;
                try
                {
                    string scrname = string.Empty;
                    Label1.Text = string.Empty;

                    if (decimal.Parse(TxtReqAmt.Text) < decimal.Parse(Session["FMinwithdrawl"].ToString()))
                    {
                        scrname = "<SCRIPT language='javascript'>alert('Minimum Request Amount is " + Session["FMinwithdrawl"].ToString() + ".');</SCRIPT>";
                        ScriptManager.RegisterClientScriptBlock(Page, GetType(), "Login Error", scrname, false);
                        return;
                    }

                    decimal result = 0;
                    if (Convert.ToDecimal(TxtReqAmt.Text) > Amount())
                    {
                        scrname = "<SCRIPT language='javascript'>alert('Insufficient Balance.');</SCRIPT>";
                        ScriptManager.RegisterClientScriptBlock(Page, GetType(), "Login Error", scrname, false);
                        return;
                    }

                    if (FillDetailUpdate())
                    {
                        ObjDal = new DAL();
                        DataTable dt = new DataTable();
                        DataSet ds = new DataSet();
                        string strCheck = ObjDal.Isostart + " exec Sp_GetTimeOfWithdrawal '" + Session["formno"].ToString() + "'" + ObjDal.IsoEnd;
                        dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strCheck).Tables[0];

                        if (dt.Rows.Count > 0)
                        {
                            DateTime minTime = DateTime.Parse(dt.Rows[0]["Min"].ToString());
                            DateTime currentTime = DateTime.Parse(dt.Rows[0]["CurrentTime"].ToString());

                            if (minTime > currentTime)
                            {
                                ScriptManager.RegisterStartupScript(Page, GetType(), "Key", "alert('You can withdrawal after 10 Min.!');location.replace('FundWithdrawal.aspx');", true);
                                ResetFields();
                                return;
                            }
                        }

                        string reqNo = string.Empty;
                        string MaxVoucherNo_ = "2" + DateTime.Now.ToString("ddMMyyyyHHmmssfff");
                        long maxVno_ = Convert.ToInt64(MaxVoucherNo_) + Convert.ToInt64(Session["Formno"].ToString());
                        reqNo = maxVno_.ToString();

                        string strCheckReq = "select count(*) as Cnt from TrnFundWithDrawal where formno='" + Session["formno"].ToString() + "' AND reqno = '" + reqNo + "'";
                        DataTable dtCheck_D = SqlHelper.ExecuteDataset(constr, CommandType.Text, strCheckReq).Tables[0];

                        if (Convert.ToInt32(dtCheck_D.Rows[0]["Cnt"]) == 0)
                        {
                            string Str_TrnFun = "";
                            string Str_TrnFun_Query = "";
                            Str_TrnFun += "INSERT INTO TrnFundWithDrawal (ReqNo, Formno, ReqAmount, AdminCharge, TDSCharge, NetAmount, DeductForProductWallet, WithdrawToken, ";
                            Str_TrnFun += "TokenRate, AdminCredit, PanNo, Wsessid, PayeeName, RectimeStamp, IpAdrs, OtherId, WalletType) ";
                            Str_TrnFun += "VALUES ('" + reqNo + "', '" + Convert.ToDecimal(Session["Formno"]) + "', '" + Convert.ToDecimal(TxtReqAmt.Text) + "', '" + Convert.ToDecimal(TxtTds.Text) + "', ";
                            Str_TrnFun += "'0', '" + Convert.ToDecimal(txtwithdrawls.Text) + "', '" + Convert.ToDecimal(TxtFinalSritoken.Text) + "', '" + Convert.ToDecimal(txtwithdrawls.Text) + "', ";
                            Str_TrnFun += "'" + Convert.ToDecimal(LblCoinRate.Text) + "', 0, '" + TxtWalletAddres.Text + "', 1, '" + Session["MemName"] + "', GETDATE(), '', ";
                            Str_TrnFun += "'" + TxtFrxInfra.Text.Trim() + "', '" + ddlWalletType.SelectedValue + "');";
                            Str_TrnFun += "UPDATE TrnFundUniqe SET ReqID='" + reqNo + "' WHERE Transid='" + HdnCheckTrnns.Value + "'";
                            Str_TrnFun_Query = "BEGIN TRY BEGIN TRANSACTION " + Str_TrnFun + " COMMIT TRANSACTION END TRY BEGIN CATCH ROLLBACK TRANSACTION END CATCH";
                            int i = SqlHelper.ExecuteNonQuery(constr, CommandType.Text, Str_TrnFun_Query);

                            if (i > 0)
                            {
                                string responseResult = "";
                                string responseResultSTDS = "";
                                responseResult = DeductWalletApi(Session["Formno"].ToString(), ddlWalletType.SelectedValue, TxtFinalSritoken.Text, reqNo, TxtWalletAddres.Text);
                                if (responseResult.ToUpper() == "SUCCESS")
                                {
                                    responseResultSTDS = DeductWalletTDS(Session["Formno"].ToString(), ddlWalletType.SelectedValue, TxtTds.Text, "0xe1d85E5D39E1909c7be6FDa8a9eCE329Db03AD77", reqNo);
                                    if (responseResultSTDS.ToUpper() == "SUCCESS")
                                    {
                                        TxtCredit.Text = Amount().ToString();
                                        TxtReqAmt.Text = "0";
                                        TxtTds.Text = "0";
                                        txtwithdrawls.Text = "0";
                                        TxtFinalSritoken.Text = "0";
                                        TxtFrxInfra.Text = string.Empty;
                                        ScriptManager.RegisterStartupScript(Page, GetType(), "Key", "alert('Withdrawal Successfully.!');location.replace('FundWithdrawal.aspx');", true);
                                        return;
                                    }
                                    else
                                    {
                                        TxtReqAmt.Text = "0";
                                        TxtTds.Text = "0";
                                        txtwithdrawls.Text = "0";
                                        TxtFinalSritoken.Text = "0";
                                        TxtCredit.Text = Amount().ToString();
                                        TxtFrxInfra.Text = string.Empty;
                                        ScriptManager.RegisterStartupScript(Page, GetType(), "Key", "alert('Your Request Is Rejected. Please Contact Admin.!');location.replace('FundWithdrawal.aspx');", true);
                                        return;
                                    }
                                }
                                else
                                {
                                    TxtReqAmt.Text = "0";
                                    TxtTds.Text = "0";
                                    txtwithdrawls.Text = "0";
                                    TxtFinalSritoken.Text = "0";
                                    TxtCredit.Text = Amount().ToString();
                                    TxtFrxInfra.Text = string.Empty;
                                    ScriptManager.RegisterStartupScript(Page, GetType(), "Key", "alert('Your Request Is Rejected. Please Contact Admin.!');location.replace('FundWithdrawal.aspx');", true);
                                    return;
                                }
                            }
                            else
                            {
                                TxtReqAmt.Text = "0";
                                TxtTds.Text = "0";
                                txtwithdrawls.Text = "0";
                                TxtFinalSritoken.Text = "0";
                                TxtCredit.Text = Amount().ToString();
                                TxtFrxInfra.Text = string.Empty;
                                scrname = "<SCRIPT language='javascript'>alert('Try again later.');</SCRIPT>";
                                ScriptManager.RegisterStartupScript(Page, GetType(), "Login Error", scrname, false);
                                return;
                            }
                        }
                        else
                        {
                            scrname = "<SCRIPT language='javascript'>alert('Something Went Wrong.');</SCRIPT>";
                            ScriptManager.RegisterStartupScript(Page, GetType(), "Upgraded", scrname, false);
                            TxtReqAmt.Text = "0";
                            TxtTds.Text = "0";
                            txtwithdrawls.Text = "0";
                            TxtFinalSritoken.Text = "0";
                            return;
                        }
                    }
                }
                catch (Exception ex)
                {
                    string scrname = "<SCRIPT language='javascript'>alert('" + ex.Message + "');</SCRIPT>";
                    ScriptManager.RegisterStartupScript(Page, GetType(), "Login Error", scrname, false);
                    return;
                }
            }
            else
            {
                string scrname = "<SCRIPT language='javascript'>alert('Something Went Wrong.');</SCRIPT>";
                ScriptManager.RegisterStartupScript(Page, GetType(), "Upgraded", scrname, false);
                return;
            }
        }
        catch (Exception ex)
        {
            // Handle any exceptions that might be thrown
            // Log or process the exception as needed
            Console.WriteLine("Error in otp_save_function: " + ex.Message);
        }
    }
    public string DeductWalletApi(string formNo, string ddlWalletType, string withdrawAmount, string reqNo, string walletAddress)
    {
        string sResult = string.Empty;
        string current_datetime = DateTime.Now.ToString("yyyyMMddHHmmssfff");
        int random_number = new Random().Next(0, 999);
        string formatted_datetime = current_datetime + random_number.ToString().PadLeft(3, '0');
        sResult = formatted_datetime;
        DataTable dtQuery = new DataTable();
        string responseFromServer = string.Empty;
        string statusApi = "";
        int i = 0;
        string hash_ = "";
        DataSet dsLogin = new DataSet();
        string str = string.Empty;
        DataSet ds = new DataSet();
        DataSet data = new DataSet();
        string url = "";
        try
        {


            try
            {
                ServicePointManager.Expect100Continue = true;
                ServicePointManager.SecurityProtocol = (SecurityProtocolType)3072; // TLS 1.2
                url = Session["SinglePayout"].ToString();
                WebRequest tRequest = WebRequest.Create(url);
                tRequest.Method = "POST";
                tRequest.ContentType = "application/json";
                tRequest.ContentLength = 0;

                string postData = "{\"to\":\"" + walletAddress.Trim() + "\",\"amount\":\"" + Convert.ToDecimal(withdrawAmount) + "\",\"txId\":\"" + reqNo + "\"}";
                byte[] byteArray = Encoding.UTF8.GetBytes(postData);


                int xReq = 0;
                try
                {
                    string sqlReq = "INSERT INTO Tbl_ApiRequest_Response (ReqID, Formno, Request, PostData, ForType,FundReqNo) " +
                  "VALUES ('" + reqNo.Trim() + "','" + formNo + "','" + url.Trim() + "','" + postData.Trim() + "','SINGLEPAYOUT','" + sResult + "')";
                    xReq = Convert.ToInt32(SqlHelper.ExecuteNonQuery(constr, CommandType.Text, sqlReq));
                }
                catch (SqlException ex)
                {
                    if (ex.Number == 2627) // SQL error code for primary key violation
                    {
                        xReq = 0;
                    }
                }
                tRequest.ContentLength = byteArray.Length;
                Stream dataStream = tRequest.GetRequestStream();
                dataStream.Write(byteArray, 0, byteArray.Length);
                dataStream.Close();

                WebResponse tResponse = tRequest.GetResponse();
                dataStream = tResponse.GetResponseStream();
                StreamReader tReader = new StreamReader(dataStream);
                str = tReader.ReadToEnd();
                string sqlRes = "UPDATE Tbl_ApiRequest_Response SET Response = '" + str.Trim() + "',DateUpdate = getdate() WHERE ReqID = '" + reqNo.Trim() + "'";
                int xRes = Convert.ToInt32(SqlHelper.ExecuteNonQuery(constr, CommandType.Text, sqlRes));
                dsLogin = convertJsonStringToDataSet(str.ToString());

                string resultStatus = string.IsNullOrEmpty(str) ? "failed" : dsLogin.Tables[0].Rows[0]["Status"].ToString();

                if (resultStatus.ToUpper() == "FAILED")
                {
                    hash_ = dsLogin.Tables[0].Rows[0]["txhash"].ToString();
                }
                else if (resultStatus.ToUpper() == "SUCCESS")
                {
                    hash_ = dsLogin.Tables[0].Rows[0]["txhash"].ToString();
                }

                if (resultStatus.ToUpper() == "SUCCESS")
                {
                    string query = "EXEC Sp_TrnIncomeCapitalWithDraw '" + reqNo.Trim() + "','" + formNo + "','" + Convert.ToDecimal(withdrawAmount) + "','" + hash_.Trim() + "';";
                    query += "INSERT INTO ApiReqResponse(Formno, Orderid, WalletAddress, PrivateKey, Request, Response, ApiStatus, RectimeStamp, ApiType, TxnHash, Amount, PostData) ";
                    query += "VALUES ('" + formNo.ToString() + "','" + reqNo + "','" + walletAddress + "','','" + url + "','" + str + "','" + hash_ + "',GETDATE(),'singlePayout','" + hash_ + "','" + Convert.ToDecimal(withdrawAmount) + "','')";

                    i = Convert.ToInt32(SqlHelper.ExecuteNonQuery(constr, CommandType.Text, query));

                    if (i > 0 && resultStatus.ToUpper() == "SUCCESS")
                    {
                        statusApi = resultStatus;
                    }
                }
                else
                {
                    string MaxVoucherNo_ = "3" + DateTime.Now.ToString("ddMMyyyyHHmmssfff");
                    long maxVno_ = Convert.ToInt64(MaxVoucherNo_) + Convert.ToInt64(formNo);
                    MaxVoucherNo_ = maxVno_.ToString();

                    string MaxVoucherNo1_ = "4" + DateTime.Now.ToString("ddMMyyyyHHmmssfff");
                    long maxVno1_ = Convert.ToInt64(MaxVoucherNo1_) + Convert.ToInt64(formNo);
                    MaxVoucherNo1_ = maxVno1_.ToString();

                    string MaxVoucherNo2_ = "5" + DateTime.Now.ToString("ddMMyyyyHHmmssfff");
                    long maxVno2_ = Convert.ToInt64(MaxVoucherNo2_) + Convert.ToInt64(formNo);
                    MaxVoucherNo2_ = maxVno2_.ToString();

                    string StrQuery = " exec Sp_FundWithdrawalRejected '" + Convert.ToInt64(formNo) + "','" + reqNo.Trim() + "','" + hash_.Trim() + "',";
                    StrQuery += "'" + MaxVoucherNo_ + "','" + MaxVoucherNo1_ + "','" + MaxVoucherNo2_ + "','" + ddlWalletType + "';";
                    StrQuery += "insert into ApiReqResponse(Formno, Orderid, WalletAddress, PrivateKey, Request, Response, ApiStatus, RectimeStamp, ";
                    StrQuery += "ApiType, TxnHash, AMount, PostData) ";
                    StrQuery += "Values('" + formNo + "','" + reqNo + "','" + walletAddress.Trim() + "','',";
                    StrQuery += "'" + Session["SinglePayout"].ToString() + "','','" + hash_ + "',getdate(),'singlePayout',";
                    StrQuery += "'" + hash_ + "','" + Convert.ToDecimal(withdrawAmount) + "','Failed Case');";

                    int updateeffect = Convert.ToInt32(SqlHelper.ExecuteNonQuery(constr, CommandType.Text, StrQuery));

                    string strSuccess = "INSERT INTO ApiReqResponse(Formno, Orderid, WalletAddress, PrivateKey, Request, Response, ApiStatus, RectimeStamp, ApiType, TxnHash, Amount, PostData) ";
                    strSuccess += "VALUES ('" + formNo.ToString() + "','" + reqNo + "','" + walletAddress.Trim() + "','','" + url + "','" + str + "',";
                    strSuccess += "'" + hash_ + "',GETDATE(),'singlePayout','" + hash_ + "','" + Convert.ToDecimal(withdrawAmount) + "','Failed Case');";

                    int x = Convert.ToInt32(SqlHelper.ExecuteNonQuery(constr, CommandType.Text, strSuccess));

                    string sqlRes1 = "UPDATE Tbl_ApiRequest_Response SET Response = '" + str.Trim() + "',DateUpdate = getdate() WHERE ReqID = '" + reqNo.Trim() + "'";
                    int xRes1 = Convert.ToInt32(SqlHelper.ExecuteNonQuery(constr, CommandType.Text, sqlRes1));

                    if (x > 0)
                    {
                        statusApi = resultStatus;
                    }

                }
            }
            catch (Exception ex)
            {
                string MaxVoucherNo_ = "3" + DateTime.Now.ToString("ddMMyyyyHHmmssfff");
                long maxVno_ = Convert.ToInt64(MaxVoucherNo_) + Convert.ToInt64(formNo);
                MaxVoucherNo_ = maxVno_.ToString();

                string MaxVoucherNo1_ = "4" + DateTime.Now.ToString("ddMMyyyyHHmmssfff");
                long maxVno1_ = Convert.ToInt64(MaxVoucherNo1_) + Convert.ToInt64(formNo);
                MaxVoucherNo1_ = maxVno1_.ToString();

                string MaxVoucherNo2_ = "5" + DateTime.Now.ToString("ddMMyyyyHHmmssfff");
                long maxVno2_ = Convert.ToInt64(MaxVoucherNo2_) + Convert.ToInt64(formNo);
                MaxVoucherNo2_ = maxVno2_.ToString();

                string StrQuery = " exec Sp_FundWithdrawalRejected '" + Convert.ToInt64(formNo) + "','" + reqNo.Trim() + "','" + hash_.Trim() + "',";
                StrQuery += "'" + MaxVoucherNo_ + "','" + MaxVoucherNo1_ + "','" + MaxVoucherNo2_ + "','" + ddlWalletType + "';";
                StrQuery += "insert into ApiReqResponse(Formno, Orderid, WalletAddress, PrivateKey, Request, Response, ApiStatus, RectimeStamp, ";
                StrQuery += "ApiType, TxnHash, AMount, PostData) ";
                StrQuery += "Values('" + formNo + "','" + reqNo + "','" + walletAddress.Trim() + "','',";
                StrQuery += "'" + Session["SinglePayout"].ToString() + "','','" + hash_ + "',getdate(),'singlePayout',";
                StrQuery += "'" + hash_ + "','" + Convert.ToDecimal(withdrawAmount) + "','Exception Case');";

                int updateeffect = Convert.ToInt32(SqlHelper.ExecuteNonQuery(constr, CommandType.Text, StrQuery));

                string strSuccess = "INSERT INTO ApiReqResponse(Formno, Orderid, WalletAddress, PrivateKey, Request, Response, ApiStatus, RectimeStamp, ApiType, TxnHash, Amount, PostData) ";
                strSuccess += "VALUES ('" + formNo.ToString() + "','" + reqNo + "','" + walletAddress.Trim() + "','','" + url + "','" + str + "',";
                strSuccess += "'" + hash_ + "',GETDATE(),'singlePayout','" + hash_ + "','" + Convert.ToDecimal(withdrawAmount) + "','Exception Case');";

                int x = Convert.ToInt32(SqlHelper.ExecuteNonQuery(constr, CommandType.Text, strSuccess));

                string sqlRes1 = "UPDATE Tbl_ApiRequest_Response SET Response = '" + ex.Message.Trim() + "',DateUpdate = getdate() WHERE ReqID = '" + reqNo.Trim() + "'";
                int xRes1 = Convert.ToInt32(SqlHelper.ExecuteNonQuery(constr, CommandType.Text, sqlRes1));

                statusApi = "failed";
            }
        }
        catch (Exception ex)
        {

            throw new Exception(ex.Message);
        }

        return statusApi;
    }
    public string DeductWalletTDS(string formNo, string ddlWalletType, string withdrawAmount, string walletAddress, string reqNo)
    {
        string sResult = string.Empty;
        string current_datetime = DateTime.Now.ToString("yyyyMMddHHmmssfff");
        int random_number = new Random().Next(0, 999);
        string formatted_datetime = current_datetime + random_number.ToString().PadLeft(3, '0');
        sResult = formatted_datetime;
        DataTable dtQuery = new DataTable();
        string responseFromServer = string.Empty;
        string statusApi = "";
        int i = 0;
        string hash_ = "";

        try
        {
            DataSet dsLogin = new DataSet();
            string str = string.Empty;
            DataSet ds = new DataSet();
            DataSet data = new DataSet();
            string url = "";

            try
            {
                ServicePointManager.Expect100Continue = true;
                ServicePointManager.SecurityProtocol = (SecurityProtocolType)3072; // TLS 1.2
                url = Session["SinglePayout"].ToString();
                WebRequest tRequest = WebRequest.Create(url);
                tRequest.Method = "POST";
                tRequest.ContentType = "application/json";
                tRequest.ContentLength = 0;

                string postData = "{\"to\":\"" + walletAddress.Trim() + "\",\"amount\":\"" + Convert.ToDecimal(withdrawAmount) + "\",\"txId\":\"" + sResult + "\"}";
                byte[] byteArray = Encoding.UTF8.GetBytes(postData);


                int xReq = 0;
                try
                {
                    string sqlReq = "INSERT INTO Tbl_ApiRequest_Response (ReqID, Formno, Request, PostData, ForType,FundReqNo) " +
                  "VALUES ('" + sResult.Trim() + "','" + formNo + "','" + url.Trim() + "','" + postData.Trim() + "','SINGLEPAYOUTTDS','" + reqNo + "')";
                    xReq = Convert.ToInt32(SqlHelper.ExecuteNonQuery(constr, CommandType.Text, sqlReq));
                }
                catch (SqlException ex)
                {
                    if (ex.Number == 2627) // SQL error code for primary key violation
                    {
                        xReq = 0;
                    }
                }
                tRequest.ContentLength = byteArray.Length;
                Stream dataStream = tRequest.GetRequestStream();
                dataStream.Write(byteArray, 0, byteArray.Length);
                dataStream.Close();

                WebResponse tResponse = tRequest.GetResponse();
                dataStream = tResponse.GetResponseStream();
                StreamReader tReader = new StreamReader(dataStream);
                str = tReader.ReadToEnd();
                string sqlRes = "UPDATE Tbl_ApiRequest_Response SET Response = '" + str.Trim() + "',DateUpdate = getdate() WHERE ReqID = '" + sResult.Trim() + "'";
                int xRes = Convert.ToInt32(SqlHelper.ExecuteNonQuery(constr, CommandType.Text, sqlRes));
                dsLogin = convertJsonStringToDataSet(str.ToString());

                string resultStatus = string.IsNullOrEmpty(str) ? "failed" : dsLogin.Tables[0].Rows[0]["Status"].ToString();

                if (resultStatus.ToUpper() == "FAILED")
                {
                    hash_ = dsLogin.Tables[0].Rows[0]["txhash"].ToString();
                }
                else if (resultStatus.ToUpper() == "SUCCESS")
                {
                    hash_ = dsLogin.Tables[0].Rows[0]["txhash"].ToString();
                }

                if (resultStatus.ToUpper() == "SUCCESS")
                {
                    string query = "";
                    query += "INSERT INTO ApiReqResponse(Formno, Orderid, WalletAddress, PrivateKey, Request, Response, ApiStatus, RectimeStamp, ApiType, TxnHash, Amount, PostData) ";
                    query += "VALUES ('" + formNo.ToString() + "','" + reqNo + "','" + walletAddress + "','','" + url + "','" + str + "','" + hash_ + "',GETDATE(),'SINGLEPAYOUTTDS','" + hash_ + "','" + Convert.ToDecimal(withdrawAmount) + "','')";
                    i = Convert.ToInt32(SqlHelper.ExecuteNonQuery(constr, CommandType.Text, query));

                    if (i > 0 && resultStatus.ToUpper() == "SUCCESS")
                    {
                        statusApi = resultStatus;
                    }
                }
                else
                {

                    string strSuccess = "INSERT INTO ApiReqResponse(Formno, Orderid, WalletAddress, PrivateKey, Request, Response, ApiStatus, RectimeStamp, ApiType, TxnHash, Amount, PostData) ";
                    strSuccess += "VALUES ('" + formNo.ToString() + "','" + reqNo + "','" + walletAddress.Trim() + "','','" + url + "','" + str + "',";
                    strSuccess += "'" + hash_ + "',GETDATE(),'SINGLEPAYOUTTDS','" + hash_ + "','" + Convert.ToDecimal(withdrawAmount) + "','Failed Case');";

                    int x = Convert.ToInt32(SqlHelper.ExecuteNonQuery(constr, CommandType.Text, strSuccess));

                    if (x > 0)
                    {
                        statusApi = resultStatus;
                    }

                }
            }
            catch (Exception ex)
            {

                statusApi = "failed";
            }
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }

        return statusApi;
    }
    public DataSet convertJsonStringToDataSet(string jsonString)
    {
        try
        {
            XmlDocument xd = new XmlDocument();
            jsonString = "{ \"rootNode\": {" + jsonString.Trim().TrimStart('{').TrimEnd('}') + "} }";
            xd = (XmlDocument)JsonConvert.DeserializeXmlNode(jsonString);
            DataSet ds = new DataSet();
            ds.ReadXml(new XmlNodeReader(xd));
            return ds;
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
    public string GenerateRandomString()
    {
        string result = "";
        string currentDateTime = DateTime.Now.ToString("yyyyMMddHHmmssfff");
        Random random = new Random();
        int randomNumber = random.Next(0, 999);
        string formattedDateTime = currentDateTime + randomNumber.ToString("D3");
        result = formattedDateTime;
        return result;
    }
    public static string Base64Encode(string plainText)
    {
        try
        {
            byte[] plainTextBytes = System.Text.Encoding.UTF8.GetBytes(plainText);
            return Convert.ToBase64String(plainTextBytes);
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
    protected void TxtReqAmt_TextChanged(object sender, EventArgs e)
    {
        try
        {
            if (ddlWalletType.SelectedValue == "I")
            {

                DataTable dt = new DataTable();
                string strSql = "Exec Sp_GetStackingWithdrawalCondition '" + Session["formno"] + "'";
                DataSet ds = SqlHelper.ExecuteDataset(constr, CommandType.Text, strSql);
                dt = ds.Tables[0];
                if (dt.Rows.Count > 0)
                {
                    decimal requestedAmount = Convert.ToDecimal(TxtReqAmt.Text);
                    decimal income = Convert.ToDecimal(dt.Rows[0]["Income"]);
                    if (income >= requestedAmount)
                    {
                        // BtnSubmit.Enabled = false;
                        CheckAmount();
                    }
                    else
                    {
                        string scrname = "<script language='javascript'>alert('Your Daily Withdrawal Limit For Stacking Bonus is " + income + ".');</script>";
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "Login Error", scrname, false);
                        BtnSubmit.Enabled = true;
                        TxtTds.Text = "0";
                        txtwithdrawls.Text = "0";
                        TxtFinalSritoken.Text = "0";
                        TxtReqAmt.Text = "0";
                        //  throw new InvalidOperationException("Income exceeds the requested amount.");
                    }
                }
            }
            else
            {
                CheckAmount();
            }
        }
        catch (Exception ex)
        {
            string scrname = "<script language='javascript'>alert('Minimum request amount is " + Session["FMinwithdrawl"] + "');</script>";
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "Login Error", scrname, false);
            BtnSubmit.Enabled = true;
            TxtTds.Text = "0";
            txtwithdrawls.Text = "0";
            TxtFinalSritoken.Text = "0";
            TxtReqAmt.Text = "0";
        }
    }
    private bool FillDetailUpdate()
    {
        bool result = false;
        try
        {
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            DataTable tmpTable = new DataTable();
            string qq = "exec Sp_GetBankWallet " + Session["FormNo"].ToString();
            ds = SqlHelper.ExecuteDataset(constr1, CommandType.Text, qq);
            tmpTable = ds.Tables[0];
            dt = ds.Tables[0];
            if (tmpTable.Rows.Count > 0)
            {
                TxtWalletAddres.Text = tmpTable.Rows[0]["WalletAddress"].ToString();
                Session["transpassw"] = tmpTable.Rows[0]["EPassw"].ToString();
                Session["MemberKitId"] = tmpTable.Rows[0]["KitId"].ToString();
            }
            else
            {
                TxtWalletAddres.Text = "";
                Session["MemberKitId"] = "0";
            }
            result = !string.IsNullOrEmpty(TxtWalletAddres.Text);
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
        return result;
    }
}
