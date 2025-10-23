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
using System.Activities;
using System.ServiceModel.Activities;
using DocumentFormat.OpenXml.Presentation;
using DocumentFormat.OpenXml.Spreadsheet;
using System.Text.RegularExpressions;
public partial class NewJoiningBackup : System.Web.UI.Page
{

    private double _dblAvailLeg = 0;
    private cls_DataAccess dbConnect;
    private cls_DataAccess dbConnectSelect;
    private DAL ObjDAL = new DAL();
    private SqlCommand cmd = new SqlCommand();
    private SqlDataReader dRead;
    public string DsnName, UserName, Passw;
    private string strQuery, strCaptcha;
    private DataTable tmpTable = new DataTable();
    private int minSpnsrNoLen, minScrtchLen;
    private double Upln, dblSpons, dblState, dblBank, dblIdNo;
    private string dblDistrict, dblTehsil, IfSC;
    private string dblPlan;
    private DateTime CurrDt;
    private string scrname;
    private string LastInsertID = "";
    private string Email = "";
    private string InVoiceNo;
    private int SupplierId;
    private string BillNo;
    private string TaxType;
    private string BillDate;
    private int SBillNo;
    private string SoldBy = "WR";
    private string FType;
    private string Password = "";
    private string membername = "";
    private string clsGeneral = "";
    private clsGeneral dbGeneral = new clsGeneral();
    private string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
    private string constr1 = ConfigurationManager.ConnectionStrings["constr1"].ConnectionString;
    private SqlConnection cnn;
    DataTable Dt = new DataTable();
    string IsoStart;
    string IsoEnd;
    protected void Page_Load(object sender, System.EventArgs e)
    {
        try
        {
            dbConnect = new cls_DataAccess(constr);
            dbConnect.OpenConnection();

            dbConnectSelect = new cls_DataAccess(constr1);
            dbConnectSelect.OpenConnection();

            string sr = "";
            string[] sbstr;
            string Key = "";
            string K = "";

            if (!Page.IsPostBack)
            {
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                txtUplinerId.Text = txtUplinerId.Text.Trim()
                    .Replace("'", "")
                    .Replace("=", "")
                    .Replace(";", "");

                //string s1 = IsoStart + " Exec Sp_CheckPageLockStatus " + IsoEnd;
                //DataTable dt1 = SqlHelper.ExecuteDataset(constr1, CommandType.Text, s1).Tables[0];
                //if (dt1.Rows.Count > 0)
                //{
                //    string pageStatus = dt1.Rows[0]["PageStatus"].ToString();
                //    if (pageStatus == "LOCKED")
                //    {
                //        ClientScript.RegisterStartupScript(this.GetType(), "LockPage", "showLockOverlay();", true);
                //    }
                //}

                ClrCtrl();
                RbtnLegNo.Items.Add("Left");
                RbtnLegNo.Items.Add("Right");
                RbtnLegNo.Items[0].Selected = true;

                if (!string.IsNullOrEmpty(Request.QueryString["s"]))
                {
                    K = Request["s"];
                    K = K.Replace(" ", "+");
                    sr = Crypto.Decrypt(K);

                    sbstr = sr.Split('/');
                    string UplinerFormno = sbstr[1];

                    DataTable dt = new DataTable();
                    string s = ObjDAL.Isostart + " select * from " + ObjDAL.dBName + "..M_MemberMaster where Formno='" + UplinerFormno + "'" + ObjDAL.IsoEnd;
                    dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, s).Tables[0];
                    if (dt.Rows.Count > 0)
                    {
                        txtUplinerId.Text = dt.Rows[0]["Idno"].ToString();
                    }

                    string LegNo = sbstr[3];

                    txtUplinerId.ReadOnly = true;
                    txtRefralId.Text = Session["Idno"].ToString();

                    if (LegNo == "1")
                    {
                        RbtnLegNo.SelectedIndex = 0;
                    }
                    else
                    {
                        RbtnLegNo.SelectedIndex = 1;
                    }

                    RbtnLegNo.Enabled = false;
                    Session["iLeg"] = LegNo;
                }
                //refLink:

                if (Request.QueryString["ref"] != null)
                {

                    string req = Request.QueryString["ref"].Replace(" ", "+");
                    string str = Crypto.Decrypt(req);
                    string[] rfAr = str.Split('/');
                    if (rfAr.Length >= 1)
                    {
                        if (rfAr[0] != "" & rfAr[1] == "0")
                        {
                            RbCategory.SelectedValue = rfAr[2];
                            foreach (ListItem item in RbCategory.Items)
                            {
                                if (item.Value != rfAr[2])
                                {
                                    item.Enabled = false;
                                    item.Attributes["style"] = "display:none;";
                                }
                            }
                            txtRefralId.Text = GetIDno(rfAr[0].ToString());

                            //goto refLink;
                        }
                        else if (rfAr[0] != "" & rfAr[1] == "1")
                        {
                            txtRefralId.Text = GetIDno(rfAr[0].ToString());
                            RbtnLegNo.SelectedIndex = 0;
                            RbtnLegNo.Enabled = false;
                            //goto refLink;
                        }
                        else if (rfAr[0] != "" & rfAr[1] == "2")
                        {
                            txtRefralId.Text = GetIDno(rfAr[0].ToString());
                            RbtnLegNo.SelectedIndex = 1;
                            RbtnLegNo.Enabled = false;
                            // goto refLink;
                        }
                    }
                    if (txtRefralId.Text.Trim() != "")
                    {
                        FillReferral(cnn);
                    }
                    txtRefralId.ReadOnly = true;
                }

                if (!string.IsNullOrEmpty(Request.QueryString["Pin"]))
                {
                    txtPIN.Text = Request.QueryString["Pin"];
                    txtPIN.ReadOnly = true;
                }

                if (!string.IsNullOrEmpty(Request.QueryString["scratch"]))
                {
                    txtScratch.Text = Request.QueryString["scratch"];
                    txtScratch.ReadOnly = true;
                }

                if (txtPIN.Text.Length > 0 && txtScratch.Text.Length > 0)
                {
                    CheckEpin();
                }

                FillPaymode();
                dbGeneral.Fill_Date_box(ddlDOBdt, ddlDOBmnth, ddlDOBYr, 1940, DateTime.Now.AddYears(-18).Year);
                dbGeneral.Fill_Date_box(DDlMDay, DDLMMonth, DDLMYear, 1940, DateTime.Now.Year);
                FillBankMaster();
                //CreateBlankTable();
                //FillKit();
                //Fill_DeliveryCenter();
                FillStateMaster();

                FindSession();
                GetConfigDtl();
                //sendSMS();
                vsblCtrl(false, true);
            }

            /*
            try
            {
                string s = IsoStart + "Select top 1 SessId as SessId from " + ObjDAL.dBName + "..M_MonthSessnMaster order by SessID desc" + IsoEnd;
                DataTable dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, s).Tables[0];
                if (dt.Rows.Count > 0)
                {
                    Session["Dsessid"] = dt.Rows[0]["SessID"];
                }
                else
                {
                    Session["Dsessid"] = 0;
                }
            }
            catch { }
            */

            if (Session["IsGetExtreme"] != null && Session["IsGetExtreme"].ToString() == "N")
            {
                rwSpnsr.Visible = true;
            }
            else
            {
                rwSpnsr.Visible = false;
            }
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff ") + Environment.NewLine;
            ObjDAL.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }

    }
    private void FillStateMaster()
    {
        try
        {
            // strQuery = "SELECT STATECODE, STATENAME as State FROM M_StateDivMaster WHERE ACTIVESTATUS='Y' ORDER BY STATENAME";
            strQuery = IsoStart +
                       "select top 1 * from (" +
                       "SELECT 0 as STATECODE, '--Choose State Name--' as STATE " +
                       "union " +
                       "SELECT STATECODE, STATENAME as State " +
                       "FROM " + ObjDAL.dBName + "..M_StateDivMaster " +
                       "WHERE ACTIVESTATUS='Y' and Statecode>=0 ) as temp " +
                       "ORDER BY STATE" +
                       IsoEnd;

            // dbConnect.OpenConnection();
            dbConnectSelect.Fill_Data_Tables(strQuery, tmpTable);

            ddlstate.DataSource = tmpTable;
            ddlstate.DataValueField = "STATECODE";
            ddlstate.DataTextField = "State";
            ddlstate.DataBind();

            ddlstate.SelectedIndex = 0;
            // HPostStateCode.Value = tmpTable.Rows[0]["STATECODE"].ToString();
            StateCode.Value = tmpTable.Rows[0]["STATECODE"].ToString();
        }
        catch (Exception ex)
        {
            // Optional: log the error if desired
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff ") + Environment.NewLine;
            ObjDAL.WriteToFile(text + ex.Message);
        }
    }
    private void FillPaymode()
    {
        try
        {
            DataTable dt = new DataTable();
            DataSet ds = new DataSet();
            string strSql = IsoStart + "SELECT top 1 * FROM " + ObjDAL.dBName + "..M_PayModeMaster WHERE ActiveStatus='Y' " + IsoEnd;

            if (Session["DtPayMode"] == null)
            {
                ds = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strSql);
                dt = ds.Tables[0];
                Session["DtPayMode"] = dt;
            }
            else
            {
                dt = (DataTable)Session["DtPayMode"];
            }

            if (dt.Rows.Count > 0)
            {
                DdlPaymode.DataSource = dt;
                DdlPaymode.DataValueField = "PID";
                DdlPaymode.DataTextField = "Paymode";
                DdlPaymode.DataBind();
            }
        }
        catch (Exception ex)
        {
            Response.Write("Try later.");
        }
    }
    private void CheckEpin()
    {
        lblErrEpin.Text = "";
        errMsg.Text = "";

        txtPIN.Text = txtPIN.Text.Trim().Replace(";", "").Replace("'", "").Replace("=", "");
        txtScratch.Text = txtScratch.Text.Trim().Replace(";", "").Replace("'", "").Replace("=", "");

        if (!string.IsNullOrWhiteSpace(txtPIN.Text) && !string.IsNullOrWhiteSpace(txtScratch.Text))
        {
            // dbConnect.OpenConnection();
            int i = 0;
            char IsIssued;

            string sql = IsoStart +
                         "Select a.*, b.KitAmount from " + ObjDAL.dBName +
                         "..M_FormGeneration as a, " + ObjDAL.dBName +
                         "..M_KitMaster b where a.ProdId = b.KitID AND FormNo = " + txtPIN.Text.Trim() +
                         " And ScratchNo = '" + txtScratch.Text.Trim() + "' and IsCancel = 'N'" +
                         IsoEnd;

            SqlCommand cmd = new SqlCommand(sql, dbConnectSelect.cnnObject);
            SqlDataReader dRead = cmd.ExecuteReader();

            if (dRead.Read())
            {
                IsIssued = Convert.ToChar(dRead["IsIssued"]);
                Session["TmpKitAmt"] = dRead["KitAmount"];
                LblKItamount.Text = dRead["KitAmount"].ToString();
                Session["TmpKitID"] = dRead["ProdID"];

                if (IsIssued == 'Y')
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(),
                        "alert", "alert('Already Used, Kindly Check!!');", true);
                    txtScratch.Text = "";
                }
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(),
                    "alert", "alert('Invalid Epin & Scratch No.!!');", true);
                txtScratch.Text = "";
            }

            cmd.Cancel();
            dRead.Close();
        }
        else if (!string.IsNullOrWhiteSpace(txtPIN.Text))
        {
            string sql = IsoStart + "Select * from " + ObjDAL.dBName +
                         "..M_FormGeneration where FormNo = " + txtPIN.Text.Trim() + IsoEnd;

            SqlCommand cmd = new SqlCommand(sql, dbConnectSelect.cnnObject);
            SqlDataReader dRead = cmd.ExecuteReader();

            if (!dRead.Read())
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(),
                    "alert", "alert('Invalid Epin No.!!');", true);
            }

            cmd.Cancel();
            dRead.Close();
        }
        else if (!string.IsNullOrWhiteSpace(txtScratch.Text))
        {
            string sql = IsoStart + "Select * from " + ObjDAL.dBName +
                         "..M_FormGeneration where ScratchNo = '" + txtScratch.Text.Trim() + "'" + IsoEnd;

            SqlCommand cmd = new SqlCommand(sql, dbConnectSelect.cnnObject);
            SqlDataReader dRead = cmd.ExecuteReader();

            if (!dRead.Read())
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(),
                    "alert", "alert('Invalid Scratch No.!!');", true);
            }

            cmd.Cancel();
            dRead.Close();
        }

        //if (Convert.ToDecimal(LblKItamount.Text) == 0)
        //{
        //    divProduct.Visible = false;
        //}
        //else
        //{
        //    divProduct.Visible = false; // Same as VB version
        //}
    }
    private string ClearInject(string strObj)
    {
        strObj = strObj.Replace(";", "").Replace("'", "").Replace("=", "");
        return strObj.Trim();
    }
    private string GetIDno(string Mid)
    {
        string Result = "";
        try
        {
            DataTable dt = new DataTable();

            //string strSql = IsoStart + "Select IDNO from " + ObjDAL.dBName + " ..M_MemberMAster Where MID = '" + Mid + "' " + IsoEnd;
            string strSql = IsoStart + "Select IDNO from " + ObjDAL.dBName + "..M_MemberMAster Where MID = '" + Mid + "' " + IsoEnd;
            dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strSql).Tables[0];

            if ((dt.Rows.Count > 0))
                Result = dt.Rows[0]["IDNO"].ToString();
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
        return Result;
    }
    public string GenerateRandomStringJoining(int iLength)
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
    private void GetConfigDtl()
    {
        try
        {
            DataTable dt = new DataTable();
            DataSet ds = new DataSet();
            string strSql = IsoStart + "select *  from " + ObjDAL.dBName + "..M_ConfigMaster " + IsoEnd;

            if (Session["DtConfigDetail"] == null)
            {
                ds = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strSql);
                dt = ds.Tables[0];
                Session["DtConfigDetail"] = dt;
            }
            else
            {
                dt = (DataTable)Session["DtConfigDetail"];
            }

            if (dt.Rows.Count > 0)
            {
                Session["IsGetExtreme"] = dt.Rows[0]["IsGetExtreme"];
                Session["IsTopUp"] = dt.Rows[0]["IsTopUp"];
                Session["IsSendSMS"] = dt.Rows[0]["IsSendSMS"];
                Session["IdNoPrefix"] = dt.Rows[0]["IdNoPrefix"];
                Session["IsFreeJoin"] = dt.Rows[0]["IsFreeJoin"];
                Session["IsStartJoin"] = dt.Rows[0]["IsStartJoin"];
                Session["JoinStartFrm"] = dt.Rows[0]["JoinStartFrm"];
                Session["IsSubPlan"] = dt.Rows[0]["IsSubPlan"];
            }
            else
            {
                Session["IsGetExtreme"] = "N";
                Session["IsTopUp"] = "N";
                Session["IsSendSMS"] = "N";
                Session["IdNoPrefix"] = "";
                Session["IsFreeJoin"] = "N";
                Session["IsStartJoin"] = "N";
                Session["JoinStartFrm"] = "01-Sep-2011";
                Session["IsSubPlan"] = "N";
            }
        }
        catch
        {
            Session["CompName"] = "";
            Session["CompAdd"] = "";
            Session["CompWeb"] = "";
        }
    }
    protected void vsblCtrl(bool isVsbl, bool isOnlyDv)
    {
        try
        {
            if (!isOnlyDv)
            {
                txtUplinerId.Enabled = !isVsbl;
                txtRefralId.Enabled = !isVsbl;
            }
        }
        catch (Exception ex)
        {
            Response.Write("Try later.");
        }
    }
    public string GenerateRandomString(int iLength)
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
    private void ClrCtrl()
    {
        // txtAddLn2.Text = "";
        txtAddLn1.Text = "";
        txtEMailId.Text = "";
        txtFNm.Text = "";
        txtFrstNm.Text = "";
        txtMobileNo.Text = "";
        txtNominee.Text = "";
        txtPanNo.Text = "";
        txtPhNo.Text = "";
        txtPinCode.Text = "";
        txtRelation.Text = "";
        txtUplinerId.Text = "";
        lblUplnrNm.Text = "";
        ddlDistrict.Text = "";
        ddlTehsil.Text = "";
        TxtBranchName.Text = "";
        TxtAccountNo.Text = "";
        txtIfsCode.Text = "";
        // txtPIN.Text = "";
        // txtScratch.Text = "";
        txtRefralId.Text = "";
        lblRefralNm.Text = "";
        // dv_Main.Visible = false;
        txtUplinerId.Enabled = true;
        txtRefralId.Enabled = true;
        // txtPIN.Enabled = true;
        // txtScratch.Enabled = true;
        // cmdNext.Visible = true;

        RbtnLegNo.Enabled = true;
    }
    private void FillBankMaster()
    {
        try
        {
            DataTable dt = new DataTable();

            //if (Session["DtBankMaster"] == null)
            //{
            DataSet Ds = new DataSet();
            string strSql = IsoStart + "SELECT top 1 BankCode as Bid, BANKNAME as Bank FROM " + ObjDAL.dBName + "..M_BankMaster WHERE ACTIVESTATUS='Y' and Rowstatus='Y' ORDER BY BankName" + IsoEnd;
            Ds = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strSql);
            dt = Ds.Tables[0];
            Session["DtBankMaster"] = dt;
            //}
            //else
            //{
            //    dt = (DataTable)Session["DtBankMaster"];
            //}

            if (dt.Rows.Count > 0)
            {
                CmbBank.DataSource = dt;
                CmbBank.DataValueField = "Bid";
                CmbBank.DataTextField = "Bank";
                CmbBank.DataBind();
                CmbBank.SelectedIndex = 0;
            }

            TxtBank.Text = CmbBank.SelectedItem.Text;
        }
        catch (Exception ex)
        {
            Response.Write("Try later.");
        }
    }
    public string Validt_SpnsrDtl(string chkby)
    {
        string Validt_SpnsrDtl = "";
        try
        {
            Validt_SpnsrDtl = "";
            txtRefralId.Text = txtRefralId.Text.Trim().Replace("'", "").Replace("=", "").Replace(";", "");
            txtUplinerId.Text = txtUplinerId.Text.Trim().Replace("'", "").Replace("=", "").Replace(";", "");

            Session["Kitid"] = 1;
            Session["Bv"] = 0;
            Session["JoinStatus"] = "N";
            Session["RP"] = 0;

            Validt_SpnsrDtl = "OK";
            txtUplinerId.Text = "0";
            lblUplnrNm.Text = "";
            Session["Uplnr"] = 0;

            if (txtScratch.Text.Trim() != "")
            {
                string sql = IsoStart +
                    "Select KitM.kitid, KitM.PV, KitM.RP, KitM.KitName, JoinStatus " +
                    "From " + ObjDAL.dBName + "..m_formgeneration as Scrtch " +
                    "Inner Join " + ObjDAL.dBName + "..M_KitMaster as KitM On Scrtch.ProdId = KitM.KitId " +
                    "where Scrtch.IsIssued = 'N' and Scrtch.ActiveStatus = 'Y' and " +
                    "Scrtch.FormNo = '" + txtPIN.Text.Trim() + "' and " +
                    "Scrtch.ScratchNo = '" + txtScratch.Text.Trim() + "' and " +
                    "KitM.ActiveStatus = 'Y' and KitM.RowStatus = 'Y' and Scrtch.IsCancel = 'N' " +
                    IsoEnd;

                SqlCommand cmd = new SqlCommand(sql, dbConnectSelect.cnnObject);
                SqlDataReader dRead = cmd.ExecuteReader();

                if (!dRead.Read())
                {
                    Validt_SpnsrDtl = "";
                    string scrname = "<SCRIPT language='javascript'>alert('Invalid PIN No. or Scratch No.');</SCRIPT>";
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Login Error", scrname, false);
                    vsblCtrl(false, true);
                    txtPIN.Focus();
                    dRead.Close();
                    cmd.Cancel();
                    return ""; // Exit Function
                }

                Session["Bv"] = dRead["PV"];
                Session["RP"] = dRead["RP"];
                Session["Category"] = dRead["KitName"];
                Session["Kitid"] = dRead["Kitid"];
                Session["JoinStatus"] = dRead["JoinStatus"];
                Validt_SpnsrDtl = "OK";

                cmd.Cancel();
                dRead.Close();
            }
            else
            {
                string scrname = "<SCRIPT language='javascript'>alert('Check Scratch No');</SCRIPT>";
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Login Error", scrname, false);
                txtScratch.Focus();
                Validt_SpnsrDtl = "";
            }

            RbtnLegNo.Enabled = false;
            txtUplinerId.Enabled = false;
            txtRefralId.Enabled = false;
            txtPIN.Enabled = false;
            txtScratch.Enabled = false;

            // cmdNext.Visible = false;
            return Validt_SpnsrDtl;
        }
        catch (Exception ex)
        {
            return "";
        }
        //try
        //{
        //    string Validt_SpnsrDtl = "";

        //    if (Session["IsGetExtreme"].ToString() == "N")
        //    {
        //        if (string.IsNullOrEmpty(txtUplinerId.Text))
        //        {
        //            string scrname = "<SCRIPT language='javascript'>alert('Check Placement Id');</SCRIPT>";
        //            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Login Error", scrname, false);
        //            txtUplinerId.Focus();
        //            return "";
        //        }
        //    }

        //    txtRefralId.Text = txtRefralId.Text.Replace("'", "").Replace("=", "").Replace(";", "").Trim();
        //    txtUplinerId.Text = txtUplinerId.Text.Replace("'", "").Replace("=", "").Replace(";", "").Trim();

        //    if (!string.IsNullOrEmpty(txtRefralId.Text))
        //    {
        //        try
        //        {
        //            DataTable dt = new DataTable();
        //            DataSet Ds = new DataSet();
        //            string strSql = IsoStart + "Select FormNo, MemFirstName + ' ' + MemLastName as MemName, ActiveStatus from " + ObjDAL.dBName + "..M_MemberMaster where Idno = '" + txtRefralId.Text + "'" + IsoEnd;
        //            Ds = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strSql);
        //            dt = Ds.Tables[0];

        //            if (dt.Rows.Count == 0)
        //            {
        //                string scrname = "<SCRIPT language='javascript'>alert('Sponsor ID Not Exist.');</SCRIPT>";
        //                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Login Error", scrname, false);
        //                Validt_SpnsrDtl = "";
        //                vsblCtrl(false, true);
        //                return "";
        //            }
        //            else
        //            {
        //                Session["Kitid"] = 1;
        //                Session["Bv"] = 0;
        //                Session["JoinStatus"] = "N";
        //                Session["RP"] = 0;
        //                Validt_SpnsrDtl = "OK";
        //            }
        //            Session["Refral"] = dt.Rows[0]["FormNo"];
        //            lblRefralNm.Text = dt.Rows[0]["MemName"].ToString();
        //        }
        //        catch (Exception ex)
        //        {
        //            Response.Write("Please check sponsor ID.");
        //        }
        //    }
        //    else
        //    {
        //        string scrname = "<SCRIPT language='javascript'>alert('Check Sponsor ID.');</SCRIPT>";
        //        ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Login Error", scrname, false);
        //        txtRefralId.Focus();
        //        return "";
        //    }

        //    // Additional code for Upliner logic here...

        //    return Validt_SpnsrDtl;
        //}
        //catch (Exception ex)
        //{
        //    return "";
        //}
    }
    private void FindSession()
    {
        try
        {
            Session["SessID"] = 1;
            return;
        }
        catch (Exception ex)
        {
            Response.Write("Try later.");
        }

        try
        {
            DataTable dt = new DataTable();
            DataSet Ds = new DataSet();
            string strSql = ObjDAL.Isostart + "Select Max(SessId) as SessId from " + ObjDAL.dBName + "..M_SessnMaster  " + ObjDAL.IsoEnd;
            Dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strSql).Tables[0]; ;
            dt = Dt;
            if (dt.Rows.Count > 0)
            {
                Session["SessID"] = dt.Rows[0]["SessID"];
            }
            else
            {
                errMsg.Text = "Session Not Exist. Please Enter New Session.";
                return;
            }
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
    private bool checkAvailLeg()
    {
        try
        {
            int iLegNo = 0;
            int iformNo = 0;

            if (RbtnLegNo.SelectedIndex == 0)
            {
                iLegNo = 1;
            }
            else if (RbtnLegNo.SelectedIndex == 1)
            {
                iLegNo = 2;
            }
            else
            {
                string scrname = "<SCRIPT language='javascript'>alert('Choose Position.');</SCRIPT>";
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Login Error", scrname, false);
                return false;
            }

            DataTable dt = new DataTable();
            DataSet Ds = new DataSet();
            string strSql = IsoStart + "Select * from " + ObjDAL.dBName + "..M_MemberMaster where IdNo='" + txtUplinerId.Text + "'" + IsoEnd;
            Ds = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strSql);
            dt = Ds.Tables[0];

            if (dt.Rows.Count > 0)
            {
                iformNo = Convert.ToInt32(dt.Rows[0]["FormNo"]);
            }
            else
            {
                errMsg.Text = "Check Placeunder Id.";
                string scrname = "<SCRIPT language='javascript'>alert('" + errMsg.Text + "');</SCRIPT>";
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Login Error", scrname, false);
                return false;
            }

            DataTable dt12 = new DataTable();
            DataSet Ds12 = new DataSet();
            string strSql12 = IsoStart + "SELECT COUNT(*) AS CNT FROM " + ObjDAL.dBName + "..M_MemberMaster WHERE UpLnFormNo=" + iformNo + " And LegNo=" + iLegNo + IsoEnd;
            Ds12 = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strSql12);
            dt12 = Ds12.Tables[0];

            if (dt12.Rows.Count > 0 && Convert.ToInt32(dt12.Rows[0]["CNT"]) > 0)
            {
                errMsg.Text = (iLegNo == 1 ? "LEFT" : "RIGHT") + " Position already used, please select correct Position!";
                string scrname = "<SCRIPT language='javascript'>alert('" + errMsg.Text + "');</SCRIPT>";
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Login Error", scrname, false);
                return false;
            }
            else
            {
                _dblAvailLeg = iformNo;
                return true;
            }
        }
        catch (Exception ex)
        {
            Response.Write("Try later.");
            return false;
        }
    }
    protected void txtUplinerId_TextChanged(object sender, EventArgs e)
    {
        FillSponsor(ref cnn);
    }
    private void FillSponsor(ref SqlConnection Cnn)
    {
        try
        {
            errMsg.Text = "";
            lblErrEpin.Text = "";
            int i = 0;
            txtUplinerId.Text = txtUplinerId.Text.Trim().Replace(";", "").Replace("'", "").Replace("=", "");

            DataTable dt = new DataTable();
            DataSet Ds = new DataSet();
            string strSql = IsoStart + " Select FormNo,MemFirstName + ' ' + MemLastName as MemName from " + ObjDAL.dBName +
                            "..M_MemberMaster where IDNo='" + txtUplinerId.Text + "'" + IsoEnd;
            Ds = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strSql);
            dt = Ds.Tables[0];

            if (dt.Rows.Count > 0)
            {
                lblUplnrNm.Text = dt.Rows[0]["MemName"].ToString();
                Session["Uplnr"] = dt.Rows[0]["FormNo"].ToString();
                i += 1;
            }
            else
            {
                errMsg.Text = "Invalid PlaceUnder ID!!";
                lblErrEpin.Text = "Invalid PlaceUnder ID!!";
                string scrname = "<SCRIPT language='javascript'>alert('" + errMsg.Text + "');</SCRIPT>";
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Login Error", scrname, false);
            }

            if (i == 1)
            {
                checkAvailLeg();
            }
        }
        catch (Exception ex)
        {
            Response.Write("Try later.");
        }
    }
    private void FillReferral(SqlConnection Cnn)
    {
        try
        {
            lblErrEpin.Text = "";
            errMsg.Text = "";
            txtRefralId.Text = txtRefralId.Text.Trim().Replace(";", "").Replace("'", "").Replace("=", "");

            DataTable dt = new DataTable();
            DataSet Ds = new DataSet();
            string strSql = IsoStart + "Select FormNo,MemFirstName + ' ' + MemLastName as MemName,ActiveStatus from " +
                            ObjDAL.dBName + "..M_MemberMaster where IDNo='" + txtRefralId.Text + "' and IsBlock='N' " + IsoEnd;
            Ds = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strSql);
            dt = Ds.Tables[0];

            if (dt.Rows.Count == 0)
            {
                string scrname = "<SCRIPT language='javascript'>alert('Invalid Sponsor Id');</SCRIPT>";
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Login Error", scrname, false);
                txtRefralId.Text = "";
                lblRefralNm.Text = "";
                return;
            }
            //else if (dt.Rows[0]["ActiveStatus"].ToString() == "N")
            //{
            //    string scrname = "<SCRIPT language='javascript'>alert('This ID is not eligible for sponsor.');</SCRIPT>";
            //    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Login Error", scrname, false);
            //    return;
            //}
            else
            {
                lblRefralNm.Text = dt.Rows[0]["MemName"].ToString();
                Session["Refral"] = dt.Rows[0]["FormNo"].ToString();
            }
        }
        catch (Exception ex)
        {
            Response.Write("Try later.");
        }
    }
    protected void CmdCancel_Click(object sender, EventArgs e)
    {
        ClrCtrl();
    }
    protected void txtRefralId_TextChanged(object sender, EventArgs e)
    {
        try
        {
            FillReferral(cnn);
        }
        catch (Exception ex)
        {
            // Handle the exception if necessary
        }
    }
    protected void txtMobileNo_TextChanged(object sender, EventArgs e)
    {

    }
    protected void txtEMailId_TextChanged(object sender, EventArgs e)
    {

    }
    protected void ddlCountryNAme_SelectedIndexChanged(object sender, EventArgs e)
    {
        FillCountryMasterCode();
    }
    private void FillCountryMasterCode()
    {
        try
        {
            DataTable dt = new DataTable();
            string strQuery = IsoStart + "SELECT StdCode FROM " + ObjDAL.dBName + "..M_CountryMaster WHERE ACTIVESTATUS='Y' AND Cid = '" + ddlCountryNAme.SelectedValue + "' " + IsoEnd;
            dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strQuery).Tables[0];

            if (dt.Rows.Count > 0)
            {
                ddlMobileNAme.Text = dt.Rows[0]["StdCode"].ToString();
            }
        }
        catch (Exception ex)
        {
            // Handle the exception
        }
    }
    protected void CmdSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (!chkterms.Checked)
            {
                string scrname = "<SCRIPT language='javascript'>alert('Please select Terms and Conditions.!');</SCRIPT>";
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Login Error", scrname, false);
                return;
            }
            else
            {
                if (string.IsNullOrWhiteSpace(txtPIN.Text))
                {
                    string scrname = "<script language='javascript'>alert('Please Enter Epin No.');</script>";
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Login Error", scrname, false);
                    return;
                }

                if (string.IsNullOrWhiteSpace(txtScratch.Text))
                {
                    string scrname = "<script language='javascript'>alert('Please Enter Scratch No.');</script>";
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Login Error", scrname, false);
                    return;
                }

                if (string.IsNullOrWhiteSpace(txtRefralId.Text))
                {
                    string scrname = "<script language='javascript'>alert('Please Enter Sponsor ID');</script>";
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Login Error", scrname, false);
                    return;
                }

                if (string.IsNullOrWhiteSpace(txtFrstNm.Text))
                {
                    string scrname = "<script language='javascript'>alert('Please Enter Name.');</script>";
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Login Error", scrname, false);
                    return;
                }

                if (string.IsNullOrWhiteSpace(txtMobileNo.Text))
                {
                    string scrname = "<script language='javascript'>alert('Please Enter Mobile No.');</script>";
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Login Error", scrname, false);
                    return;
                }

                if (string.IsNullOrWhiteSpace(TxtAAdhar1.Text))
                {
                    string scrname = "<script language='javascript'>alert('Please Enter Aadhar No.');</script>";
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Login Error", scrname, false);
                    return;
                }
                SaveIntoDB();
            }
        }
        catch (Exception ex)
        {
            Response.Write("Try later.");
        }
    }
    public void SaveIntoDB()
    {
        try
        {


            int UpdateData = 0;
            if (UpdateData == 0)
            {
                string strQry = "";
                string strDOB, strDOM, strDOJ, s;
                int iLeg;
                char cGender, cMarried;
                cGender = 'M';
                cMarried = 'N';
                string HostIp = Context.Request.UserHostAddress; // or HttpContext.Current.Request.UserHostAddress
                int DistrictCode = 0, CityCode = 0, VillageCode = 0;
                CmdSave.Enabled = false;
                try
                {
                    if (Validt_SpnsrDtl("") == "OK")
                    {
                        iLeg = Convert.ToInt32(Session["iLeg"]);
                        if (RbtnLegNo.SelectedIndex == 0)
                        {
                            iLeg = 1;
                        }
                        else if (RbtnLegNo.SelectedIndex == 1)
                        {
                            iLeg = 2;
                        }
                        else
                        {
                            chkterms.Checked = false;
                            CmdSave.Enabled = true;
                            string scrname = "<SCRIPT language='javascript'>alert('Choose Position.');</SCRIPT>";
                            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Choose Position.');", true);
                            RbtnLegNo.Enabled = true;
                            return; // Exit Sub
                        }
                        TxtPasswd.Text = GenerateRandomString(6);
                        string s1 = "";

                        if (!string.IsNullOrEmpty(txtPanNo.Text))
                        {
                            s1 = IsoStart + "select Count(Panno) as PanNo from " + ObjDAL.dBName + "..M_Membermaster where Panno='" + txtPanNo.Text.Trim() + "'" + IsoEnd;
                            ObjDAL = new DAL();
                            DataTable Dt1 = new DataTable();
                            Dt1 = SqlHelper.ExecuteDataset(constr1, CommandType.Text, s1).Tables[0];
                            if (Convert.ToInt32(Dt1.Rows[0]["PanNo"]) > 1)
                            {
                                CmdSave.Enabled = true;
                                chkterms.Checked = false;
                                string scrname = "<SCRIPT language='javascript'>alert('Maximum Numbers of IDs Reached');</SCRIPT>";
                                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Login Error", scrname, false);
                                return;
                            }
                        }
                        string q = "";
                        int i = 0;
                        DataTable Dt;

                        int BankCode = 0;

                        double dblBank = Convert.ToDouble(CmbBank.SelectedValue);
                        dblBank = 0;

                        int AreaCode = 0;
                        AreaCode = 0;

                        string RegestType = "IN";
                        int PostalAreaCode = 0;

                        strDOB = ddlDOBdt.Text + "-" + ddlDOBmnth.Text + "-" + ddlDOBYr.Text;
                        strDOM = DDlMDay.Text + "-" + DDLMMonth.Text + "-" + DDLMYear.Text;
                        strDOJ = dbConnect.Get_ServerDate().ToString("dd-MMM-yyyy");
                        string dblDistrict = "0";
                        string dblTehsil = "0";

                        if (dblDistrict == null)
                        {
                            dblDistrict = "";
                        }

                        if (dvpin.Visible == true)
                        {
                            if (dblDistrict == null)
                            {
                                dblDistrict = "";
                            }

                            dblState = 0;
                            // Optional: Uncomment these if hidden codes are used
                            // if (Convert.ToInt32(HDistrictCode.Value) == 0)
                            //     DistrictCode = 0;
                            // else
                            //     DistrictCode = Convert.ToInt32(HDistrictCode.Value);

                            // if (Convert.ToInt32(HCityCode.Value) == 0)
                            //     CityCode = 0;
                            // else
                            //     CityCode = Convert.ToInt32(HCityCode.Value);

                            // if (Convert.ToInt32(DDlVillage.SelectedValue) == 0)
                            //     VillageCode = 0;
                            // else
                            //     VillageCode = Convert.ToInt32(DDlVillage.SelectedValue);
                        }
                        else
                        {
                            dblDistrict = "";
                            dblState = 0;
                            DistrictCode = 0;
                            CityCode = 0;
                            VillageCode = 0;
                        }

                        string IfSC = ClearInject(txtIfsCode.Text.ToUpper());
                        double dblPlan = 0;
                        int InVoiceNo = 0;

                        if (Convert.ToInt32(Session["SessID"]) == 0)
                        {
                            FindSession();
                        }

                        string Name = ClearInject(txtFrstNm.Text.ToUpper());
                        string fathername = ClearInject(txtFNm.Text.ToUpper());

                        //if (Convert.ToDouble(LblKItamount.Text) > 0)
                        //{
                        //    if (DDlDeliveryCenter.SelectedValue == "0")
                        //    {
                        //        chkterms.Checked = false;
                        //        CmdSave.Enabled = true;
                        //        string scrname = "<SCRIPT language='javascript'>alert('Choose Delivery Center.');</SCRIPT>";
                        //        ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Choose Delivery Center.');", true);
                        //        return;
                        //    }
                        //}
                        int UpdateData1 = 0;

                        if (UpdateData1 == 0)
                        {
                            strQry = "INSERT INTO m_memberMaster (" +
    "SessId,IdNo,CardNo,FormNo,KitId," +
    "UpLnFormNo,RefId,LegNo,RefLegNo,RefFormNo," +
    "MemFirstName,MemLastName,MemRelation,MemFName,MemDOB,MemGender,MemOccupation," +
    "NomineeName,Address1,Address2,Post," +
    "Tehsil,City,CityCode,District,DistrictCode,StateCode,CountryId,AreaCode," +
    "PinCode,PhN1,Fax,Mobl,MarrgDate," +
    "Passw,Doj,Relation,PanNo," +
    "BankID,MICRCode,BranchName,EMail,BV," +
    "UpGrdSessId,E_MainPassw,EPassw,ActiveStatus,billNo,RP,HostIp," +
    "PID,Paymode,ChDDNo,ChDDBankID,ChDDBank,ChddDate,ChDDBranch,IsPanCard,AadharNo,AadharNo2,AAdharNo3) " +
"VALUES (" +
    Session["SessID"] + ",0," + txtPIN.Text.Trim() + ",0," + Session["Kitid"] + "," +
    Session["Uplnr"] + ",0," + iLeg + ",0," + Session["Refral"] + "," +
    "'" + ClearInject(txtFrstNm.Text.ToUpper()) + "',''," +
    "'" + CmbType.SelectedValue + "','" + ClearInject(txtFNm.Text.ToUpper()) + "','" + strDOB + "','" + cGender + "',''," +
    "'" + ClearInject(txtNominee.Text.ToUpper()) + "','" + ClearInject(txtAddLn1.Text.ToUpper()) + "','',''," +
    dblTehsil + "," + dblTehsil + "," + CityCode + "," +
    dblDistrict + "," + DistrictCode + "," + dblState + ",1," + VillageCode + "," +
    "'" + txtPinCode.Text.Trim() + "','" + txtPhNo.Text.Trim() + "','CHOOSE ACCOUNT TYPE','" + txtMobileNo.Text.Trim() + "','" + strDOM + "'," +
    "'" + ClearInject(TxtPasswd.Text) + "',GETDATE(),'" + ClearInject(txtRelation.Text.ToUpper()) + "','" + ClearInject(txtPanNo.Text.ToUpper()) + "'," +
    dblBank + ",'" + TxtMICR.Text.Trim().ToUpper() + "','" + TxtBranchName.Text.Trim().ToUpper() + "','" + ClearInject(txtEMailId.Text) + "'," +
    Session["Bv"] + ",0,'" + ClearInject(TxtPasswd.Text) + "','" + ClearInject(TxtPasswd.Text) + "'," +
    "CASE WHEN " + LblKItamount.Text + "=0 THEN 'N' ELSE '" + Session["JoinStatus"] + "' END," +
    "'" + InVoiceNo + "','" + Session["RP"] + "','" + HostIp + "'," +
    DdlPaymode.SelectedValue + ",'" + DdlPaymode.SelectedItem.Text.Trim().ToUpper() + "','" + ClearInject(TxtDDNo.Text) + "'," +
    "'0','" + ClearInject(TxtIssueBank.Text.ToUpper()) + "','" + TxtDDDate.Text.Trim() + "','" + ClearInject(TxtIssueBranch.Text) + "','N','" +
    ClearInject(TxtAAdhar1.Text) + "','0','0'" +
")";
                            string Ks = " Begin Try Begin Transaction " + strQry + " Commit Transaction  End Try   BEGIN CATCH       ROLLBACK Transaction END CATCH      ";
                            int isOk = 0;
                            int retryqry = 0;
                        Savedata:
                            ;
                            isOk = Convert.ToInt32(SqlHelper.ExecuteNonQuery(constr, CommandType.Text, Ks));
                            LastInsertID = "0";
                            if ((isOk > 0))
                            {
                                string membername = "";
                                string Email = "";
                                string Password = "";

                                string sql = IsoStart +
                                    "SELECT TOP 1 a.IDNO, a.formno, b.IsBill, a.Passw, a.MemFirstname, a.MemlastName, a.Email, a.Epassw " +
                                    "FROM " + ObjDAL.dBName + "..m_MemberMaster AS a, " +
                                    ObjDAL.dBName + "..m_KitMaster AS b " +
                                    "WHERE a.kitid = b.kitid AND Cardno = '" + txtPIN.Text.Trim() + "' " +
                                    "ORDER BY mid DESC " +
                                    IsoEnd;

                                SqlCommand cmd = new SqlCommand(sql, dbConnectSelect.cnnObject);
                                SqlDataReader dRead = cmd.ExecuteReader();

                                if (dRead.Read())
                                {
                                    membername = dRead["MemFirstname"].ToString() + " " + dRead["MemLastName"].ToString();
                                    Email = dRead["Email"].ToString();
                                    LastInsertID = dRead["IDNO"].ToString();

                                    Session["nformno"] = dRead["Formno"];
                                    Password = dRead["Passw"].ToString();
                                    Session["Kit"] = dRead["IsBill"];
                                    Session["SMSIDNo"] = dRead["IDNo"];
                                    Session["SMSIDPass"] = dRead["Passw"];
                                    Session["Name"] = dRead["MemFirstname"];
                                    // Session["MaxDate"] = dRead["MaxDate"];
                                    Session["SMSTransPassw"] = dRead["EPassw"];

                                    // order(); // Uncomment if needed
                                }
                                else
                                {
                                    LastInsertID = "10001";
                                }

                                dRead.Close();
                                cmd.Cancel();

                                if (Session["IsSendSMS"] != null && Session["IsSendSMS"].ToString() == "Y")
                                {
                                    sendSMS();
                                }

                                CmdSave.Enabled = true;

                                // SendToMemberMail(LastInsertID, Email, membername, Password);

                                Session["LASTID"] = LastInsertID;
                                Session["Join"] = "YES";
                                Response.Redirect("Welcome.Aspx?IDNo=" + LastInsertID, false);
                                //string membername = "";
                                //string SPONSORID1 = "";
                                //string SPONSORnAME = "";
                                //string Doj = "";
                                //string kitamount = "";
                                //string Email = "";
                                //string Password = "";
                                //DataTable Dtsms = new DataTable();
                                //string strSql = string.Empty;
                                //// Execute stored procedure to get login details
                                ////strSql = IsoStart + " EXEC Sp_GetLoginDetail '" + Txtusername.Text.ToString().Replace(";", "").Replace("'", "").Replace("=", "").Replace(" ", "") + "'" + IsoEnd;
                                //strSql = IsoStart + " EXEC Sp_GetProfile " + IsoEnd;
                                //Dtsms = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strSql).Tables[0];
                                //if (Dtsms.Rows.Count > 0)
                                //{
                                //    membername = Dtsms.Rows[0]["MemfirstName"].ToString() + " " + Dtsms.Rows[0]["MemLastName"].ToString();
                                //    //SPONSORID1 = Dtsms.Rows[0]["SPONSORID"].ToString();
                                //    //SPONSORnAME = Dtsms.Rows[0]["SPONSORnAME"].ToString();
                                //    //Doj = Dtsms.Rows[0]["JoiningDate"].ToString();
                                //    //kitamount = Dtsms.Rows[0]["kitamount"].ToString();
                                //    Email = Dtsms.Rows[0]["Email"].ToString();
                                //    LastInsertID = Dtsms.Rows[0]["IDNO"].ToString();
                                //    Password = Dtsms.Rows[0]["Passw"].ToString();
                                //    Session["Kit"] = Dtsms.Rows[0]["IsBill"];

                                //    //FUND_LOGIN_CHECK(Dtsms.Rows[0]["IDNO"].ToString(), Dtsms.Rows[0]["Passw"].ToString(), Dtsms.Rows[0]["formno"].ToString());
                                //}
                                //else
                                //{
                                //    LastInsertID = "10001";
                                //}
                                //CmdSave.Enabled = true;
                                ////SendToMemberMail(LastInsertID, Email, membername, Password);
                                //Session["LASTID"] = LastInsertID;
                                //Session["Join"] = "YES";
                                //Response.Redirect("Welcome.Aspx?IDNo=" + LastInsertID, false);
                            }
                            else
                            {
                                if (retryqry <= 2)
                                {
                                    retryqry += 1;
                                    goto Savedata;
                                }
                                CmdSave.Enabled = true;
                                chkterms.Checked = false;
                                scrname = "<SCRIPT language='javascript'>alert('Try Again Later.');" + "</SCRIPT>";
                                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Try Again Later.');", true);
                            }
                        }

                    }
                }
                catch (Exception e)
                {
                    CmdSave.Enabled = true;
                    chkterms.Checked = false;
                    string scrname = "<SCRIPT language='javascript'>alert('" + e.Message + "');</SCRIPT>";
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "alert", "alert('" + e.Message + "');", true);

                    string path = HttpContext.Current.Request.Url.AbsoluteUri;
                    string text = path + ": " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff") + Environment.NewLine;
                    ObjDAL.WriteToFile(text + e.Message);
                    Response.Write("Try later.");
                    return;
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Key", "alert('This id already register.!');location.replace('Registration.aspx');", true);
                return;
            }
        }
        catch (Exception ex)
        {
            dbConnect.closeConnection();
            dbConnectSelect.closeConnection();
        }
    }
    private void sendSMS()
    {
        try
        {
            string MemberPass = "";
            string MemberTransPassw = "";

            MemberPass = Session["SMSIDPass"].ToString();
            MemberTransPassw = Session["SMSTransPassw"].ToString();

            // Encode special characters
            MemberPass = MemberPass.Replace("%", "%25")
                                   .Replace("&", "%26")
                                   .Replace("#", "%23")
                                   .Replace("'", "%22")
                                   .Replace(",", "%2C")
                                   .Replace("(", "%28")
                                   .Replace(")", "%29")
                                   .Replace("*", "%2A")
                                   .Replace("!", "%21")
                                   .Replace("/", "%2F")
                                   .Replace("@", "%40");

            MemberTransPassw = MemberTransPassw.Replace("%", "%25")
                                               .Replace("&", "%26")
                                               .Replace("#", "%23")
                                               .Replace("'", "%22")
                                               .Replace(",", "%2C")
                                               .Replace("(", "%28")
                                               .Replace(")", "%29")
                                               .Replace("*", "%2A")
                                               .Replace("!", "%21")
                                               .Replace("/", "%2F")
                                               .Replace("@", "%40");

            if (txtMobileNo.Text.Length >= 10)
            {
                using (WebClient client = new WebClient())
                {
                    string baseurl;
                    Stream data;
                    string sms = "Welcome To " + Session["CompName"] +
                                 ", Thank You For Registration. Your ID Is " + Session["SMSIDNo"] +
                                 " and Password is " + Session["SMSIDPass"] +
                                 ". Visit " + Session["CompWeb1"] + "  Best of luck.";

                    try
                    {
                        baseurl = "http://78.46.58.54/vb/apikey.php?apikey=baeVEum0EOQkbng7&senderid=OVRNET&templateid=1707160354001194457&number=" + txtMobileNo.Text + "&message=" + sms + ""; // TODO: Replace with actual SMS API URL
                        data = client.OpenRead(baseurl);
                        using (StreamReader reader = new StreamReader(data))
                        {
                            string s = reader.ReadToEnd();
                        }
                        data.Close();
                    }
                    catch (Exception)
                    {
                        // Ignore SMS send errors silently as in original VB code
                    }
                }
            }

            ClrCtrl();
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff") + Environment.NewLine;
            ObjDAL.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }
    }
    public bool SendToMemberMail(string IdNo, string Email, string MemberName, string Password)
    {
        try
        {
            string StrMsg = "";
            System.Net.Mail.MailAddress SendFrom = new System.Net.Mail.MailAddress(Session["CompMail"].ToString());
            System.Net.Mail.MailAddress SendTo = new System.Net.Mail.MailAddress(Email);
            System.Net.Mail.MailMessage MyMessage = new System.Net.Mail.MailMessage(SendFrom, SendTo);
            StrMsg = "<table style=\"margin:0; padding:10px; font-size:12px; font-family:Verdana, Arial, Helvetica, sans-serif; line-height:23px; text-align:justify;width:100%\">" +
                     "<tr>" +
                     "<td>" +
                     "<span style=\"color: #0099CC; font-weight: bold;\"><h2>Dear " + MemberName + ",</h2></span><br />" +
                     " It is with great pleasure that we extend our warmest welcome to you as a new member of the <br />" +
                     " " + Session["CompName"] + " family! Congratulations on embarking upon an exciting journey into the world of " + Session["CompName"] + ". <br />" +
                     "<br />" +
                     "<span style=\"color: #0099FF; font-weight: bold;\">Warm regards,</span><br />" +
                     " Team " + Session["CompName"] + " <br />" +
                     "<br />" +
                     "<span style=\"color: #0099FF; font-weight: bold;\">Registration Information</span><br />" +
                     "<strong>Login ID: " + IdNo + "</strong><br />" +
                     "<strong>Password: " + Password + "</strong><br />" +
                     "You may login to the Member Center at: <a href=\"" + Session["CompWeb"] + "\" target=\"_blank\" style=\"color:#0000FF; text-decoration:underline;\">" + Session["CompWeb"] + "</a><br />" +
                     "<br />" +
                     "<br />" +
                     "</td>" +
                     "</tr>" +
                     "</table>";

            MyMessage.Subject = "Warm Welcome to " + Session["CompName"] + ".!";
            MyMessage.Body = StrMsg;
            MyMessage.IsBodyHtml = true;
            System.Net.Mail.SmtpClient smtp = new System.Net.Mail.SmtpClient("smtp.gmail.com");
            smtp.Port = 587;
            smtp.EnableSsl = true;
            smtp.UseDefaultCredentials = false;
            smtp.Credentials = new System.Net.NetworkCredential(Session["CompMail"].ToString(), Session["MailPass"].ToString());
            smtp.Send(MyMessage);
            return true;
        }
        catch (Exception ex)
        {
            Response.Write("Try later.");
            return false;
        }
    }
    protected void btngenerate_Click(object sender, EventArgs e)
    {

    }
    protected void Txtusername_TextChanged(object sender, EventArgs e)
    {

    }
    protected void TxtWalletaddress_TextChanged(object sender, EventArgs e)
    {

    }
    protected void ddlStatename_TextChanged(object sender, EventArgs e)
    {
        //Fill_State();

        DataTable dtMaster = new DataTable();
        string strQuery = ObjDAL.Isostart + "Select StateCode,StateName from " + ObjDAL.dBName + "..M_StateDivMaster Where ActiveStatus = 'Y' And RowStatus =  'Y' and Statename='" + ddlStatename.SelectedItem.Text + "' " + ObjDAL.IsoEnd;
        dtMaster = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strQuery).Tables[0];

        ddlStatename.DataSource = dtMaster;
        ddlStatename.DataValueField = "STATECODE";
        ddlStatename.DataTextField = "StateName";
        ddlStatename.DataBind();
        ddlStatename.SelectedIndex = 0;
    }
    protected void txtScratch_TextChanged(object sender, EventArgs e)
    {
        CheckEpin();
    }
}
