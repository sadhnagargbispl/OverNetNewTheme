using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Security;
using System.Text;
using System.Threading.Tasks;
using Microsoft.VisualBasic;
using System.Data.SqlClient;
using System.Data;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Threading;
using System.Drawing;
using System.Drawing.Drawing2D;
using Irony;
using System.Configuration;
using System.Activities.Statements;

partial class WalletRequest : System.Web.UI.Page
{
    // Dim conn As SqlConnection
    // Dim Comm As SqlCommand
    DAL objDal = new DAL();
    private SqlDataReader ds;
    private SqlDataReader ds1;
    private SqlConnection Conn;
    private SqlCommand Comm;
    private SqlCommand cmd = new SqlCommand();
    private SqlDataReader dRead;
    private cls_DataAccess dbConnect;
    private int TransferId;
    private DataTable tmpTable = new DataTable();
    private DataTable dt1;
    private DataTable dt2;
    private string strQuery = "";
    private SqlDataAdapter Ad;
    private string scrname;
    // Dim CurrDiv As New System.Web.UI.HtmlControls.HtmlGenericControl
    private DAL obj = new DAL();
    private string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;

    protected void Page_Load(object sender, System.EventArgs e)
    {
        MasterPage Mst = new MasterPage();
        try
        {

            // dbConnect = New cls_DataAccess(Application("Connect"))
            // dbConnect.OpenConnection()
            // Conn = New SqlConnection(Application("Connect"))
            // Conn.Open()
            // CurrDiv = Master.FindControl("feedbackpop")

            if (Page.IsPostBack == false)
            {
                 if (Session["Status"] == null)
                {

                    Response.Redirect("Logout.aspx");
                    Response.End();
                }
                else if (Session["Status"].ToString() == "OK")
                {
                    if (Page.IsPostBack == false)
                    {
                        HdnCheckTrnns.Value = GenerateRandomStringActive(6);
                        //if ((GetReqStatus() == false))
                        //{
                        //    // Your request already pending please contact to admin !
                        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "Key", "alert('Request already Pending.!!');location.replace('Index.aspx');", true);
                        //    return;
                        //}
                        FillPaymode();
                        CheckVisible();
                        //CalendarExtender1.StartDate = DateTime.Now.AddDays(-7);
                    }
                }
                else if (Request["key"] != null)
                {
                    string Formno = Base64Decode(Request["key"]);
                    enterHomePg(Formno);
                }
                else
                {
                    Response.Redirect("Logout.aspx");
                    Response.End();
                }
            }
        }
        catch (Exception ex)
        {
            //string path = HttpContext.Current.Request.Url.AbsoluteUri;
            //string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff") + Environment.NewLine;
            //objDal.WriteToFile(text + ex.Message);
            //Response.Write("Try later.");
            //Response.Write(ex.Message);
            //Response.End();
            Response.Redirect("Logout.aspx");
            Response.End();
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
    private bool GetReqStatus()
    {
        bool result = false;
        try
        {


            DataTable dt = new DataTable();
            DataSet Ds = new DataSet();
            string strSql = " exec SP_GetReqidStatus '" + Session["FormNo"] + "' ";
            Ds = SqlHelper.ExecuteDataset(constr, CommandType.Text, strSql);
            dt = Ds.Tables[0];
            if ((Convert.ToInt32(dt.Rows[0]["Cnt"]) == 0))
                result = true;
            else
                result = false;
            return result;
        }
        catch (Exception ex)
        {
        }
        return result;
    }
    private void enterHomePg(string uid)
    {
        try
        {
            if ((uid.Length) > 0)
            {
                string scrname;
                // Dim prms As SqlParameter() = New SqlParameter(1) {}
                // prms(0) = New SqlParameter("@UserID", uid)
                // prms(1) = New SqlParameter("@Password", Pwd)
                // dr = SqlHelper.ExecuteReader(constr, "sp_Login", prms)
                // 'Cmm = New SqlCommand("Select a.*,b.KitName from m_MemberMaster as a,m_KitMaster as b where a.kitid=b.kitid and Idno='" & uid & "' and passw='" & Pwd & "' and a.IsBlock='N'  ", conn)
                // 'dr = Cmm.ExecuteReader



                DataTable dt = new DataTable();
                DataSet Ds = new DataSet();
                string strSql = objDal.Isostart + " Exec [sp_LoginDirect] '" + uid + "'" + objDal.IsoEnd;
                Ds = SqlHelper.ExecuteDataset(ConfigurationManager.ConnectionStrings["constr1"].ConnectionString, CommandType.Text, strSql);
                dt = Ds.Tables[0];
                // 'dt = ObjDAL.GetData(strSql)
                if ((dt.Rows.Count == 0))
                {
                    scrname = "<script language='javascript'>alert('Please Enter valid UserName or Password.');</script>";
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Login Error", scrname, false);
                }
                else
                {
                    Session["Run"] = 0;
                    Session["Status"] = "OK";
                    Session["IDNo"] = dt.Rows[0]["IDNo"];
                    Session["FormNo"] = dt.Rows[0]["Formno"];
                    Session["MemName"] = dt.Rows[0]["MemFirstName"] + " " + dt.Rows[0]["MemLastName"];
                    Session["MobileNo"] = dt.Rows[0]["Mobl"];
                    Session["MemKit"] = dt.Rows[0]["KitID"];
                    Session["Package"] = dt.Rows[0]["KitName"];
                    Session["Position"] = dt.Rows[0]["fld3"];
                    Session["Doj"] = ((DateTime)dt.Rows[0]["Doj"]).ToString("dd-MMM-yyyy");
                    Session["DOA"] = ((DateTime)dt.Rows[0]["Upgradedate"]).ToString("dd-MMM-yyyy");
                    Session["Address"] = dt.Rows[0]["Address1"];
                    Session["IsFranchise"] = dt.Rows[0]["Fld5"];
                    Session["ActiveStatus"] = dt.Rows[0]["ActiveStatus"];
                    Session["MemPassw"] = dt.Rows[0]["Passw"];
                    Session["MFormno"] = dt.Rows[0]["MFormNo"];
                    Session["MemUpliner"] = dt.Rows[0]["UplnFormno"];
                    Session["MID"] = dt.Rows[0]["MID"];
                    Session["EMail"] = dt.Rows[0]["Email"];
                    Session["profilepic"] = dt.Rows[0]["profilepic"];
                    Session["Panno"] = dt.Rows[0]["Panno"];
                    Session["ActivationDate"] = dt.Rows[0]["ActivationDate"];
                    Session["MemEPassw"] = dt.Rows[0]["Epassw"];
                }
            }
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
    }
    private string Base64Decode(string base64EncodedData)
    {
        var base64EncodedBytes = System.Convert.FromBase64String(base64EncodedData);
        return System.Text.Encoding.UTF8.GetString(base64EncodedBytes);
    }

    private void FillPaymode()
    {
        try
        {
            strQuery = "SELECT * FROM M_PayModeMaster WHERE ActiveStatus='Y'   order by Pid";

            tmpTable = new DataTable();
            tmpTable = obj.GetData(strQuery);
            {
                var withBlock = DdlPaymode;
                withBlock.DataSource = tmpTable;
                withBlock.DataValueField = "PID";
                withBlock.DataTextField = "Paymode";
                withBlock.DataBind();
            }
            Session["PaymodeDetail"] = tmpTable;
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff") + Environment.NewLine;
            objDal.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
            Response.Write(ex.Message);
            Response.End();
        }
    }
    private void FillBankMaster(string condition)
    {
        try
        {
            strQuery = "SELECT BankCode,BankName FROM M_BankMaster WHERE ActiveStatus='Y' and RowStatus='Y' " + condition + " Order by BankCode";

            tmpTable = new DataTable();
            tmpTable = obj.GetData(strQuery);
            {
                var withBlock = DDlBank;
                withBlock.DataSource = tmpTable;
                withBlock.DataValueField = "BankCode";
                withBlock.DataTextField = "BankName";
                withBlock.DataBind();
            }
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff") + Environment.NewLine;
            objDal.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
            Response.Write(ex.Message);
            Response.End();
        }
    }


    protected void SaveRequest()
    {
        try
        {
            if (TxtDDDate.Text == "")
            {
                scrname = "<SCRIPT language='javascript'>alert('Please select Date');" + "</SCRIPT>";
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Close", scrname, false);
                return;
            }

            string StrSql = "Insert into Trnreqwallet (Transid,Rectimestamp) values(" + HdnCheckTrnns.Value + ",getdate())";
            int updateeffect = objDal.SaveData(StrSql);
            if (updateeffect > 0)
            {
           


            //if ((GetReqStatus() == false))
            //{
            //    // Your request already pending please contact to admin !
            //    ScriptManager.RegisterStartupScript(this, this.GetType(), "Key", "alert('Request already Pending.!!');location.replace('Index.aspx');", true);
            //    return;
            //}
            string flnm1 = "";

            TxtDDNo.Text = ClearInject(TxtDDNo.Text);
            TxtDDDate.Text = ClearInject(TxtDDDate.Text);
               
            TxtIssueBranch.Text = ClearInject(TxtIssueBranch.Text);
            TxtRemarks.Text = ClearInject(TxtRemarks.Text);
            var query = "";
            string FlNm = "";

            DateTime ChqDate;
            string chqdates = "";
            try
            {
                ChqDate = Convert.ToDateTime(TxtDDDate.Text);
            }
            catch (Exception ex)
            {
                ChqDate = Convert.ToDateTime(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff"));
            }
            if (divDDDate.Visible == true)
            {
                //ChqDate = Request.Form(TxtDDDate.UniqueID);
                //chqdates = Request.Form(TxtDDDate.UniqueID);
                ChqDate = Convert.ToDateTime(TxtDDDate.Text);
                chqdates = TxtDDDate.Text;
            }
            else
            {
                ChqDate = Convert.ToDateTime(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff"));
                chqdates = DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff");
            }

            bool flag;
            if ((DdlPaymode.SelectedValue) == "1")
                flag = true;
            else if (divDDno.Visible == true & TxtDDNo.Text == "")
            {
                scrname = "<SCRIPT language='javascript'>alert('" + LblDDNo.Text + " can not be blank');" + "</SCRIPT>";
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Close", scrname, false);
                return;
            }
            else if (CheckDDno() == true)
                flag = true;
            else
                flag = false;



            string strextension = "";
            try
            {
                if (flag == true)
                {
                    if (divImage.Visible)
                    {
                        if (FlDoc.HasFile)
                        {
                            string filename = Path.GetFileName(FlDoc.PostedFile.FileName);
                            //string strname = Format(Now, Format(Now, "yyMMddhhmmssfff")) + "_1" + System.IO.Path.GetExtension(FlDoc.FileName);
                            string strname = DateTime.Now.ToString("yyMMddhhmmssfff") + "_1" + System.IO.Path.GetExtension(FlDoc.FileName);
                            string targetPath = Server.MapPath("Images/UploadImage/" + strname);
                            Stream strm = FlDoc.PostedFile.InputStream;
                            var targetFile = targetPath;
                            GenerateThumbnails(0.5, strm, targetFile);
                            FlNm = strname;
                        }
                        else if (DdlPaymode.SelectedValue == "1")
                        {
                        }
                        else
                        {
                            scrname = "<SCRIPT language='javascript'>alert('Select Choose File');" + "</SCRIPT>";
                            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Close", scrname, false);
                            return;
                        }
                    }

                    string str = "INSERT INTO WalletReq(ReqNo,ReqDate,Formno,PID,Paymode,Amount,ChqNo,ChqDate,BankName,BranchName," +
                        "ScannedFile,Remarks,BankId,Transno,WalletAddress) " +
                        " " + "Select ISNULL(Max(ReqNo)+1,'1001'),'" + DateTime.Now.ToString("dd-MMM-yyyy").ToString() + "'," +
                        "'" + Session["Formno"].ToString() + "','" + DdlPaymode.SelectedValue + "','" + DdlPaymode.SelectedItem.Text + "','" + TxtAmount.Text + "'," +
                        "'" + TxtDDNo.Text + "','" + DateTime.Now.ToString("dd-MMM-yyyy").ToString() + "','"+ DDlBank.SelectedItem.Text +"','" + TxtIssueBranch.Text + "','" + FlNm + "','" + TxtRemarks.Text + "'," +
                        "'"+ DDlBank.SelectedValue +"','"+ TxtIssueBranch.Text +"','" + Txtwalletad.Text + "' FROM WalletReq " + "; "+
                    "Insert into UserHistory(UserId,UserName,PageName,Activity,ModifiedFlds,RecTimeStamp,MemberId) " +
                    " Values" + "('" + Session["FormNo"] + "','" + Session["MemName"] + "','Payment Request','Payment Request', " +
                    "'Amount: " + TxtAmount.Text + "',Getdate()," + Session["FormNo"] + ")";





                    // Comm = New SqlCommand(str)
                    // Comm.Connection = Conn
                    int i = obj.SaveData(str);
                    int ReqNo;
                    str = " Select Max(ReqNo) as ReqNo FROM WalletReq WHERE Formno='" + Session["Formno"] + "' AND Amount='" + TxtAmount.Text + "'";
                    dt1 = new DataTable();
                    dt1 = obj.GetData(str);
                    if (dt1.Rows.Count > 0)
                    {
                        ReqNo = Convert.ToInt32(dt1.Rows[0]["ReqNo"].ToString());
                        // If DdlPaymode.SelectedValue = "8" Then
                        // Dim encs As String = Base64Encode(ReqNo & "/USDT")
                        // Response.Redirect("https://pay.regaltrades.com/CoinPurchase.aspx?wallet=" & encs)

                        // End If
                        scrname = @"<SCRIPT language='javascript'>alert('Payment Request Sent Successfully.\nYour Request no. is " + ReqNo + "');" + "</SCRIPT>";
                        ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Close", scrname, false);
                        TxtAmount.Text = ""; TxtDDDate.Text = ""; TxtDDNo.Text = ""; TxtIssueBranch.Text = ""; TxtRemarks.Text = ""; Txtwalletad.Text = "";
                        FillPaymode();
                        CheckVisible();
                    }
                    else
                    {
                        scrname = "<SCRIPT language='javascript'>alert('Payment Request Sent UnSuccessfully.');" + "</SCRIPT>";
                        ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Close", scrname, false);
                        return;
                    }
                }
            }
            catch (Exception ex)
            {
                string path = HttpContext.Current.Request.Url.AbsoluteUri;
                string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff") + Environment.NewLine;
                objDal.WriteToFile(text + ex.Message);
                Response.Write("Try later.");
                Response.Write(ex.Message);
                Response.End();
            }
            }
            else
            {
                //string scrName = "<SCRIPT language='javascript'>location.replace('Index.aspx');</SCRIPT>";
                //ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Upgraded", scrName, false);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Key", "location.replace('walletRequest.aspx');", true);
                return;
            }
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff") + Environment.NewLine;
            objDal.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
            Response.Write(ex.Message);
            Response.End();
        }
    }
    public static string Base64Encode(string plainText)
    {
        var plainTextBytes = System.Text.Encoding.UTF8.GetBytes(plainText);
        return System.Convert.ToBase64String(plainTextBytes);
    }

    private void GenerateThumbnails(double scaleFactor, Stream sourcePath, string targetPath)
    {
        using (var image = System.Drawing.Image.FromStream(sourcePath))
        {
            var newWidth = System.Convert.ToInt32((image.Width * scaleFactor));
            var newHeight = System.Convert.ToInt32((image.Height * scaleFactor));
            var thumbnailImg = new Bitmap(newWidth, newHeight);
            var thumbGraph = Graphics.FromImage(thumbnailImg);
            thumbGraph.CompositingQuality = CompositingQuality.HighQuality;
            thumbGraph.SmoothingMode = SmoothingMode.HighQuality;
            thumbGraph.InterpolationMode = InterpolationMode.HighQualityBicubic;
            var imageRectangle = new Rectangle(0, 0, newWidth, newHeight);
            thumbGraph.DrawImage(image, imageRectangle);
            thumbnailImg.Save(targetPath, image.RawFormat);
        }
    }

    protected void cmdSave1_Click(object sender, System.EventArgs e)
    {
        string FlNm, flnm1;
        Session["CkyPinRequest"] = null;
       

        if (TxtAmount.Text == "")
        {
            scrname = "<SCRIPT language='javascript'>alert('Please Enter Amount.');" + "</SCRIPT>";
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Close", scrname, false);
            return;
        }
        if (Convert.ToInt32(TxtAmount.Text) <= 0)
        {
            scrname = "<SCRIPT language='javascript'>alert('Please Enter Amount.');" + "</SCRIPT>";
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Close", scrname, false);
            return;
        }
        //If DdlPaymode.SelectedValue = 0 Then
        //scrname = "<SCRIPT language='javascript'>alert('Choose Paymode');" & "</SCRIPT>"
        //ScriptManager.RegisterClientScriptBlock(Me.Page, Me.[GetType](), "Close", scrname, False)
        //Exit Sub
        //End If
        //If DivBank.Visible = True Then
        //If DDlBank.SelectedValue = 0 Then
        //scrname = "<SCRIPT language='javascript'>alert('Choose Bank Name');" & "</SCRIPT>"
        //ScriptManager.RegisterClientScriptBlock(Me.Page, Me.[GetType](), "Close", scrname, False)
        //Exit Sub
        //End If
        //End If

        if (DdlPaymode.SelectedValue == "0")
        {
            scrname = "<SCRIPT language='javascript'>alert('Choose Paymode.');" + "</SCRIPT>";
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Close", scrname, false);
            return;
        }
        if (DivBank.Visible == true)
            {
            if (DDlBank.SelectedValue == "0")
                {
                scrname = "<SCRIPT language='javascript'>alert('Choose Bank Name.');" + "</SCRIPT>";
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Close", scrname, false);
                return;
            }
        }
        bool flag;
        if ((DdlPaymode.SelectedValue) == "1")
            flag = true;
        else if (divDDno.Visible == true & TxtDDNo.Text == "")
        {
            scrname = "<SCRIPT language='javascript'>alert('" + LblDDNo.Text + " can not be blank');" + "</SCRIPT>";
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Close", scrname, false);
            return;
        }
        else if (CheckDDno() == true)
            flag = true;
        else
            flag = false;
        // End If
        if (TxtDDDate.Text == "")
        {
            scrname = "<SCRIPT language='javascript'>alert('Please select Date');" + "</SCRIPT>";
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Close", scrname, false);
            return;
        }
        string strextension = "";
        try
        {
            if (flag == true)
            {
                string str = "select * from M_MemberMaster where Epassw='" + TxtPassword.Text + "' and Formno=" + Session["Formno"] + "";
                dt1 = obj.GetData(str);
                if (dt1.Rows.Count > 0)
                    SaveRequest();
                else
                {
                    scrname = "<script language='javascript'>alert('Please Enter valid Transaction Password.');</script>";
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Login Error", scrname, false);
                    cmdSave1.Enabled = true;
                }
            }
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff") + Environment.NewLine;
            objDal.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
            Response.Write(ex.Message);
            Response.End();
        }
    }

    protected void DdlPaymode_SelectedIndexChanged(object sender, System.EventArgs e)
    {
        try
        {
            CheckVisible();
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff") + Environment.NewLine;
            objDal.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
            Response.Write(ex.Message);
            Response.End();
        }
    }

    public string ClearInject(string StrObj)
    {
        StrObj = StrObj.Replace(";", "").Replace("'", "").Replace("=", "");
        return StrObj;
    }

    protected void CheckVisible()
    {
        DataTable dt;
        string condition = "";
        // Session("PaymodeDetail") = tmpTable
        dt = (DataTable)Session["PaymodeDetail"];
        DataRow[] Dr = dt.Select("PID='" + DdlPaymode.SelectedValue + "'");
        if (Dr.Length > 0)
        {
            if (Dr[0]["IsBankDtl"].ToString() == "Y")
            {
                DivBank.Visible = true;
            }
            else
            {
                DivBank.Visible = false;
            }
            if (Dr[0]["IsBranchDtl"].ToString() == "Y")
            {
                DivBranch.Visible = true;
            }
            else
            {
                DivBranch.Visible = false;
                TxtIssueBranch.Text = "";
            }
            if (Dr[0]["IsTransNo"].ToString() == "Y")
            { 
            divDDno.Visible = true;
            }
        else
        {
            divDDno.Visible = false;
            TxtDDNo.Text = "";
        }
            if (Dr[0]["AllBank"].ToString() == " ")
            {
                condition = "";
            }
            else if (Dr[0]["AllBank"].ToString() == "N")
            {
                condition = "and MacAdrs='C' and BranChName<>'N'";
            }
            else
            {
                condition = "and MacAdrs='C'";
            }
            if (Dr[0]["Isimage"].ToString() == "N")
            {
                divImage.Visible = false;
            }
            else
            {
                divImage.Visible = true;
            }
            // If Dr(0)("Istransdate") = "N" Then
            // divDDDate.Visible = False
            // Else
            // divDDDate.Visible = True
            // End If

            FillBankMaster(condition);
            LblDDNo.Text = Dr[0]["TransNoLbl"].ToString(); LblDDDate.Text = Dr[0]["TransDateLbl"].ToString();
        }
    }

    protected void TxtDDNo_TextChanged(object sender, System.EventArgs e)
    {
        try
        {
            string s = "";
            DataTable dt;
            dt = new DataTable();
            obj = new DAL();
            if (Convert.ToInt32(DdlPaymode.SelectedValue) != 8)
            {
                if (divDDno.Visible == true)
                {
                    s = "select * from WalletReq where ChqNo='" + (TxtDDNo.Text) + "' and IsApprove<>'R'";
                    dt = obj.GetData(s);
                    if (dt.Rows.Count > 0)
                    {
                        scrname = "<SCRIPT language='javascript'>alert('" + LblDDNo.Text + " already exist');" + "</SCRIPT>";
                        ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Close", scrname, false);
                        cmdSave1.Enabled = false;
                    }
                    else
                        cmdSave1.Enabled = true;
                }
                else
                    cmdSave1.Enabled = true;
            }
        }
        catch (Exception ex)
        {
        }
    }
    protected bool CheckDDno()
    {
        string s = "";
        DataTable dt;
        dt = new DataTable();
        obj = new DAL();
        if (Convert.ToInt32(DdlPaymode.SelectedValue) != 8)
        {
            if (divDDno.Visible == true & TxtDDNo.Text != "")
            {
                s = "select * from WalletReq where ChqNo='" + (TxtDDNo.Text) + "' and IsApprove<>'R'";
                dt = obj.GetData(s);
                if (dt.Rows.Count > 0)
                {
                    scrname = "<SCRIPT language='javascript'>alert('" + LblDDNo.Text + " already exist');" + "</SCRIPT>";
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Close", scrname, false);

                    return false;
                }
                else
                    return true;
            }
            else
                return true;
        }
        else
            return true;
    }


    protected void Page_LoadComplete(object sender, System.EventArgs e)
    {
        try
        {
            CheckVisible();
        }
        // If Conn.State = ConnectionState.Open Then
        // Conn.Close()
        // End If
        catch (Exception ex)
        {
        }
    }

    protected void Page_Unload(object sender, System.EventArgs e)
    {
        try
        {
           //CheckVisible();
        }
        // If Conn.State = ConnectionState.Open Then
        // Conn.Close()
        // End If
        catch (Exception ex)
        {
        }
    }
}
