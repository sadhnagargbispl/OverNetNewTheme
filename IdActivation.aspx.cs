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
//using DocumentFormat.OpenXml.Wordprocessing;
public partial class Idactivation : System.Web.UI.Page
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
                    //AirDropWalletGetBalance();

                    //txtMemberId.Text = Session["IdNo"] != null ? Session["IdNo"].ToString() : string.Empty;
                    //GetName();
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
    public string GetName()
    {
        try
        {
            string str = string.Empty;
            DataTable dt = new DataTable();

            str = objDal.Isostart + " Exec Sp_GetMemberName '" + txtMemberId.Text + "'" + objDal.IsoEnd;
            dt = SqlHelper.ExecuteDataset(ConfigurationManager.ConnectionStrings["constr1"].ConnectionString, CommandType.Text, str).Tables[0];

            if (dt.Rows.Count == 0)
            {
                txtMemberId.Text = string.Empty;
                TxtMemberName.Text = string.Empty;
                HdnMemberMacAdrs.Value = string.Empty;
                HdnMemberTopupseq.Value = string.Empty;

                string scrName = "<SCRIPT language='javascript'>alert('Invalid ID Does Not Exist');</SCRIPT>";
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Login Error", scrName, false);
            }
            else
            {
                if (dt.Rows[0]["Isblock"].ToString() == "Y")
                {
                    txtMemberId.Text = string.Empty;
                    TxtMemberName.Text = string.Empty;
                    HdnMemberMacAdrs.Value = string.Empty;
                    HdnMemberTopupseq.Value = string.Empty;

                    string scrName = "<SCRIPT language='javascript'>alert('This Id is blocked. Please Contact Admin.');</SCRIPT>";
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Login Error", scrName, false);
                    return string.Empty;
                }
                else if (dt.Rows[0]["ActiveStatus"].ToString() == "N")
                {
                    TxtMemberName.Text = dt.Rows[0]["memname"].ToString();
                    HdnMemberMacAdrs.Value = dt.Rows[0]["MacAdrs"].ToString();
                    HdnMemberTopupseq.Value = dt.Rows[0]["Topupseq"].ToString();
                    MemberStatus.Value = dt.Rows[0]["ActiveStatus"].ToString();
                    hdnFormno.Value = dt.Rows[0]["Formno"].ToString();
                    hdnemail.Value = dt.Rows[0]["Email"].ToString();
                    LblMobile.Text = string.Empty;
                    return "OK";
                }
                else
                {
                    TxtMemberName.Text = dt.Rows[0]["memname"].ToString();
                    HdnMemberMacAdrs.Value = dt.Rows[0]["MacAdrs"].ToString();
                    HdnMemberTopupseq.Value = dt.Rows[0]["Topupseq"].ToString();
                    MemberStatus.Value = dt.Rows[0]["ActiveStatus"].ToString();
                    hdnFormno.Value = dt.Rows[0]["Formno"].ToString();
                    hdnemail.Value = dt.Rows[0]["Email"].ToString();
                    LblMobile.Text = string.Empty;
                    return "OK";
                }
            }
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ": " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff") + Environment.NewLine;
            objDal.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }

        return string.Empty;
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
    protected void cmdSave1_Click(object sender, EventArgs e)
    {
        try
        {
            if (txtAmount.Text == "")
            {
                scrName = "<script language='javascript'>alert('Please Fill Request Amount !');</script>";
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Upgraded", scrName, false);
                txtAmount.Text = "";
                return; // Exit the method
            }
            if (Convert.ToDouble(txtAmount.Text) == 0)
            {
                string scrName = "<SCRIPT language='javascript'>alert('Invalid Amount.');</SCRIPT>";
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Upgraded", scrName, false);
                return;
            }
            
            if (!string.IsNullOrEmpty(txtAmount.Text))
            {
                //if (!Check_Amount_Condition())
                if (!CheckAmount())
                {
                    txtAmount.Text = "";
                    //TxtPointWallet.Text = "";
                    return;
                }
            }
            string str = objDal.Isostart + " Exec Sp_CheckTransctionPassword '" + Convert.ToInt32(Session["Formno"]) + "','" + TxtTransPass.Text.Trim() + "'" + objDal.IsoEnd;
            DataTable dts = SqlHelper.ExecuteDataset(ConfigurationManager.ConnectionStrings["constr1"].ConnectionString, CommandType.Text, str).Tables[0];
            if (dts.Rows.Count > 0)
            {
                if (string.IsNullOrWhiteSpace(txtMemberId.Text))
                {
                    string scrName = "<SCRIPT language='javascript'>alert('Enter Id No.');</SCRIPT>";
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Upgraded", scrName, false);
                    return;
                }
                else if (Convert.ToDouble(txtAmount.Text) == 0)
                {
                    string scrName = "<SCRIPT language='javascript'>alert('Invalid Amount.');</SCRIPT>";
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Upgraded", scrName, false);
                    return;
                }
                else if (Checkid() == string.Empty)
                {
                    if (DDLPaymode.SelectedValue == "1")
                    {
                        IdActivation();
                    }
                }
            }
            else
            {
                string scrName = "<SCRIPT language='javascript'>alert('Invalid Wallet Password ');</SCRIPT>";
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Upgraded", scrName, false);
            }
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ": " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff") + Environment.NewLine;
            objDal.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
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
    protected void IdActivation()
    {
        try
        {
            string query = "";
            string kitid = "";
            string strSql = "Insert into Trnactive (Transid, Rectimestamp) values(" + HdnCheckTrnns.Value + ", GETDATE())";
            int updateEffect = objDal.SaveData(strSql);

            if (updateEffect > 0)
            {
                if (GetName() == "OK")
                {
                    CheckAmount();
                    //Check_Amount_Condition();
                    //if (Convert.ToDecimal(Session["ServiceWallet"]) >= Convert.ToDecimal(txtAmount.Text))
                    if (Convert.ToDecimal(Session["ServiceWallet"]) >= Convert.ToDecimal(txtAmount.Text))
                    {
                            DataTable dt_ = new DataTable();
                            string str = "select  * from " + objDal.dBName + "..m_kitmaster where joinamount <= '" + txtAmount.Text + "' AND kitamount >= '" + txtAmount.Text + "' order by kitid desc";
                            dt_ = SqlHelper.ExecuteDataset(constr1, CommandType.Text, str).Tables[0];
                            if (dt_.Rows.Count > 0)
                            {
                                kitid = Convert.ToString(dt_.Rows[0]["kitid"]);
                            }
                            string sql = "";
                            string strSql1 = "EXEC Sp_trnAcivate '" + txtMemberId.Text.Trim() + "', '" + kitid + "'";
                            DataTable dtCheck = SqlHelper.ExecuteDataset(constr, CommandType.Text, strSql1).Tables[0];
                            var billNo = GenerateRandomStringactive(6);
                            if (Convert.ToInt32(dtCheck.Rows[0]["Result"]) == 0)
                            {
                                scrName = "<SCRIPT language='javascript'>alert('Your request in processing, Please try after 10 min.!!');</SCRIPT>";
                                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Upgraded", scrName, false);
                                return;
                            }
                            sql = "EXEC Sp_PaymentActivateNew '" + txtMemberId.Text.Trim() + "','" + kitid + "', '','" + txtAmount.Text + "','USDT',";
                            sql += "'" + billNo + "','" + Session["Formno"] + "'";
                            DataTable dt = SqlHelper.ExecuteDataset(constr, CommandType.Text, sql).Tables[0];

                            if (dt.Rows[0]["Result"].ToString().ToUpper() == "SUCCESS")
                            {
                                Clear();
                                FundWalletGetBalance();
                               
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "Key", "alert('Id Activation/Upgrade Successfully!!');location.replace('IdActivation.aspx');", true);
                            }
                            else
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "Key", "alert('Id Activation/Upgrade Not Successfully!!');", true);
                            }
                        
                    }
                    else
                    {
                        var scrName = "<SCRIPT language='javascript'>alert('Insufficient Balance In Fund Wallet.!');</SCRIPT>";
                        ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Error", scrName, false);
                    }
                }
            }
            else
            {
                Response.Redirect("IdActivation.aspx");
            }
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ": " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff") + Environment.NewLine;
            objDal.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }
    }
    protected void Clear()
    {
        try
        {
            txtMemberId.Text = "";
            TxtMemberName.Text = "";
            txtAmount.Text = "";
            // TxtRemark.Text = ""; // Uncomment if this field is used
            LblAmount.Text = "";
            LblAmount.Visible = false;
            LblError.Visible = false;
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff ") + Environment.NewLine;
            objDal.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }
    }
    private string Checkid()
    {
        try
        {
            string str = string.Empty;

            if (GetName() == "OK")
            {
                str = "";
            }

            return str;
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ": " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff") + Environment.NewLine;
            objDal.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }

        return string.Empty;
    }
    protected void FillKit()
    {
        try
        {
            string query = "";
            DataTable dt;
            string condition = "";

            if (DDLPaymode.SelectedValue == "1")
            {
                condition = " ";
            }
            else
            {
                condition = "";
            }

            dt = new DataTable();
            query = objDal.Isostart + " Exec Sp_GetKitForActivation '" + Session["Formno"] + "','S', '" + HdnMemberTopupseq.Value + "'" + objDal.IsoEnd;
            dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, query).Tables[0];

            if (dt.Rows.Count > 0)
            {
                Session["KitTable"] = dt;
                CmbKit.DataSource = dt;
                CmbKit.DataTextField = "KitName";
                CmbKit.DataValueField = "KitId";
                CmbKit.DataBind();

                // Optional: Set Amount if needed
                // txtAmount.Text = dt.Rows[0]["KitAmount"].ToString();

                hdnMacadrs.Value = dt.Rows[0]["MacAdrs"].ToString();
                HdnTopupSeq.Value = dt.Rows[0]["TopupSeq"].ToString();
                Session["HdnTopupSeq"] = HdnTopupSeq.Value;
            }
            else
            {
                Session["KitTable"] = dt;
                CmbKit.DataSource = dt;
                CmbKit.DataTextField = "KitName";
                CmbKit.DataValueField = "KitId";
                CmbKit.DataBind();

                txtAmount.Text = "0";
                hdnMacadrs.Value = "";
                HdnTopupSeq.Value = "";
                Session["HdnTopupSeq"] = HdnTopupSeq.Value;
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
    private bool CheckValidId()
    {
        try
        {
            DataTable dt;
            string query = "SELECT TOP 1 Amount FROM MemberKitPurchase WHERE Formno='" + hdnFormno.Value + "' ORDER BY KId DESC";
            dt = objDal.GetData(query);

            if (dt.Rows.Count > 0)
            {
                if (Convert.ToDecimal(txtAmount.Text) >= Convert.ToDecimal(dt.Rows[0]["Amount"]))
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
                return true;
            }
        }
        catch (Exception ex)
        {
            // Log or handle the exception if needed.
            throw new ApplicationException("Error in CheckValidId: " + ex.Message, ex);
        }
    }
    protected bool CheckAmount()
    {
        try
        {
            DataTable dt;
            string str = objDal.Isostart + " Select * From dbo.ufnGetBalance('" + Convert.ToInt32(Session["Formno"]) + "','S')" + objDal.IsoEnd;

            dt = new DataTable();
            dt = SqlHelper.ExecuteDataset(ConfigurationManager.ConnectionStrings["constr1"].ConnectionString, CommandType.Text, str).Tables[0];

            if (dt.Rows.Count > 0)
            {
                Session["ServiceWallet"] = Convert.ToDouble(dt.Rows[0]["Balance"]);
                LblAmount.Text = Convert.ToDouble(dt.Rows[0]["Balance"]).ToString();

                if (Convert.ToDouble(Session["ServiceWallet"]) < Convert.ToDouble(txtAmount.Text))
                {
                    LblAmount.Text = "Insufficient Balance";
                    LblAmount.ForeColor = System.Drawing.Color.Red;
                    LblAmount.Visible = true;
                    cmdSave1.Enabled = false;
                    return false;
                }
                else
                {
                    // LblAmount.Text = "";
                    cmdSave1.Enabled = true;
                    LblAmount.Visible = false;
                    return true;
                }
            }
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ": " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff") + Environment.NewLine;
            objDal.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }

        return false;
    }
    protected void FundWalletGetBalance()
    {
        try
        {
            DataTable dt = new DataTable();
            string str = " Select * From dbo.ufnGetBalance('" + Convert.ToInt32(Session["Formno"]) + "','S')";
            dt = SqlHelper.ExecuteDataset(constr, CommandType.Text, str).Tables[0];
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
   
    protected void txtAmount_TextChanged(object sender, EventArgs e)
    {
        try
        {
            //if (Convert.ToDecimal(txtAmount.Text) <= 1 || Convert.ToDecimal(txtAmount.Text) % 10 != 0)
            if (Convert.ToDecimal(txtAmount.Text) < 1)
            {
                scrName = "<script language='javascript'>alert('The Investment be more than 1 !!');</script>";
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Upgraded", scrName, false);
                txtAmount.Text = "";
                return; // Exit the method
            }
           // AirDropWalletGetBalance();
            FundWalletGetBalance();
            CheckAmountTop();
            //Check_Amount_Condition();
        }
        catch (Exception ex)
        {
        }

    }
    protected bool CheckAmountTop()
    {
        try
        {
            DataTable dt = new DataTable();
            // Change the SQL query to sum the Repurchincome for the given Formno
            string str = " SELECT SUM(Repurchincome) AS TotalInvestment FROM " + objDal.dBName + "..repurchincome WHERE Formno = '" + hdnFormno.Value + "'";
            dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, str).Tables[0];
            if (dt.Rows.Count > 0)
            {
                decimal totalInvestment = Convert.ToDecimal(dt.Rows[0]["TotalInvestment"]);
                LblAmount.Text = totalInvestment.ToString();
                // Check if the activation amount is greater than or equal to total investment and a multiple of 90
                decimal activationAmount = Convert.ToDecimal(txtAmount.Text);
                //if (activationAmount < totalInvestment || activationAmount % 10 != 0)
                if (activationAmount < totalInvestment)
                {
                    string scrName = "<SCRIPT language='javascript'>alert('Your Activation Amount must be equal to or greater than the total investment !');</SCRIPT>";
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Upgraded", scrName, false);
                    cmdSave1.Enabled = false;
                    cmdSave1.Attributes.Add("onclick", DisableTheButton(this.Page, cmdSave1));
                    txtAmount.Text = "0";
                    //TxtPointWallet.Text = "0";
                    txtAmount.Text = "0";
                    return false; // Return false if the condition is not met
                }
                else
                {
                    cmdSave1.Enabled = true;
                    LblAmount.Visible = false;
                    return true; // Return true if the condition is met
                }
            }
            else
            {
                cmdSave1.Enabled = true;
                LblAmount.Visible = false;
                return true; // Return true if no records found
            }
        }
        catch (Exception ex)
        {

        }

        return false; // Default return false in case of exception
    }
    //private bool Check_Amount_Condition()
    //{
    //    bool result = false;

    //    // Fetch wallet balances
    //    decimal fundWalletAmount = Convert.ToDecimal(Session["ServiceWallet"]); // Fund Wallet balance
    //    //decimal airdropWalletAmount = Convert.ToDecimal(Session["PointWallet"]); // Airdrop Wallet balance
    //    decimal requestAmount = Convert.ToDecimal(txtAmount.Text); // Requested amount

    //    // Calculate maximum allowed usage from Airdrop Wallet (50% of request amount)
    //    decimal maxAirdropWalletUsage = requestAmount * 0.50m;

    //    // Calculate actual usage from Airdrop Wallet (use as much as possible)
    //    //decimal amountFromAirdropWallet = Math.Min(maxAirdropWalletUsage, airdropWalletAmount);

    //    // Remaining amount to be fulfilled from Fund Wallet
    //    //decimal remainingAmount = requestAmount - amountFromAirdropWallet;

    //    // Calculate actual usage from Fund Wallet
    //    //decimal amountFromFundWallet = Math.Min(remainingAmount, fundWalletAmount);
    //    decimal amountFromFundWallet= fundWalletAmount;
    //    // Check if the total fulfilled amount meets the request
    //    //bool isRequestFulfilled = (amountFromAirdropWallet + amountFromFundWallet) >= requestAmount;
    //    bool isRequestFulfilled = (amountFromFundWallet) >= requestAmount;

    //    // Update UI
    //    //TxtPointWallet.Text = amountFromAirdropWallet.ToString("F2"); // Airdrop Wallet Usage
    //    txtAmount.Text = amountFromFundWallet.ToString("F2");        // Fund Wallet Usage
    //    //LblAmountUse.Text = (amountFromAirdropWallet + amountFromFundWallet).ToString("F2"); // Total Usage
    //    LblAmountUse.Text = (amountFromFundWallet).ToString("F2"); // Total Usage

    //    // Check and return result
    //    if (isRequestFulfilled)
    //    {
    //        cmdSave1.Visible = true;
    //        result = true;
    //    }
    //    else
    //    {
    //        string scrName = "<SCRIPT language='javascript'>alert('Your wallet does not have the balance required to meet the requested amount.!');</SCRIPT>";
    //        ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Wallet Error", scrName, false);
    //        cmdSave1.Visible = false;
    //        result = false;
    //    }
    //    return result;
    //}

    protected void txtMemberId_TextChanged(object sender, EventArgs e)
    {
        GetName();
    }
}
