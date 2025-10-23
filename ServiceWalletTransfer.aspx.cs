using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Net.Mail;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Text;
using AjaxControlToolkit.HtmlEditor.ToolbarButtons;
//using DocumentFormat.OpenXml.Wordprocessing;
public partial class ServiceWalletTransfer : System.Web.UI.Page
{
    string scrName;
    DAL objDal = new DAL();
    DataTable Dt = new DataTable();
    string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
    string constr1 = ConfigurationManager.ConnectionStrings["constr1"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["Status"] != null && Session["Status"].ToString() == "OK")
            {
                cmdSave1.Attributes.Add("onclick", DisableTheButton(this.Page, this.cmdSave1));
                if (!Page.IsPostBack)
                {
                    HdnCheckTrnns.Value = GenerateRandomStringActive(6);
                    FundWalletGetBalance();
                }
            }
            else
            {
                Response.Redirect("logout.aspx");
            }
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff ") + Environment.NewLine;
            objDal.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }
    }
    public string GenerateRandomStringActive(int iLength)
    {
        try
        {
            Random rdm = new Random();
            char[] allowChrs = "123456789".ToCharArray();
            string sResult = "";

            for (int i = 0; i < iLength; i++)
            {
                sResult += allowChrs[rdm.Next(0, allowChrs.Length)];
            }
            return sResult;
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
    private string GetName()
    {
        // Label3.Text = "";

        SqlCommand Comm = new SqlCommand();
        SqlDataReader ds;
        SqlConnection conn = new SqlConnection(constr1);
        conn.Open();
        if (TxtMemId.Text.Trim().ToLower() == Session["IdNo"].ToString().ToLower())
        {
            scrName = "<SCRIPT language='javascript'>alert('Cannot transfer Main Wallet Amount to your own ID');</SCRIPT>";
            this.RegisterStartupScript("MyAlert", scrName);
            TxtMemName.Text = "";
            TxtMemId.Text = "";
            cmdSave1.Enabled = false;

            return "";
        }
        else
        {
            Comm = new SqlCommand(
               objDal.Isostart + "Select a.Formno, MemFirstName + MemLastName as MemName, a.mobl from " + objDal.dBName + "..M_Membermaster as a " +
                "where a.IsBlock='N' and IdNo='" + TxtMemId.Text + "'" + objDal.IsoEnd, conn);

            ds = Comm.ExecuteReader();

            if (!ds.Read())
            {
                scrName = "<SCRIPT language='javascript'>alert('Invalid Member ID!');</SCRIPT>";
                this.RegisterStartupScript("MyAlert", scrName);
                TxtMemId.Text = "";
                TxtMemName.Text = "";
                cmdSave1.Enabled = false;

                return "";
            }
        }

        LblFormno.Text = ds["Formno"].ToString();
        TxtMemName.Text = ds["MemName"].ToString();
        // txtmobl.Text = ds["mobl"].ToString();
        cmdSave1.Enabled = true;

        ds.Close();
        Comm.Cancel();
        return "OK";
    }
    private string DisableTheButton(Control pge, Control btn)
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
    public string GenerateRandomStringactive(int length)
    {
        Random rdm = new Random();
        char[] allowChrs = "123456789".ToCharArray();
        StringBuilder sResult = new StringBuilder();

        for (int i = 0; i < length; i++)
        {
            sResult.Append(allowChrs[rdm.Next(0, allowChrs.Length)]);
        }

        return sResult.ToString();
    }
    protected void FundWalletGetBalance()
    {
        try
        {
            DataTable dt = new DataTable();
            string str = objDal.Isostart + " Select * From dbo.ufnGetBalance('" + Convert.ToInt32(Session["Formno"]) + "','M')" + objDal.IsoEnd;
            dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, str).Tables[0];
            if (dt.Rows.Count > 0)
            {
                AvailableBal.InnerText = Convert.ToString(dt.Rows[0]["Balance"]);
            }
            else
            {
                AvailableBal.InnerText = "0";
            }
            Session["ServiceWallet"] = AvailableBal.InnerText;
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
    protected void CheckAmount()
    {
        if (Convert.ToDouble(txtAmount.Text) < 0)
        {
            cmdSave1.Enabled = true;
            LblAmount.Visible = false;
            scrName = "<SCRIPT language='javascript'>alert('Amount cannot be negative');</SCRIPT>";
            this.RegisterStartupScript("MyAlert", scrName);
        }
        else if (Convert.ToDouble(txtAmount.Text) < 100)
        {
            cmdSave1.Enabled = true;
            LblAmount.Visible = false;
            scrName = "<SCRIPT language='javascript'>alert('Minimum amount should be 100');</SCRIPT>";
            this.RegisterStartupScript("MyAlert", scrName);
        }
        else
        {
            DataTable Dt;
            string str = objDal.Isostart + "Select * From dbo.ufnGetBalance('" + Convert.ToDouble(Session["Formno"]) + "','M')" + objDal.IsoEnd;
            Dt = new DataTable();
            Dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, str).Tables[0];

            if (Dt.Rows.Count > 0)
            {
                Session["ServiceWallet"] = Convert.ToDouble(Dt.Rows[0]["Balance"]);
                LblAmount.Text = Convert.ToDouble(Dt.Rows[0]["Balance"]).ToString();

                if (Convert.ToDouble(Session["ServiceWallet"]) < Convert.ToDouble(txtAmount.Text))
                {
                    LblAmount.Text = "Insufficient Balance";
                    LblAmount.ForeColor = System.Drawing.Color.Red;
                    LblAmount.Visible = true;
                    cmdSave1.Enabled = false;
                }
                else
                {
                    cmdSave1.Enabled = true;
                    LblAmount.Visible = false;
                }
            }
        }
    }
    protected void txtAmount_TextChanged(object sender, EventArgs e)
    {
        try
        {
            CheckAmount();
        }
        catch (Exception ex)
        {
        }

    }
    protected void txtMemberId_TextChanged(object sender, EventArgs e)
    {
        GetName();
    }
    private void sendSMS(string Username, string MobileNo, int Otp)
    {
        // Ensure namespaces:
        // using System.Net;
        // using System.IO;
        // using System;
        // using System.Web;  // for HttpUtility.UrlEncode (ASP.NET WebForms)

        if (!string.IsNullOrWhiteSpace(MobileNo) && MobileNo.Length >= 10)
        {
            WebClient client = new WebClient();
            string baseurl;
            Stream data;
            DateTime time = DateTime.Now;
            string format = "dd-MMM-yyyy HH:mm:ss ";

            string sms = "" + Otp + " is your OTP for use wallet and is valid for 10 minutes. Do not share the OTP with anyone. Regard : Overnet Team";

            try
            {
                // note: URL-encode the message to avoid problems with spaces/special characters
                string encodedMsg = HttpUtility.UrlEncode(sms);

                // original VB url (kept same structure)
                baseurl = "http://78.46.58.54/vb/apikey.php?apikey=baeVEum0EOQkbng7&senderid=OVRNET&templateid=1707169640731570892&number="
                          + MobileNo + "&message=" + encodedMsg;

                data = client.OpenRead(baseurl);
                using (StreamReader reader = new StreamReader(data))
                {
                    string s = reader.ReadToEnd();
                    // optionally log `s` if you need response
                }

                // close the stream (using handles this already)
            }
            catch (Exception)
            {
                // swallow exception like original VB code (you may want to log ex.Message here)
            }
        }
    }
    protected void CmdSave_Click(object sender, EventArgs e)
    {
        try
        {
            string scrName;
            DataTable Dt1 = new DataTable();
            // Generate OTPs

            string str = objDal.Isostart + "select * from " + objDal.dBName + "..M_MemberMaster where Formno=" + Session["Formno"] + objDal.IsoEnd;
            Dt1 = SqlHelper.ExecuteDataset(constr1, CommandType.Text, str).Tables[0];
            if (Dt1.Rows.Count > 0)
            {
                Random Rs = new Random();
                int OTP_ = Rs.Next(100001, 999999);

                Random Rs1 = new Random();
                int OTPP_ = Rs1.Next(200001, 999999);
                string Idno = Dt1.Rows[0]["Idno"].ToString();
                string membername = Dt1.Rows[0]["MemFirstname"].ToString();
                TxtMemName.Text = membername;
                string mobileno = Dt1.Rows[0]["Mobl"].ToString();
                LblMobile.Text = mobileno;

                sendSMS(membername, mobileno, OTP_);

                objDal = new DAL();
                int i = 0;
                string R = "INSERT into AdminLogin(UserID, Username, Passw, MobileNo, Otp) " +
                           "VALUES ('0','" + membername + "','0','" + mobileno + "','" + OTP_ + "')";

                i = objDal.SaveData(R);

                if (i > 0)
                {
                    divOtp.Visible = true;
                    txtAmount.Enabled = false;
                    TxtRemark.Enabled = false;
                    TxtMemId.Enabled = false;
                    //TxtPassword.Text = Session["transpasswd"].ToString();
                    //TxtPassword.Enabled = false;
                    DivTerms.Visible = false;
                }
                else
                {
                    scrName = "<SCRIPT language='javascript'>alert('Try Again.');</SCRIPT>";
                    this.RegisterStartupScript("MyAlert", scrName);
                    return;
                }
            }
            else
            {
                scrName = "<SCRIPT language='javascript'>alert('Try Again.');</SCRIPT>";
                this.RegisterStartupScript("MyAlert", scrName);
                return;
            }
        }
        catch (Exception ex)
        {
            // You may optionally log ex.Message here
        }
    }
    protected void cmdSave1_Click(object sender, EventArgs e)
    {
        string q = objDal.Isostart + "Select a.Formno, MemFirstName + MemLastName as MemName from " + objDal.dBName + "..M_Membermaster as a" +
            " where a.IsBlock='N' and IdNo='" + TxtMemId.Text + "'" + objDal.IsoEnd;
        DataTable dt1 = new DataTable();
        objDal = new DAL();
        dt1 = SqlHelper.ExecuteDataset(constr1, CommandType.Text, q).Tables[0];
        if (dt1.Rows.Count == 0)
        {
            scrName = "<SCRIPT language='javascript'>alert('This id is not your downline');</SCRIPT>";
            this.RegisterStartupScript("MyAlert", scrName);
            TxtMemName.Text = "";
            return;
        }
        else if (!validotp(TxtMemName.Text, LblMobile.Text, TxtPassword1.Text))
        {
            scrName = "<SCRIPT language='javascript'>alert('Please enter Valid OTP.');</SCRIPT>";
            this.RegisterStartupScript("MyAlert", scrName);
            return;
        }
        else
        {
            string TransPassw = TxtPassword.Text.Trim();
            Session["transpasswd"] = TransPassw;
            DataTable Dt1 = new DataTable();
            string scrName;
            objDal = new DAL();
            string str = objDal.Isostart + "select * from " + objDal.dBName + "..M_MemberMaster where Epassw='" + TransPassw + "' and Formno=" + Session["Formno"] + objDal.IsoEnd;
            Dt1 = SqlHelper.ExecuteDataset(constr1, CommandType.Text, str).Tables[0];
            if (Dt1.Rows.Count > 0)
            {
                AmountTransfer();
            }
            else
            {
                Session["CkyPinTransfer1"] = null;
                scrName = "<script language='javascript'>alert('Please Enter valid Transaction Password.');</script>";
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Login Error", scrName, false);
                return;
            }
        }
    }
    protected void btngenerate_Click(object sender, EventArgs e)
    {
        try
        {
            DataTable Dt1 = new DataTable();
            string scrName;

            objDal = new DAL();

            string str = objDal.Isostart + "select * from " + objDal.dBName + "..M_MemberMaster where Formno=" + Session["Formno"] + objDal.IsoEnd;
            Dt1 = SqlHelper.ExecuteDataset(constr1, CommandType.Text, str).Tables[0];
            if (Dt1.Rows.Count > 0)
            {
                // Generate OTPs
                Random Rs = new Random();
                int OTP_ = Rs.Next(100001, 999999);

                Random Rs1 = new Random();
                int OTPP_ = Rs1.Next(200001, 999999);

                string Idno = Dt1.Rows[0]["Idno"].ToString();
                string membername = Dt1.Rows[0]["MemFirstname"].ToString();
                TxtMemName.Text = membername;
                string mobileno = Dt1.Rows[0]["Mobl"].ToString();
                LblMobile.Text = mobileno;

                // Send SMS
                sendSMS(membername, mobileno, OTP_);

                objDal = new DAL();
                int i = 0;
                string R = "INSERT into AdminLogin(UserID, Username, Passw, MobileNo, Otp) " +
                           "VALUES ('0','" + membername + "','0','" + mobileno + "','" + OTP_ + "')";

                i = objDal.SaveData(R);

                if (i > 0)
                {
                    divOtp.Visible = true;
                    txtAmount.Enabled = false;
                    TxtRemark.Enabled = false;
                    TxtMemId.Enabled = false;
                    DivTerms.Visible = false;
                }
                else
                {
                    scrName = "<SCRIPT language='javascript'>alert('Try Again.');</SCRIPT>";
                    this.RegisterStartupScript("MyAlert", scrName);
                    return;
                }
            }
            else
            {
                Session["CkyPinTransfer1"] = null;
                scrName = "<script language='javascript'>alert('Try Again');</script>";
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Login Error", scrName, false);
                return;
            }
        }
        catch (Exception ex)
        {
            // optionally log ex.Message
        }
    }
    public bool validotp(string username, string userMobile, string otpcode)
    {
        try
        {
            DataTable Dt = new DataTable();
            DAL objDal = new DAL();

            string strr = objDal.Isostart + "Select TOP 1 * from " + objDal.dBName + "..AdminLogin as a where " +
                          "UserName='" + username + "' and Mobileno='" + Convert.ToInt64(userMobile) + "' AND OTP = '" + otpcode + "'" +
                          "and Cast(logintime as date) = cast(getdate() as date) ORDER BY AID DESC" + objDal.IsoEnd;

            Dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strr).Tables[0];

            if (Dt.Rows.Count > 0)
            {
                if (Dt.Rows[0]["OTP"].ToString() == otpcode)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            else
            {
                return false;
            }
        }
        catch (Exception)
        {
            // optionally log ex.Message
            return false;
        }
    }
    protected void AmountTransfer()
    {
        string query;
        string voucherNo = "";
        string VoucherNo2 = "";
        string scrName;

        if (TxtMemId.Text.Trim().ToLower() == Session["IdNo"].ToString().ToLower())
        {
            scrName = "<SCRIPT language='javascript'>alert('Can Not Transfer Main Wallet Amount to Self ID');</SCRIPT>";
            this.RegisterStartupScript("MyAlert", scrName);
            return;
        }

        string q = objDal.Isostart + "Select a.Formno, MemFirstName+MemLastName as MemName from " + objDal.dBName + "..M_Membermaster as a " +
                   "where a.IsBlock='N' and IdNo='" + TxtMemId.Text + "'" + objDal.IsoEnd;
        DataTable dt1 = new DataTable();
        objDal = new DAL();
        dt1 = SqlHelper.ExecuteDataset(constr1, CommandType.Text, q).Tables[0];
        if (dt1.Rows.Count == 0)
        {
            scrName = "<SCRIPT language='javascript'>alert('This id is not your downline');</SCRIPT>";
            this.RegisterStartupScript("MyAlert", scrName);
            TxtMemName.Text = "";
            return;
        }

        if (Convert.ToDecimal(txtAmount.Text) < 0)
        {
            scrName = "<SCRIPT language='javascript'>alert('Amount cannot be negative');</SCRIPT>";
            this.RegisterStartupScript("MyAlert", scrName);
            TxtMemName.Text = "";
            return;
        }

        if (Convert.ToDecimal(txtAmount.Text) < 100)
        {
            scrName = "<SCRIPT language='javascript'>alert('Transfer Amount should be greater than 100');</SCRIPT>";
            this.RegisterStartupScript("MyAlert", scrName);
            TxtMemName.Text = "";
            return;
        }

        // Check balance
        CheckAmount();
        if (Convert.ToDecimal(Session["ServiceWallet"]) >= Convert.ToDecimal(txtAmount.Text))
        {
            string sql = objDal.Isostart + "select IsNull(Max(VoucherNo+1),100001) as VoucherNo from " + objDal.dBName + "..TrnVoucher" + objDal.IsoEnd;
            DataTable dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, sql).Tables[0];
            if (dt.Rows.Count > 0)
            {
                voucherNo = dt.Rows[0]["VoucherNo"].ToString();
                VoucherNo2 = (Convert.ToInt32(voucherNo) + 1).ToString();
            }

            string Remarks = "Main Wallet Amount Transfer To " + TxtMemId.Text + " from " + Session["IDNo"] + "";
            string Remark2 = "Main Wallet Amount Transfer To " + TxtMemId.Text + " (" + TxtRemark.Text + ")";
            string Remark1 = "Main Wallet Amount Received From " + Session["IDNo"] + " " + Session["MemName"] + " (" + TxtRemark.Text + ")";
            query = "insert into TrnVoucher(VoucherNo,VoucherDate,DrTo,CrTo,Amount,Narration,RefNo,AcType,RecTimeStamp,VType,SessID,WSessID) values " +
                    "('" + voucherNo + "',Getdate(),'" + Convert.ToInt32(Session["Formno"]) + "',0,'" + Convert.ToDecimal(txtAmount.Text) + "','" + Remark2 + "','" + voucherNo + "/" + Session["Formno"] + "/" + LblFormno.Text + "','M',GetDate(),'D',Convert(Varchar,GetDate(),112)," + Session["CurrentSessn"] + ")";

            query += "insert into TrnVoucher(VoucherNo,VoucherDate,DrTo,CrTo,Amount,Narration,RefNo,AcType,RecTimeStamp,VType,SessID,WSessID) values " +
                     "('" + VoucherNo2 + "',Getdate(),0,'" + Convert.ToInt32(LblFormno.Text) + "','" + Convert.ToDecimal(txtAmount.Text) + "','" + Remark1 + "','" + VoucherNo2 + "/" + Session["Formno"] + "/" + LblFormno.Text + "','M',GetDate(),'C',Convert(Varchar,GetDate(),112)," + Session["CurrentSessn"] + ")";

            query += "insert into UserHistory(UserId,UserName,PageName,Activity,ModifiedFlds,RecTimeStamp,MemberId) values " +
                     "(0,'" + Session["MemName"] + "','Main Wallet Transfer','Main Wallet Transfer To Other Id','" + Remarks + "',Getdate(),'" + Session["FormNo"] + "')";

            CheckAmount();
            if (Convert.ToDecimal(Session["ServiceWallet"]) >= Convert.ToDecimal(txtAmount.Text))
            {
                if (objDal.SaveData(query) != 0)
                {
                    TxtMemId.Text = "";
                    TxtMemName.Text = "";
                    txtAmount.Text = "";
                    TxtRemark.Text = "";
                    LblAmount.Text = "";
                    LblAmount.Visible = false;
                    divOtp.Visible = false;
                    scrName = "<SCRIPT language='javascript'>alert('Amount Transfer Successfully!!');location.replace('ServiceWalletTransfer.aspx');</SCRIPT>";
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Upgraded", scrName, false);
                    FundWalletGetBalance();
                }
            }
        }
        else
        {
            TxtMemId.Text = "";
            TxtMemName.Text = "";
            txtAmount.Text = "";
            TxtRemark.Text = "";
            LblAmount.Text = "";
            LblAmount.Visible = false;
            divOtp.Visible = false;
            scrName = "<SCRIPT language='javascript'>alert('Insufficient Balance!!');</SCRIPT>";
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Upgraded", scrName, false);
        }
    }
}
